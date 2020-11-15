/*                        USC ID: 6030870583                                 */
/* Ilia Leschev csci585 Q1 Microsoft SQL Server Management Studio 2018 v18.4*/
/* There are several ways too meet the requirements of the task I          */
/* will provide four of them:                                             */
/* 1)The simplier (in my opinion)                                        */
/* 2)Using function within constraint (table changed)                   */
/* 3)Using function within constraint                                  */
/* 4)Using trigger                                                    */
/* IMPORTANT: if only one solution must be chosen it would be        */
/* soulution #3 and it start under the PREFERED SOLUTION            */
/* comment.                                                        */




/*                 The 'simple' solution                    */
/* So I would simpy require users to create a distinct row */
/* for each hour they would like to use the room. In that */
/* case the table structure is left exactly the same. And*/
/* using constraint restrict enter of invalid hours.    */
/* Invalid hours:                                      */
/* (1) startTime > endTime                            */
/* (2) booking for more than 1 hour span             */
/* (3) booking an off-hour                          */

create table ProjectRoomBookings
(
	roomNum integer not null,
	startTime integer not null,
	endTime integer not null,
	groupName char(10) not null,
	primary key (roomNum,startTime),
	constraint valid_time check (endTime > startTime),
	constraint valid_duration check (endTIme - startTIme = 1),				/* This constraint restricts both (1) and (2) invalid inputs */
	constraint valid_work_hours check (startTime >= 7 and endTime <= 18)   /* This constraint will make sure no off-hour period was     */
);																		  /* booked.                                                   */

/* Examples:                                                           */

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
values(1,7,8,'valid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
values(1,8,9,'valid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
values(1,9,10,'valid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
values(1,8,9,'invalid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
values(2,17,18,'valid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
values(2,18,19,'invalid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
values(3,10,13,'invalid')





/*                Solving the problem with function                */
/* In this case I would need to add a column and change the PK, so*/
/* it may be not acceptible. But it does its work.               */

create table ProjectRoomBookings
(
	bookingId integer not null identity(1,1) primary key,
	roomNum integer not null,
	startTime integer not null,
	endTime integer not null,
	groupName char(10) not null,
	constraint chk_availability check (dbo.IsRoomAvailable(bookingId,roomNum,startTime,endTime)=1))

/* 1) Create distinct PK as bookingId. This is neccessary to apply  */
/* chk_availability constraint. Because MSSQl considers new        */
/* entry part of the table even before actual insert.             */
/* 2)Create constraint chk_availability, which checks room's     */
/* availability for the time and input correctness. The further */
/* description of the constraint is provided below.            */


/* chk_availability constraint uses the user-defined function :*/

create function IsRoomAvailable(@id integer, @roomNum integer, @st integer, @et integer)
returns integer 
as
begin
if @st > @et
	return 0
if @st < 7 or @et > 18
	return 0
if exists (select 1
           from dbo.ProjectRoomBookings pb
		   where pb.roomNum = @roomNum and
		   pb.bookingId ! = @id and
		   pb.endTime > @st and
		   pb.startTime < @et)
		   return 0
	return 1
end


/* The function ensures that:                                   */
/* 1)The occupation time span belongs to the working-day span  */
/* 7am - 6pm (7-18) and startTime < endTime.                  */
/* 2)Checks if there is an overlap with the existing booking.*/
/* returns 1 if all the conditions are satisfied and 0      */
/* otherwise.                                              */
/* The change of the primary key was needed to allow the  */
/* the function to distinct newly added entry from old   */
/* entries, otherwice the time span would always        */
/* overlap with itself.                                */



/*↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓*/
/*                      PREFERED SOLUTION                         */
/*In this solution function within check constraint is used. The */
/*table structure remains the same, only constraint is added:   */

create table ProjectRoomBookings
(
	roomNum integer not null,
	startTime integer not null,
	endTime integer not null,
	groupName char(10) not null,
	primary key (roomNum,startTime),
	constraint chk_availability check (dbo.IsRoomAvailable(roomNum,startTime,endTime,groupName)=1))

/* Due to the reason that MSSQL considers the entry that is only */
/* being tested at the moment as already a part of the table    */
/* both solutions with trigger and function has to include     */
/* except statement in when checking for overlaps. That allows*/
/* not to count out the new entry. Otherwise it would always */
/* overlap with itself. With this being said here is the    */
/* function:                                               */

create function IsRoomAvailable(@roomNum integer, @st integer, @et integer,@gn char(10))
returns integer 
as
begin
if @st > @et
	return 0
if @st < 7 or @et > 18
	return 0
if exists (select *
           from dbo.ProjectRoomBookings pb
		   where pb.roomNum = @roomNum and
		   pb.endTime > @st and
		   pb.startTime < @et
		   except select *
		   from dbo.ProjectRoomBookings new
		   where new.roomNum = @roomNum and
		   new.startTime = @st and
		   new.endTime = @et and
		   new.groupName = @gn)
		   return 0
	return 1
end

/* The function ensures that:                                   */
/* 1)The occupation time span belongs to the working-day span  */
/* 7am - 6pm (7-18) and startTime < endTime.                  */
/* 2)Checks if there is an overlap with the existing booking.*/
/* returns 1 if all the conditions are satisfied and 0      */
/* otherwise.                                              */


/* E.g.                                                                 */

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
  values(3,9,11,'valid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
  values(3,12,14,'valid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
  values(3,14,17,'valid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
 values(3,10,13,'invalid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
 values(3,13,15,'invalid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
 values(4,6,8,'invalid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
  values(4,14,17,'valid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
  values(5,16,19,'invalid')



/*               Solving the problem with trigger                  */
/* Trigger is used here to overcome the issues metioned in the    */
/* task description. The table design looks just like in the     */
/* task description.                                            */

create table ProjectRoomBookings
(
	roomNum integer not null,
	startTime integer not null,
	endTime integer not null,
	groupName char(10) not null,
	primary key (roomNum,startTime)
);																


/* Due to the reason that MSSQL considers the entry that is only */
/* being tested at the moment as already a part of the table    */
/* both solutions with trigger and function has to include     */
/* except statement in when checking for overlaps. That allows*/
/* not to count out the new entry. Otherwise it would always */
/* overlap with itself. With this being said here is the    */
/* trigger:                                                */

create trigger trg_room_available on dbo.ProjectRoomBookings
for insert 
as
declare @st integer
declare @et integer
declare @roomNum integer
declare @overlap integer
declare @gn char(10)
set @roomNum = (select roomNum from Inserted)
set @st = (select startTime from Inserted)
set @et = (select endTime from Inserted)
set @gn = (select groupName from Inserted)
begin
if @st > @et
	begin
		raiserror ('Start time can not be less than end time.',16,1)
		rollback transaction
		return
	end
if @st < 7 or @et > 18
	begin
		raiserror ('Room can not be booked for off-hours.',16,1)
		rollback transaction
		return
	end

if exists (select * from dbo.ProjectRoomBookings pb where pb.roomNum = @roomNum and pb.endTime > @st and pb.startTime < @et 
		   except select * from dbo.ProjectRoomBookings new where new.roomNum = @roomNum and new.startTime = @st and new.endTime = @et and new.groupName = @gn)
	begin
		raiserror ('Room is alredy booked.',16,1)
		rollback transaction
		return
	end
end;

/* The trigger again makes sure that the three conditions are    */
/* met:                                                         */
/* (1) startTime < endTime                                     */
/* (2) the booked span does not belong to off-hours           */
/* (3) no overlaps with already booked rooms                 */

/* P.S. Trigger can be rewritten without the except statement too */
/* but the table structure shuoul be changed as well. (like in   */
/* the solution with function).                                 */

/* E.g.                                                                 */

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
  values(3,9,11,'valid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
  values(3,12,14,'valid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
  values(3,14,17,'valid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
 values(3,10,13,'invalid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
 values(3,13,15,'invalid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
 values(4,6,8,'invalid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
  values(4,14,17,'valid')

insert into dbo.ProjectRoomBookings(roomNum,startTime,endTime,groupName)
  values(5,16,19,'invalid')