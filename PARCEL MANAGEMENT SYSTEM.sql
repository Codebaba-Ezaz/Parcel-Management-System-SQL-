--Author: Ezaz Ahmed Sayem (Github: Codebaba_Ezaz)
-- QUERY 1: Creating the Database
CREATE DATABASE FPMS;

-- QUERY 2: Creating the Table named "customer_info"
CREATE TABLE customer_info (
    cust_id INT PRIMARY KEY IDENTITY(1,1),
    cust_name VARCHAR(255) NOT NULL,
    cust_address VARCHAR(255) NOT NULL,
    cust_age INT NOT NULL,
	cust_gender VARCHAR(255) NOT NULL,
    cust_phone VARCHAR(255) UNIQUE NOT NULL,
    cust_email VARCHAR(255) UNIQUE NOT NULL
);

-- QUERY 3: Creating the Table named "delivery_man_info"
CREATE TABLE delivery_man_info (
    dm_id INT PRIMARY KEY IDENTITY(325,1),
    dm_name VARCHAR(255) NOT NULL,
    dm_address VARCHAR(255) NOT NULL,
    dm_age INT NOT NULL,
	dm_gender VARCHAR(255) NOT NULL,
    dm_phone VARCHAR(255) UNIQUE NOT NULL,
    dm_email VARCHAR(255) UNIQUE NOT NULL
);

-- QUERY 4: Creating the Table named "parcel_info"
CREATE TABLE parcel_info (
    parcel_id INT PRIMARY KEY IDENTITY(1000,1),
    parcel_type VARCHAR(255) NOT NULL,
    parcel_price DECIMAL(5,2) NOT NULL
);

-- QUERY 5: Creating the Table named "order_info"
CREATE TABLE order_info (
    order_id INT PRIMARY KEY IDENTITY(2000,1),
    ocust_id INT NOT NULL,
    opar_id INT NOT NULL,
    order_quan INT NOT NULL,
    order_price DECIMAL(8,2) NOT NULL,
    order_addr VARCHAR(255) NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (ocust_id) REFERENCES customer_info(cust_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (opar_id) REFERENCES parcel_info(parcel_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- QUERY 6: Creating the Table named "delivery_info"
CREATE TABLE delivery_info (
    di_id INT PRIMARY KEY IDENTITY(3245,1),
    ordeli_id INT NOT NULL,
    didm_id INT NOT NULL,
    delivery_date DATE NOT NULL,
    delivery_status VARCHAR(255) NOT NULL,
    FOREIGN KEY (ordeli_id) REFERENCES order_info(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (didm_id) REFERENCES delivery_man_info(dm_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- QUERY 5: Creating the Table named "delivery_location_info". 
CREATE TABLE delivery_location_info(
    location_id INT  PRIMARY KEY IDENTITY(4001,1),
    lord_id INT NOT NULL, 
    location_name VARCHAR(255),
    FOREIGN KEY (lord_id) REFERENCES order_info(order_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- QUERY 6: Insert Data into customer_info


INSERT INTO customer_info (cust_name, cust_address, cust_age, cust_gender, cust_phone, cust_email)
VALUES
('Ezaz Ahmed', 'Dhaka, Bangladesh', 22, 'Male', '+8801712345678', 'ezaz@gmail.com'),
('Fatima Akhtar', 'Chittagong, Bangladesh', 35, 'Female', '+8801912345678', 'fatima@yahoo.com'),
('Rahman Islam', 'Sylhet, Bangladesh', 45, 'Male', '+8801812345678', 'rahman@gmail.com'),
('Aisha Begum', 'Rajshahi, Bangladesh', 30, 'Female', '+8801512345678', 'aisha@yahoo.com'),
('Amirul Haque', 'Khulna, Bangladesh', 33, 'Male', '+8801612345678', 'amirul@gmail.com'),
('Sumaiya Rahman', 'Barishal, Bangladesh', 29, 'Female', '+8801312345678', 'sumaiya@yahoo.com'),
('Jabir Ahmed', 'Rangpur, Bangladesh', 40, 'Male', '+8801412345678', 'jabir@yahoo.com'),
('Nusrat Jahan', 'Comilla, Bangladesh', 27, 'Female', '+8801212345678', 'nusrat@yahoo.com'),
('Arif Hossain', 'Narayanganj, Bangladesh', 32, 'Male', '+8801112345678', 'arif@gmail.com'),
('Sultana Akter', 'Gazipur, Bangladesh', 31, 'Female', '+8801012345678', 'sultana@gmail.com');



SELECT *FROM customer_info

-- QUERY 7 : Insert Data into delivery_man_info


INSERT INTO delivery_man_info (dm_name, dm_address, dm_age, dm_gender, dm_phone, dm_email)
VALUES
('Abir Barua', 'Dhaka, Bangladesh', 22, 'Male', '+8801723456789', 'abir@gmail.com'),
('Farida Akhtar', 'Dhaka, Bangladesh', 29, 'Female', '+8801923456789', 'farida@gmail.com'),
('Mahmud Rahman', 'Sylhet, Bangladesh', 39, 'Male', '+8801823456789', 'mahmud@gmail.com'),
('Nasreen Begum', 'Rajshahi, Bangladesh', 36, 'Female', '+8801523456789', 'nasreen@yahoo.com'),
('Kamal Haque', 'Khulna, Bangladesh', 42, 'Male', '+8801623456789', 'kamal@yahoo.com'),
('Rima Rahman', 'Barishal, Bangladesh', 28, 'Female', '+8801323456789', 'rima@gmail.com'),
('Akram Ahmed', 'Rangpur, Bangladesh', 37, 'Male', '+8801423456789', 'akram@yahoo.com'),
('Farzana Jahan', 'Comilla, Bangladesh', 31, 'Female', '+8801223456789', 'farzana@gmail.com'),
('Zahir Hossain', 'GEC, Bangladesh', 35, 'Male', '+8801123456789', 'zahir@gmail.com'),
('Reshma Akter', 'Gazipur, Bangladesh', 30, 'Female', '+8801023456789', 'reshma@yahoo.com');

SELECT *FROM delivery_man_info

-- QUERY 8 : Insert Data into parcel_info


INSERT INTO parcel_info (parcel_type, parcel_price)
VALUES
('Letter', 50),
('Money Order', 100),
('Furniture', 500),
('Books', 30),
('Flowers', 10.45),
('Documents', 200),
('Vegetables', 120),
('Frozen Food', 300),
('Toys', 70.50),
('Cosmetics', 50);

SELECT *FROM parcel_info

-- QUERY 9 : Insert Data into order_info AND Using The Trigger Of Updating

IF OBJECT_ID('TRG_UpdateOrderPrice', 'TR') IS NOT NULL
    DROP TRIGGER TRG_UpdateOrderPrice;
GO

CREATE TRIGGER TRG_UpdateOrderPrice
ON order_info
AFTER INSERT
AS
BEGIN
    -- Update the order price for all inserted rows where the address does not contain 'Chittagong'
    UPDATE oi
    SET oi.order_price = oi.order_price + 100
    FROM order_info oi
    INNER JOIN inserted i ON oi.order_id = i.order_id
    WHERE i.order_addr COLLATE Latin1_General_CI_AS NOT LIKE '%Chittagong%';
END;
GO
--DELETE FROM order_info;
--DBCC CHECKIDENT ('order_info', RESEED, 1999);

INSERT INTO order_info (ocust_id, opar_id, order_quan,order_price, order_addr, order_date)
VALUES
(1,  1002, 2,100, 'Chawkbazar,Chittagong', '2024-05-12'),
(2,  1001,  1,100, 'Gec,Chittagong', '2024-05-14'),
(3, 1002,  3,1500, 'Jaflong,Sylhet', '2024-05-13'),
(4,  1003, 2,60, 'Gazipur,Dhaka', '2024-05-12'),
(5,  1004,  1,10.45, 'Barisal Port', '2024-05-12'),
(6,  1005,  3,600, 'House #31 Barisal', '2024-05-17'),
(7,  1006,  2,240, 'Rangpur City', '2024-05-21'),
(8,  1007,  1,300, 'Cheora,Cumilla', '2024-05-16'),
(9,  1008,  3,211.5, 'Narayanganj,Dhaka', '2024-05-17'),
(10,  1009, 2,100, 'Gazipur,Dhaka', '2024-05-19');



SELECT *FROM order_info






-- QUERY 10 : Insert Data into delivery_info
INSERT INTO delivery_info (ordeli_id, didm_id, delivery_date, delivery_status)
VALUES
(2000, 325, '2024-05-13', 'Delivered'),
(2001, 326, '2024-05-13', 'Delivered'),
(2002, 327, '2024-05-15', 'Pending'),
(2003, 328, '2024-05-13', 'Pending'),
(2004, 329, '2024-05-19', 'In Transit'),
(2005, 330, '2024-05-22', 'In Transit'),
(2006, 331, '2024-05-23', 'In Transit'),
(2007, 332, '2024-05-18', 'In Transit'),
(2008, 333, '2024-05-19', 'In Transit'),
(2009, 333, '2024-05-21', 'In Transit');

SELECT *FROM delivery_info


-- QUERY 11 : -- Insert Data into delivery_location_info
INSERT INTO delivery_location_info (lord_id, location_name)
VALUES
(2000, 'City Gate Chittagong'),
(2001, 'Chittagong Warehouse'),
(2002, 'Sylhet Sorting Center'),
(2003, 'Rajshahi Depot'),
(2004, 'BArisal Dispatch'),
(2005, 'Barishal Terminal'),
(2006, 'Rangpur Hub'),
(2007, 'Cumilla Distribution'),
(2008, 'Narayanganj Drop-off'),
(2009, 'Gazipur Fulfillment');

SELECT *FROM delivery_location_info




--Find By their Id/Name/Email--
-- QUERY 12: Find customer by ID
SELECT * FROM customer_info WHERE cust_id = 3;

-- QUERY 13: Find customer by name
SELECT * FROM customer_info WHERE cust_name = 'Amirul Haque';

-- QUERY 14: Find customer by mobile
SELECT * FROM customer_info WHERE cust_phone = '+8801312345678';

-- QUERY 15: Find customer by email
SELECT * FROM customer_info WHERE cust_email = 'aisha@yahoo.com';

-- QUERY 16: Find delivery man by ID
SELECT * FROM delivery_man_info WHERE dm_id = 330;

-- QUERY 17: Find delivery man by name
SELECT * FROM delivery_man_info WHERE dm_name = 'Rima Rahman';

-- QUERY 18: Find delivery man by mobile
SELECT * FROM delivery_man_info WHERE dm_phone = '+8801623456789';

-- QUERY 19: Find delivery man by email
SELECT * FROM delivery_man_info WHERE dm_email = 'farzana@gmail.com';

-- QUERY 20: Find parcel by ID
SELECT * FROM parcel_info WHERE parcel_id = 1003;

-- QUERY 21: Find parcel by type
SELECT * FROM parcel_info WHERE parcel_type = 'Flowers';

-- QUERY 22: Find parcel by price
SELECT * FROM parcel_info WHERE parcel_price = 300;

-- QUERY 23: Find order by ID
SELECT * FROM order_info WHERE order_id = 2002;

-- QUERY 24: Find order by customer ID
SELECT * FROM order_info WHERE ocust_id = 6;

-- QUERY 25: Find order by parcel ID
SELECT * FROM order_info WHERE opar_id = 1007;

-- QUERY 26: Find order by address
SELECT * FROM order_info WHERE order_addr = 'RUET';

-- QUERY 27: Find order by date
SELECT * FROM order_info WHERE order_date = '2024-05-19';

-- QUERY 28: Find delivery info by ID
SELECT * FROM delivery_info WHERE di_id = 3255;

-- QUERY 29: Find delivery info by order ID
SELECT * FROM delivery_info WHERE ordeli_id = 2004;

-- QUERY 30: Find delivery info by delivery man ID
SELECT * FROM delivery_info WHERE didm_id = 331;

-- QUERY 31: Find delivery info by delivery date
SELECT * FROM delivery_info WHERE delivery_date = '2024-05-15';

-- QUERY 32: Find delivery location by ID
SELECT * FROM delivery_location_info WHERE location_id = 4007;

-- QUERY 33: Find delivery location by order ID
SELECT * FROM delivery_location_info WHERE lord_id = 2007;

-- QUERY 34: Find delivery location by location name
SELECT * FROM delivery_location_info WHERE location_name = 'Rangpur Hub';



--Find By Id with Related Data--

-- QUERY 35: Find customer by ID with related order information
SELECT ci.*, oi.* 
FROM customer_info ci
INNER JOIN order_info oi ON ci.cust_id = oi.ocust_id
WHERE ci.cust_id = 3;

-- QUERY 36: Find customer by ID with related delivery information
SELECT ci.*, di.* 
FROM customer_info ci
INNER JOIN order_info oi ON ci.cust_id = oi.ocust_id
INNER JOIN delivery_info di ON oi.order_id = di.ordeli_id
WHERE ci.cust_id = 3;

-- QUERY 37: Find delivery man by ID with related delivery information
SELECT dmi.*, di.* 
FROM delivery_man_info dmi
INNER JOIN delivery_info di ON dmi.dm_id = di.didm_id
WHERE dmi.dm_id = 326;

-- QUERY 38: Find parcel by ID with related order information
SELECT pi.*, oi.* 
FROM parcel_info pi
INNER JOIN order_info oi ON pi.parcel_id = oi.opar_id
WHERE pi.parcel_id = 1003;

-- QUERY 39: Find parcel by ID with related delivery information
SELECT pi.*, oi.*, di.* 
FROM parcel_info pi
INNER JOIN order_info oi ON pi.parcel_id = oi.opar_id
INNER JOIN delivery_info di ON oi.order_id = di.ordeli_id
WHERE pi.parcel_id = 1003;

-- QUERY 40: Find order by ID with related customer and delivery information
SELECT oi.*, ci.*, di.*
FROM order_info oi
INNER JOIN customer_info ci ON oi.ocust_id = ci.cust_id
INNER JOIN delivery_info di ON oi.order_id = di.ordeli_id
WHERE oi.order_id = 2002;

-- QUERY 41: Find delivery info by ID with related order and delivery man information
SELECT di.*, oi.*, dmi.*
FROM delivery_info di
INNER JOIN order_info oi ON di.ordeli_id = oi.order_id
INNER JOIN delivery_man_info dmi ON di.didm_id = dmi.dm_id
WHERE di.di_id = 3253;

-- QUERY 42: Find delivery location by ID with related order information
SELECT dli.*, oi.*
FROM delivery_location_info dli
INNER JOIN order_info oi ON dli.lord_id = oi.order_id
WHERE dli.location_id = 4007;


--Date Wise Search--

-- QUERY 43: Date search for customer_info with joins
SELECT ci.*, oi.*, di.*
FROM customer_info ci
LEFT JOIN order_info oi ON ci.cust_id = oi.ocust_id
LEFT JOIN delivery_info di ON oi.order_id = di.ordeli_id
WHERE oi.order_date = '2024-05-19';

-- QUERY 44: Date search for delivery_man_info with joins
SELECT dmi.*, di.*, oi.*
FROM delivery_man_info dmi
LEFT JOIN delivery_info di ON dmi.dm_id = di.didm_id
RIGHT JOIN order_info oi ON di.ordeli_id = oi.order_id
WHERE di.delivery_date = '2024-05-13';

-- QUERY 45: Date search for parcel_info with joins
SELECT pi.*, oi.*, di.*
FROM parcel_info pi
LEFT JOIN order_info oi ON pi.parcel_id = oi.opar_id
INNER JOIN delivery_info di ON oi.order_id = di.ordeli_id
WHERE oi.order_date = '2024-05-17';

-- QUERY 46: Date search for order_info with joins
SELECT oi.*, ci.*, di.*
FROM order_info oi
RIGHT JOIN customer_info ci ON oi.ocust_id = ci.cust_id
LEFT JOIN delivery_info di ON oi.order_id = di.ordeli_id
WHERE oi.order_date = '2024-05-16';

-- QUERY 47: Date search for delivery_info with joins
SELECT di.*, oi.*, dmi.*
FROM delivery_info di
INNER JOIN order_info oi ON di.ordeli_id = oi.order_id
RIGHT JOIN delivery_man_info dmi ON di.didm_id = dmi.dm_id
WHERE di.delivery_date = '2024-05-21';

-- QUERY 48: Date search for delivery_location_info with joins
SELECT dli.*, oi.*, di.*
FROM delivery_location_info dli
LEFT JOIN order_info oi ON dli.lord_id = oi.order_id
FULL JOIN delivery_info di ON oi.order_id = di.ordeli_id
WHERE di.delivery_date = '2024-05-22';

--Date Wise Search(Range)--

SELECT 
    ci.cust_id,
    ci.cust_name,
    ci.cust_address,
    oi.order_id,
    pr.parcel_type,
    oi.order_date
FROM customer_info ci
INNER JOIN order_info oi ON ci.cust_id = oi.ocust_id
INNER JOIN parcel_info pr ON oi.opar_id = pr.parcel_id
WHERE oi.order_date BETWEEN '2024-05-12' AND '2024-05-17';


-- QUERY 50: Retrieve the names of customers along with their IDs and the IDs of the orders they placed within a specific time range
SELECT 
    ci.cust_id,
    ci.cust_name,
    oi.order_id,
	di.delivery_status,
	di.delivery_date
FROM delivery_info di
INNER JOIN order_info oi ON oi.order_id = di.ordeli_id
INNER JOIN customer_info ci ON ci.cust_id = oi.ocust_id
WHERE di.delivery_date BETWEEN '2024-05-14' AND '2024-05-19';


--Total Amount Wise Search--
-- QUERY 51: Total Amount wise search from Tk 40.50 to Tk 300.00
SELECT 
    ci.cust_id,
    ci.cust_name,
    oi.order_id,
    oi.order_price
FROM customer_info ci
INNER JOIN order_info oi ON ci.cust_id = oi.ocust_id
WHERE oi.order_price BETWEEN 40.50 AND 300.00;


--Total Amount Wise Search Max/Min--

-- QUERY 52: Max amount wise search
SELECT 
    ci.cust_id,
    ci.cust_name,
    oi.order_id,
    oi.order_price
FROM customer_info ci
INNER JOIN order_info oi ON ci.cust_id = oi.ocust_id
WHERE  oi.order_price = (SELECT MAX(order_price)
FROM order_info
);

-- QUERY 53: Min amount wise search
SELECT 
    ci.cust_id,
    ci.cust_name,
    oi.order_id,
    oi.order_price
FROM customer_info ci
INNER JOIN order_info oi ON ci.cust_id = oi.ocust_id
WHERE  oi.order_price = (SELECT MIN(order_price)
FROM order_info
);


--Date and Amount Based Search--

-- QUERY 54: Date and amount wise search
SELECT 
    ci.cust_id,
    ci.cust_name,
    oi.order_id,
    oi.order_date,
    oi.order_price
FROM customer_info ci
INNER JOIN order_info oi ON ci.cust_id = oi.ocust_id
WHERE oi.order_date BETWEEN '2024-05-01' AND '2024-05-21'
    AND oi.order_price BETWEEN 10.5 AND 180.00;



--Order By Search--

-- QUERY 55: Order By Search
SELECT 
    ci.cust_id,
    ci.cust_name,
    ci.cust_address,
    ci.cust_age,
    oi.order_id
FROM customer_info ci
JOIN order_info oi ON ci.cust_id = oi.ocust_id
ORDER BY ci.cust_age ASC;

-- QUERY 56: Order By Search
SELECT 
    ci.cust_id,
    ci.cust_name,
    ci.cust_address,
    ci.cust_age,
    oi.order_id
FROM customer_info ci
JOIN order_info oi ON ci.cust_id = oi.ocust_id
ORDER BY ci.cust_age DESC;

--Total Data In a Table--
-- QUERY 57: Total Data in a table
SELECT COUNT(*) AS Total
FROM customer_info ci
JOIN order_info oi ON ci.cust_id = oi.ocust_id

-- QUERY 58: Total Male and Female in Delivery Man and Customer

SELECT 'Male' AS gender,
    (SELECT COUNT(*) FROM customer_info WHERE cust_gender = 'Male') AS customer_count,
    (SELECT COUNT(*) FROM delivery_man_info WHERE dm_gender = 'Male') AS delivery_man_count

UNION ALL

SELECT 'Female' AS gender,
    (SELECT COUNT(*) FROM customer_info WHERE cust_gender = 'Female') AS customer_count,
    (SELECT COUNT(*) FROM delivery_man_info WHERE dm_gender = 'Female') AS delivery_man_count;

	--Like Search--
	-- QUERY 59: Like Search for Name
SELECT *
FROM customer_info ci
WHERE ci.cust_name LIKE '%Ahmed' OR ci.cust_name LIKE '%Rahman%';

--DATA UPDATE WITH JOIN TABLE--

-- QUERY 60: Data Update with Join
UPDATE customer_info
SET cust_age = 21
FROM order_info oi
INNER JOIN customer_info ci ON ci.cust_id = oi.ocust_id
INNER JOIN delivery_info di ON di.ordeli_id=oi.order_id
WHERE ci.cust_name LIKE '%Ahmed' AND di.delivery_status = 'Delivered';

-- QUERY 61: Data Update with Join

UPDATE delivery_info
SET delivery_status = 'In Transit'
FROM order_info oi
INNER JOIN delivery_info di ON oi.order_id = di.ordeli_id
INNER JOIN customer_info ci ON oi.ocust_id = ci.cust_id
WHERE oi.order_date = '2024-05-12'
AND ci.cust_age > 18;


DELETE FROM order_info
WHERE ocust_id = 10
;



