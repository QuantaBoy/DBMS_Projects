create database Zomato;
use Zomato;
create table Customer_Details(
	reg_id int,
    Customer_Name varchar(60),
    address varchar(150),
    pincode int,
    primary key(reg_id,pincode)-- Used Composite Primary Key 
);
desc table zomato.customer_details;
insert into customer_details(reg_id,customer_name,address,pincode)
values
(100,"Ragul","Pondicherry",600009),
(101,"Charles","Pondicherry",600009),
(102,"Praveen raj","Pondicherry",600009);
select*from zomato.customer_details;

create table Deliver_Guys_Details(
	delivery_guy_id int primary key,-- Primary key Is Used 
    guy_name varchar(50),
    age int not null, -- Not Null Factor Is Used 
    salary decimal(10,2)
);
desc table zomato.deliver_guys_details;
insert into deliver_guys_details(delivery_guy_id,guy_name,age,salary)
values
(200,"Aravind",17,12000.00),
(201,"Arjun",18,12500.00),
(202,"Adithya",19,13000.00);
select*from zomato.deliver_guys_details;

alter table deliver_guys_details drop column age;-- here we are using alter key word and we drop the column named as age 
select*from zomato.deliver_guys_details;-- here we using hard removing where there is no trace of data column named as age 

create table order_details(
	reg_id int,
    customer_name varchar(60),
    delivery_guy_id int,
    food_name varchar(100) not null,
    address varchar(150),
    pincode int,
    fare decimal(10,2) check(fare > 0),
    foreign key(reg_id) references customer_details(reg_id),
    foreign key(delivery_guy_id) references deliver_guys_details(delivery_guy_id) 
);
desc table order_details;
insert into order_details(reg_id,customer_name,delivery_guy_id,food_name,address,pincode,fare)
values
(100,"Ragul",200,"Biriyani","Pondicherry",600009,1000),
(101,"Charles",201,"Kuska","pondicherry",600009,800),
(102,"Praveen raj",202,"Mutton Biriyani","pondicherry",600009,1800);
select * from order_details;

alter table order_details add column Cancelled boolean default false; -- default is the keyword which will be default if not specify any values
select*from zomato.order_details;

update order_details set cancelled = true where reg_id = 102;
select*from zomato.order_details;# here i am using the soft copy cancellation or removing the row

-- Making Wanted Error
insert into order_details(reg_id,customer_name,delivery_guy_id,food_name,address,pincode,fare)
values
(104,"Nantha krishnan",200,"Beef Biriyani","chennai",600023,2000);-- I am Expecting error like foriegn key is not match
insert into order_details(reg_id,customer_name,delivery_guy_id,food_name,address,pincode,fare)
values
(102,"Praveen raj",202,"Mutton Biriyani","Pondicherry",600009,-300);-- I am Expecting error like violation 

delete from deliver_guys_details where delivery_guy_id = 200;-- In This I am Expecting To Get Error as deliver_guy_id is linked with other tables

truncate customer_details;
drop table customer_details;
truncate deliver_guys_details;
drop table deliver_guys_details;  
truncate order_details;
drop table order_details;
drop database zomato;