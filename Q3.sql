/*                         USC ID: 6030870583                                  */
/* Ilia Leschev csci585 Q5.1 Microsoft SQL Server Management Studio 2018 v18.4*/
/* The query is shown and descibed below, the code I used to test the        */
/* query follows it.                                                        */

select distinct(PID) from													           /* Here we declare that we need a uniqie project id as output, */			
dbo.q3																		          /* after indicating the name of the table to select from where */
where																				 /* clause is used to restrict the search.                      */
Step = 0 and																		/* We only need those projects which have step 0 and step      */
Status = 'C' and																   /* status 'Complete'. Plus we only want those projects that    */
PID not in (select PID from dbo.q3 where Step != 0 and Status ='C')				  /* have all the rest of the steps to have status 'Waiting',    */
																				 /* thus, correlated subquery is used to select only those PIDs */
																				/* where any status on any step but 0 would be completed, so we*/
																			   /* would not consider those projects as eligible for output.   */

/* I have attached the create/insert commands I used to test the */
/* query below. The table structure and its content are ment to */
/* be exactly (or almost) the same as those provided in the HW */
/* description.                                               */

create table q3
(
	Id integer not null identity(1,1) primary key,
	PID char(4) not null,
	Step integer not null,
	Status char(1) not null
);


insert into dbo.q3 (PID,Step,Status)
values('P100',0,'C')

insert into dbo.q3 (PID,Step,Status)
values('P100',1,'W')

insert into dbo.q3 (PID,Step,Status)
values('P100',2,'W')

insert into dbo.q3 (PID,Step,Status)
values('P201',0,'C')

insert into dbo.q3 (PID,Step,Status)
values('P201',1,'C')

insert into dbo.q3 (PID,Step,Status)
values('P333',0,'W')

insert into dbo.q3 (PID,Step,Status)
values('P333',1,'W')

insert into dbo.q3 (PID,Step,Status)
values('P333',2,'W')

insert into dbo.q3 (PID,Step,Status)
values('P333',3,'W')