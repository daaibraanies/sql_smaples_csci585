/*                         USC ID: 6030870583                                  */
/* Ilia Leschev csci585 Q5.1 Microsoft SQL Server Management Studio 2018 v18.4*/
/* The query is shown and descibed below, the code I used to test the        */
/* query follows it.                                                        */

														 /*                       Explanation                       */
declare @lan1 char(15)									/* Declaring the variable was just useful while developing */
declare @lan2 char(15)								   /* the solution. These lines can be deleted but the        */
declare @lan3 char(15)								  /* variables in the query must be replaced with the        */
set @lan1 = 'JavaScript'							 /* corresponding values. As it mentioned in the task, query*/
set @lan2 = 'Scratch'								/* must work with the other values too. In order to change */
set @lan3 = 'Python'							   /* language variables values should be changed. In order   */
											      /*  to add more languages additional declare and set       */
												 /* statements must be added for each of the new language as*/
												/* well as the new variables must be included int the      */
											   /* enumeration in the query:                               */
											   --E.g. (@lan1,@lan2,@lan3,@lanN)
											 /*(or deleted if the number of languages is being shrinked.*/



select Instructor									/* This query select those instructors who can teach one of the languages listed in the parentheses (one for each languge, so there ara going */
from csci585.dbo.q5								   /* to be duplicates at this stage). 'group by' is then groups the duplicates and having (analogue for 'where' but is used with group by only) */
where Subject IN (@lan1,@lan2,@lan3)			  /* clause is applied to make sure that an instructor has all the three subjects. Aggregate function count() is used to count the number of    */
group by Instructor								 /* entries in each group so that only those group that have 3 entries will be displayed as result.                                            */
having count(*) = 3


/* I have attached the create/insert commands I used to test the */
/* query below. The table structure and its content are ment to */
/* be exactly (or almost) the same as those provided in the HW */
/* description.                                               */

create table q5
(
	Id integer not null identity(1,1) primary key,
	Instructor char(15) not null,
	Subject char(15) not null
);

insert into dbo.q5 (Instructor,Subject)
values ('Aleph','Scratch')

insert into dbo.q5 (Instructor,Subject)
values ('Aleph','Java')

insert into dbo.q5 (Instructor,Subject)
values ('Aleph','Processing')

insert into dbo.q5 (Instructor,Subject)
values ('Bit','Python')

insert into dbo.q5 (Instructor,Subject)
values ('Bit','JavaScript')

insert into dbo.q5 (Instructor,Subject)
values ('Bit','Java')

insert into dbo.q5 (Instructor,Subject)
values ('CRC','Python')

insert into dbo.q5 (Instructor,Subject)
values ('CRC','JavaScript')

insert into dbo.q5 (Instructor,Subject)
values ('Dat','JavaScript')

insert into dbo.q5 (Instructor,Subject)
values ('Dat','Scratch')

insert into dbo.q5 (Instructor,Subject)
values ('Dat','Python')

insert into dbo.q5 (Instructor,Subject)
values ('Emscr','Scratch')

insert into dbo.q5 (Instructor,Subject)
values ('Emscr','Processing')

insert into dbo.q5 (Instructor,Subject)
values ('Emscr','JavaScript')

insert into dbo.q5 (Instructor,Subject)
values ('Emscr','Python')