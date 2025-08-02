Create database Adventure_Works;

use Adventure_Works;

-- Union of Fact Internet sales and Fact internet_sales_new

select * from fact_internet_sales_new inner join factinternetsales
on fact_internet_sales_new.ProductKey = factinternetsales.ProductKey;

-- Alter table Dimcustomer by adding Customer_Full_Name Using Concate Function

alter table dimcustomer  add column customer_Fullname varchar(150);
update dimcustomer set customer_Fullname = concat(FirstName,MiddleName,LastName);

-- 1. Calculate Customer_Full name with Profit

select customer_Fullname, round(sum(Profit)) As Profit 
from dimcustomer inner join sales 
on dimcustomer.CustomerKey = sales.CustomerKey
group by customer_Fullname
order by Profit desc limit 5;

-- 2.Top 5 Customer name yearly income 

select customer_Fullname,Gender, YearlyIncome from dimcustomer
order by YearlyIncome desc limit 5; 

-- Year
--  B.Monthno
-- C.Monthfullname
-- D.Quarter(Q1,Q2,Q3,Q4)
-- E. YearMonth ( YYYY-MMM)
-- F. Weekdayno
-- G.Weekdayname
--  H.FinancialMOnth
-- I. Financial Quarter 

select distinct CalendarYear from dimdate;
select MonthNumberOfYear  from dimdate;
select EnglishMonthName  from dimdate;
select CalendarQuarter  from dimdate;
select CalendarYear,EnglishMonthName  from dimdate;
select EnglishDayNameOfWeek  from dimdate;
select FiscalQuarter  from dimdate;
select EnglishMonthName from dimdate;


-- 3.Calculate the Top 5 Product wise profit 

select EnglishProductName,round(sum(profit)) profit From dimproduct
inner join sales on sales.productkey = dimproduct.ProductKey
group by  EnglishProductName 
order by profit desc limit 5;
 
-- .Calculate the botom 5 Product wise profit 

select EnglishProductName,round(sum(profit)) profit From dimproduct
inner join sales on sales.productkey = dimproduct.ProductKey
group by  EnglishProductName 
order by profit asc limit 5;

-- 4.Calculate the Top 5 Sub-Product wise profit 

select EnglishProductSubcategoryName,round(sum(profit),2) as profit From dimproductsubcategory
inner join dimproduct on  dimproduct.ProductSubcategoryKey = dimproductsubcategory.ProductCategoryKey 
inner join sales on dimproduct.ProductKey = sales.productkey
group by  EnglishProductSubcategoryName 
order by profit desc;

 -- 5.Calculate the Category wise profit 
Select EnglishProductCategoryName,round(sum(profit),2) as profit from dimproductcategory
inner join dimproductsubcategory on dimproductcategory.ProductCategoryKey = dimproductsubcategory.ProductCategoryKey
inner join dimproduct on dimproductsubcategory.ProductSubcategoryKey = dimproduct.ProductSubcategoryKey
inner join sales on dimproduct.ProductKey = sales.productkey
group by EnglishProductCategoryName
order by profit desc;
 
--  6.Calculate Top 5 Territory Country wise Profit

select SalesTerritoryCountry,round(sum(Sales)) as Territory_Country_Profit
from dimsalesterritory join Sales on dimsalesterritory.SalesTerritoryKey = sales.SalesTerritoryKey
group by SalesTerritoryCountry
order by Territory_Country_Profit desc limit 5;

--  Calculate bottom 5 Territory Country wise Profit

select SalesTerritoryCountry,round(sum(Sales)) as Territory_Country_Profit
from dimsalesterritory join Sales on dimsalesterritory.SalesTerritoryKey = sales.SalesTerritoryKey
group by SalesTerritoryCountry
order by Territory_Country_Profit asc limit 5;

-- 7.To Calculate Total Profit in Million
select round( sum(profit)/1000000,2) as Total_Profit_in_Million From sales;
 
-- 7.To Calculate Total Sales in Million
select round( sum(Sales)/1000000,2) as Total_Profit_in_Million From sales;

-- 7 .To Calculate Total_Production_Cost in Million
select round(sum(Production_Cost)/1000000,2) as Total_Production_Cost From sales;




-- REST QUESTION IN TABLEAU --





