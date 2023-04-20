

-- The Data Sets -----------------------------------------------------
SELECT * 
FROM my_finance_projectV3..spy_historical_data;

SELECT * 
FROM my_finance_projectV3..qqq_historical_data;

SELECT * 
FROM my_finance_projectV3..wix_historical_data;

SELECT * 
FROM my_finance_projectV3..wix_biggest_shareholders;

SELECT * 
FROM my_finance_projectV3..gddy_historical_data;

SELECT * 
FROM my_finance_projectV3..sqsp_historical_data;

SELECT *
FROM general_info;

SELECT * 
FROM financials;

-- The Data Sets -----------------------------------------------------

-- reformatting the tables -------------------------------------------

-----------------------------------------------------------------------

ALTER TABLE my_finance_projectV3..spy_historical_data
ADD Change FLOAT;

UPDATE my_finance_projectV3..spy_historical_data
SET Change = [Change %] * 100;

ALTER TABLE my_finance_projectV3..spy_historical_data
ADD trade_date Date;

UPDATE my_finance_projectV3..spy_historical_data
SET trade_date = CONVERT(Date, [Date]);

-----------------------------------------------------------------------

ALTER TABLE my_finance_projectV3..qqq_historical_data
ADD Change FLOAT;

UPDATE my_finance_projectV3..qqq_historical_data
SET Change = [Change %] * 100;

ALTER TABLE my_finance_projectV3..qqq_historical_data
ADD trade_date Date;

UPDATE my_finance_projectV3..qqq_historical_data
SET trade_date = CONVERT(Date, [Date]);


-----------------------------------------------------------------------

ALTER TABLE my_finance_projectV3..gddy_historical_data
ADD Change FLOAT;

UPDATE my_finance_projectV3..gddy_historical_data
SET Change = [Change %] * 100;

ALTER TABLE my_finance_projectV3..gddy_historical_data
ADD trade_date Date;

UPDATE my_finance_projectV3..gddy_historical_data
SET trade_date = CONVERT(Date, [Date]);


-----------------------------------------------------------------------

ALTER TABLE my_finance_projectV3..wix_historical_data
ADD Change FLOAT;

UPDATE my_finance_projectV3..wix_historical_data
SET Change = [Change %] * 100;

ALTER TABLE my_finance_projectV3..wix_historical_data
ADD trade_date Date;

UPDATE my_finance_projectV3..wix_historical_data
SET trade_date = CONVERT(Date, [Date]);


-----------------------------------------------------------------------

ALTER TABLE my_finance_projectV3..sqsp_historical_data
ADD Change FLOAT;

UPDATE my_finance_projectV3..sqsp_historical_data
SET Change = [Change %] * 100;

ALTER TABLE my_finance_projectV3..sqsp_historical_data
ADD trade_date Date;

UPDATE my_finance_projectV3..sqsp_historical_data
SET trade_date = CONVERT(Date, [Date]);


-----------------------------------------------------------------------

-- reformatting the tables --------------------------------------------



---------------------------------- Table 1 ----------------------------------

-- Shows Top 5 Wix Best Stock Trade Days
SELECT TOP 5  trade_date, price, [open], [high], [vol#] AS Volume, 
Change
FROM my_finance_projectV3..wix_historical_data
WHERE Change > 10 
ORDER BY Change DESC;

---------------------------------- Table 1 ----------------------------------


---------------------------------- Table 2 ----------------------------------

-- Shows Top 5 Wix Worst Stock Trade Days
SELECT TOP 5  trade_date, price, [open], [high], [vol#] AS Volume, 
Change
FROM my_finance_projectV3..wix_historical_data
WHERE Change < -10 
ORDER BY Change ASC;

---------------------------------- Table 2 ----------------------------------


---------------------------------- Table 3 ----------------------------------

--Shows WIX stock price per day of trade
SELECT trade_date, Price
FROM my_finance_projectV3..wix_historical_data
ORDER BY trade_date ASC;

---------------------------------- Table 3 ----------------------------------


---------------------------------- Table 4 ----------------------------------

-- A Comparison between wix and its Competitors 
SELECT wix.trade_date,
wix.price AS wix_price,
sqsp.price AS sqsp_price,
gddy.price AS gddy_price
FROM my_finance_projectV3..wix_historical_data wix
JOIN my_finance_projectV3..sqsp_historical_data sqsp
	ON wix.trade_date = sqsp.trade_date 
JOIN my_finance_projectV3..gddy_historical_data gddy
	ON wix.trade_date = gddy.trade_date 
ORDER BY trade_date;

---------------------------------- Table 4 ----------------------------------


---------------------------------- Table 5 ----------------------------------

-- Counting how many Positive and Negative days WIX had 
SELECT
COUNT(CASE
	  WHEN Change > 0 THEN 1
	  END) AS positive_days,
COUNT(CASE
	  WHEN Change < 0 THEN 1
	  END) AS negative_days
FROM my_finance_projectV3..wix_historical_data;

---------------------------------- Table 5 ----------------------------------


---------------------------------- Table 6 ----------------------------------

SELECT *, [%] * 100 AS Stake
FROM my_finance_projectV3..wix_biggest_shareholders;

---------------------------------- Table 6 ----------------------------------


---------------------------------- Table 7 ----------------------------------

-- WIX Performance Compared to the S&P500 and NASDAQ
SELECT wix.trade_date,
wix.price AS wix_price,
spy.price AS spy_price,
qqq.price AS qqq_price
FROM my_finance_projectV3..wix_historical_data AS wix
JOIN my_finance_projectV3..spy_historical_data AS spy
ON wix.trade_date = spy.trade_date
JOIN my_finance_projectV3..qqq_historical_data AS qqq
ON qqq.trade_date = wix.trade_date;


---------------------------------- Table 7 ----------------------------------

---------------------------------- Table 8 ----------------------------------

-- Adding general information 

CREATE TABLE market_cup (
market_cup FLOAT,
EPS FLOAT, 
one_year_target_est FLOAT,
Beta FLOAT
);

INSERT INTO market_cup (market_cup, EPS, one_year_target_est, Beta)
VALUES (5495000000, -7.07, 107.25, 1.21);

EXEC sp_rename 'market_cup', 'general_info';

SELECT * FROM general_info;

---------------------------------- Table 8 ----------------------------------

---------------------------------- Table 9 ----------------------------------

-- adding earnings and revenue of wix and its competitors

CREATE TABLE financials 
(
	year INT, 
	revenue_wix FLOAT,
	earnings_wix FLOAT, 
	revenue_gddy FLOAT,
	earnings_gddy FLOAT, 
	revenue_sqsp FLOAT,
	earnings_sqsp FLOAT 
);

INSERT INTO financials (year, revenue_wix, earnings_wix, revenue_gddy, earnings_gddy, revenue_sqsp, earnings_sqsp)
VALUES (2019, 757670000, -87750000, 2990000000, 137000000 , 484750000 , 58150000 );

INSERT INTO financials (year, revenue_wix, earnings_wix, revenue_gddy, earnings_gddy, revenue_sqsp, earnings_sqsp)
VALUES (2020, 984370000, -166870000, 3320000000 , -495100000 , 621150000 , 30590000 ),
	   (2021, 1270000000, -117210000, 3820000000, 242300000, 784040000, -249150000), 
	   (2022, 1390000000, -424860000, 4090000000, 352200000, 866970000, -252220000);   

SELECT * FROM financials;


---------------------------------- Table 9 ----------------------------------


