/*                         USC ID: 6030870583                                  */
/* Ilia Leschev csci585 Q5.1 Microsoft SQL Server Management Studio 2018 v18.4*/
/* The query is shown and descibed below, the code I used to test the        */
/* query follows it.                                                        */

select distinct(ClassName), count(SID) as Total			/* Here we declare that we want to see output structure as unique class names and total number of students in each class */
from dbo.q2												/* the result of aggregate function count() is then said to be displayed as 'Total' according to the output example.    */
group by ClassName										/* We used group by to with the count function (any aggregate function in general).                                    */
order by (Total) desc									/* To display class participants sorted in reverse order command order by with desc option is used.                   */


/* I have attached the create/insert commands I used to test the */
/* query below. The table structure and its content are ment to */
/* be exactly (or almost) the same as those provided in the HW */
/* description.                                               */

create table q2 
(
	Id integer not null identity(1,1) primary key,
	SID integer not null,
	ClassName char(15) not null,
	Grade char(1) not null
);

insert dbo.q2 (SID,ClassName,Grade) 
values (123,'Processing','A')

insert dbo.q2 (SID,ClassName,Grade) 
values (123,'Python','B')

insert dbo.q2 (SID,ClassName,Grade) 
values (123,'Scratch','B')

insert dbo.q2 (SID,ClassName,Grade) 
values (662,'Java','B')

insert dbo.q2 (SID,ClassName,Grade) 
values (662,'Python','A')

insert dbo.q2 (SID,ClassName,Grade) 
values (662,'JavaScript','A')

insert dbo.q2 (SID,ClassName,Grade) 
values (662,'Scratch','B')

insert dbo.q2 (SID,ClassName,Grade) 
values (345,'Scratch','A')

insert dbo.q2 (SID,ClassName,Grade) 
values (345,'JavaScript','B')

insert dbo.q2 (SID,ClassName,Grade) 
values (345,'Python','A')

insert dbo.q2 (SID,ClassName,Grade) 
values (555,'JavaScript','B')

insert dbo.q2 (SID,ClassName,Grade) 
values (555,'Python','B')