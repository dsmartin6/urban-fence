-- Group 2: The Urban Fence Restaurant Database
-- Group Members: Amaya Alisca, Deandra Martin, Alex Mayer, Cam Reeves
-- CMS 375
-- Due Date: 4/22/2021

-- TABLE DEFINITIONS -- 
DROP database IF EXISTS Restaurant;
CREATE database Restaurant;
USE Restaurant;

drop table if exists Customer_T;
-- Customer Table definition --
create table Customer_T (
	Customer_ID		int not null,
    Name			varchar(25),
    Contact			char(14),	
	constraint Customer_pk primary key (Customer_ID));
    
------------------------------------------------------------------    
    
drop table if exists Chef_T;    
-- Chef Table definition --
create table Chef_T (
	Chef_ID			char(3) not null,
    Name			varchar(25) not null,
    Phone_Number	char(14) not null,
    constraint Chef_pk primary key (Chef_ID));

------------------------------------------------------------------

drop table if exists Order_T;    
-- Order table definition -- 
create table Order_T (
	Order_ID		char(5) not null,
    Customer_ID		int not null,
    constraint Order_pk primary key (Order_ID),
    constraint Order_fk foreign key (Customer_ID) references Customer_T(Customer_ID));
    
------------------------------------------------------------------

drop table if exists Shift_T;    
-- Shift table definition --
create table Shift_T (
	Chef_ID			char(3) not null,
    Shift			varchar(30) not null,
    constraint Shift_pk primary key (Chef_ID, Shift),
    constraint Shift_fk foreign key (Chef_ID) references Chef_T(Chef_ID));
    
------------------------------------------------------------------

drop table if exists Food_Item_T; 
-- Food Item table definition --
create table Food_Item_T (
	Name			varchar(35) not null,
	Chef_ID			char(3) not null,
    Price			Decimal(4,2),
    constraint Food_Item_pk primary key (Name),
    constraint Food_Item_fk1 foreign key (Chef_ID) references Chef_T(Chef_ID));
    
------------------------------------------------------------------
    
drop table if exists Ingredients_T;
-- Ingredients table definition --
create table Ingredients_T (
	Food_Name		varchar(35) not null,
    Ingredient		varchar(35) not null,
    constraint Ingredients_pk primary key (Food_Name, Ingredient),
    constraint Ingredients_fk foreign key (Food_Name) references Food_Item_T(Name));

------------------------------------------------------------------
    
drop table if exists Order_Line_T;
-- OrderLine table definition -- 
create table Order_Line_T (
	Order_ID		char(5) not null,
    Food_Name		varchar(35) not null,
    Quantity		int not null,
    constraint Order_Line_pk primary key (Order_ID, Food_Name),
    constraint Order_Line_fk1 foreign key (Order_ID) references Order_T(Order_ID),
    constraint Order_Line_fk2 foreign key (Food_Name) references Food_Item_T(Name));
    
------------------------------------------------------------------
    
drop table if exists Payment_T;
-- Payment table definition -- 
create table Payment_T (
	Payment_ID		char(5) not null,
    Order_ID		char(5) not null,
    Date			date not null,
    Payment_Type	varchar(6),
		check(Payment_Type in ("Cash", "Credit", "Coupon")), -- these are the only accepted payment methods
    constraint Payment_pk primary key (Payment_ID),
    constraint Payment_fk foreign key (Order_ID) references Order_T(Order_ID));
    
------------------------------------------------------------------
    
drop table if exists Cash_T;
-- Sub class Cash table definition -- 
create table Cash_T (
	Cash_ID			char(5) not null,
    IfChange		varchar(3) not null,
    constraint Cash_pk primary key (Cash_ID),
    constraint Cash_fk foreign key (Cash_ID) references Payment_T(Payment_ID));
    
------------------------------------------------------------------
    
drop table if exists Credit_T;
-- Sub class Credit table definition --
create table Credit_T (
	Card_ID			char(5) not null,
    Card_Type		varchar(25) not null,
    Currency_Type	varchar(3) not null,
    constraint Credit_pk primary key (Card_ID),
    constraint Credit_fk foreign key (Card_ID) references Payment_T(Payment_ID));
    
------------------------------------------------------------------
    
drop table if exists Coupon_T;
-- Sub class Coupon table definition --
create table Coupon_T (
	Coupon_ID		char(5) not null,
    Promo_Code		char(6) not null,
    Discount_Amnt	Decimal(4,2),
    constraint Coupon_pk primary key (Coupon_ID),
    constraint Coupon_fk foreign key (Coupon_ID) references Payment_T(Payment_ID));
    

commit;