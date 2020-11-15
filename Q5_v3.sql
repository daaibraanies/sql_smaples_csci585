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
												--inner join dbo.q5 N on a.Instructor = N.Instructor
												--...
												--and
												--N.Subject = @lanN
											 /* must be added to the query for each new language.      */
											/* (or deleted if the number of languages is being        */
										   /*  shrinked.                                             */



select distinct(a.Instructor) from dbo.q5 a							/* This query uses multiple joins of the same table basically multyplying rows with equal Instructors by themselves */
inner join dbo.q5 b on a.Instructor = b.Instructor				   /* this allow to address to the same column in different rows with the same Instructor all at once so that 'where'  */
inner join dbo.q5 c on a.Instructor = c.Instructor				  /* clause is simply several conditions combined by and's. Distinct is used to remove repeationg names of Instructors*/
where															 /* which is possible, since, each instructor has an entry for each of the skills he has.                            */
a.Subject = @lan1																		
and															   	
b.Subject = @lan2
and
c.Subject = @lan3