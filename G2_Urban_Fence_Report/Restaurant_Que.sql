-- Group 2: The Urban Fence Restaurant Database
-- Group Members: Amaya Alisca, Deandra Martin, Alex Mayer, Cam Reeves
-- CMS 375
-- Due Date: 4/22/2021

-- QUERIES -- 
-- to find the price of chicken and rice
select Price from Food_Item_T where Name = 'Chicken and Rice';

-- to find all payment methods accepted
select distinct Payment_Type from Payment_T;

-- list in order the names and phone number of chef(s) who worked on the M T F ST 2:00 PM - 10:00 PM shift
select Name, Phone_Number from Chef_T, Shift_T where Chef_T.Chef_ID = Shift_T.Chef_ID and Shift = 'M T F ST 2:00 PM - 10:00 PM' order by Name;

-- to find out the payment method used for order ODR06
select Payment_Type from Payment_T where Order_ID = 'ORD06';

-- to find out how many people participate in each promotion
select Promo_Code, count(Promo_Code) as 'No. of Participants' from Coupon_T group by Promo_Code;

-- list the ingredients for a Chicken and rice
select distinct Ingredient from Ingredients_T, Food_Item_T where Food_Name = Name and Food_Name = 'Chicken and rice';

-- to find out which customers purchased from the restaurant more than once 
select Customer_t.Name, count(Order_t.Customer_ID) as 'Times purchased' from customer_t, Order_T where Customer_t.Customer_ID = order_t.customer_id group by Customer_T.Name having count(Order_t.Customer_ID) > 1;

-- find the food items ordered in quantities over 2
select Food_Name, max(Quantity) from Order_Line_T group by Food_Name having max(Quantity) > 2;

-- get name and contact for all customers who ordered the pot roast
select Customer_T.Name, Contact from Customer_T, Order_T, Order_Line_T where Customer_T.Customer_ID = Order_T.Customer_ID and Order_T.Order_ID = Order_Line_T.Order_ID and Order_Line_T.Food_Name = 'Pot Roast';

-- get a list of meals made with chicken
select distinct Food_Name from Ingredients_T where Food_Name like '%chicken%' or Ingredient like '%chicken%';

-- get the available dishes and their prices
Select Name, Price from Food_Item_T;

-- get the average price of food items on menu
select avg(Price) as 'Average Price' from Food_Item_T;

-- get the promocode of coupon PR010
select Promo_Code from Coupon_T where Coupon_ID = 'PR010';

-- get all chefs who start working on Monday, list alphabetically
select Chef_T.Chef_ID, Name, Phone_Number from Chef_T, Shift_T where Chef_T.Chef_ID = Shift_T.Chef_ID and Shift like 'M%' order by Name;

-- get order total of ORD16
select sum(Quantity * Price) as 'Order Total for ORD16' from Order_Line_T, Food_Item_T where Food_Name = Name and Order_ID = 'ORD16';

-- find out how many ingredients are in each food item
select Name, count(Ingredient) as 'No. of Ingredients' from Food_Item_T, Ingredients_T where Name = Food_Name group by Name;

-- how many customers paid with cash
select count(distinct Customer_t.customer_id) as 'Paid Cash' from Customer_t, order_t, payment_t where customer_t.customer_id = order_t.customer_id
and order_t.order_id = payment_t.order_id and payment_type = 'cash';

-- Display all chefs with the letter s in them 
Select * from Chef_t where Name like 'a%';

-- get list of order ids and payment types where payment was made between 2021-01-15 and 2021-02-20
-- list in desc order
select Order_ID, Payment_ID, Date from Payment_T where Date between '2021-01-15' and '2021-02-20' order by Date desc;

-----------------------------------------------------

-- OTHER DML COMMANDS --

-- to change the discount amount of promocode save15
Update Coupon_T set Discount_Amnt = 05.00 where Promo_Code = 'Save15';

-- update the price of food item ribs
Update Food_Item_T set Price = 29.00 where Name = 'Ribs';

-- add a new item to the available dishes
insert into Food_Item_T values('Spinach and Ham', '101', 12.30);

-- change chef 104's shift
Update Shift_T set Shift = 'SN M T W 6:00 AM - 2:00 PM' where Chef_ID = '104';

-- delete French Dip Sandwiches from the ingredients table
Delete from Ingredients_T where Food_Name = 'French Dip Sandwiches';