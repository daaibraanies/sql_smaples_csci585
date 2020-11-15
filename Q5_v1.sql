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
												/* well as another lines:                                  */
												--and
												--Instructor in (select Instructor from dbo.q5 where Subject = @lanN)
											 /* must be added to the end of the query for each new      */
											/* language. (or deleted if the number of languages is     */
										   /* being shrinked.                                         */



select distinct(Instructor) from dbo.q5 a									     /* Since the same Instructor can have several skills, Instructors name will be selected for each of the satisfied condition. */
where																			/* In order to get rid of duplicates the distinct statement is used. Further, the query uses subquery for each of the clause.*/
Instructor in (select Instructor from dbo.q5 where Subject = @lan1)			   /* In this case we have 3 languages and 3 subqueries accordingly. Each subquery simply selects the instructors who know a    */
and																		      /* particular language. Finally those who are present in each of the subquery results are selected as a result of the main   */
Instructor in (select Instructor from dbo.q5 where Subject = @lan2)		     /* query.																												      */
and
Instructor in (select Instructor from dbo.q5 where Subject = @lan3)



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