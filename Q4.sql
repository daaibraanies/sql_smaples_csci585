/*                         USC ID: 6030870583                                  */
/* Ilia Leschev csci585 Q5.1 Microsoft SQL Server Management Studio 2018 v18.4*/
/* The query is shown and descibed below, the code I used to test the        */
/* query follows it.                                                        */

delete from dbo.q4																/* This line declares on which table the delete command will be executed. */
where SameFam is NULL and													   /* It is followed by where clause just like in 'select' queries. So the   */
ID in (select SameFam from dbo.q4 where SameFam is not null)				  /* the first condition we are looking to be met is SameFam having NULL    */
																			 /* to meet the second condition the subquery was written. It selects      */
																			/* values from SameFam which are not NULLs i.e. refer to another family   */
																		   /* member. Meeting both conditions means that there is yet another family */
																		  /* member and even if this one will be deleted the family still will get  */
																		 /* the email.                                                             */


/* I have attached the create/insert commands I used to test the */
/* query below. The table structure and its content are ment to */
/* be exactly (or almost) the same as those provided in the HW */
/* description.                                               */

create table q4
(
	entryId integer not null identity(1,1) primary key,
	Name char(15) not null,
	Address char(1) not null,
	ID integer not null,
	SameFam integer
)


insert into dbo.q4 (Name,Address,ID,SameFam)
values ('Alice','A',10,NULL)

insert into dbo.q4 (Name,Address,ID,SameFam)
values ('Bob','B',15,NULL)

insert into dbo.q4 (Name,Address,ID,SameFam)
values ('Carmen','C',22,NULL)

insert into dbo.q4 (Name,Address,ID,SameFam)
values ('Diego','A',9,10)

insert into dbo.q4 (Name,Address,ID,SameFam)
values ('Ella','B',3,15)

insert into dbo.q4 (Name,Address,ID,SameFam)
values ('Farkhad','D',11,NULL)