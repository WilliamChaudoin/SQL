--										Database Creation For Analysis In SSMS

--This file creates a database and tables to fill that database for analysis and experimentation. 
--All lines are original and the data was created from physical reference due to difficulty in obtaining the original files. 

--Creating The Database To Fill With Data
CREATE DATABASE GUIDE;

--Instructing Program To Use The Database
USE GUIDE;

--Creating MARINA Table For Alexamara Marina Group
CREATE TABLE MARINA
(MARINA_NUM CHAR(4) PRIMARY KEY NOT NULL,
NAME VARCHAR(20),
ADDRESS VARCHAR(15),
CITY VARCHAR(15),
STATE CHAR(2),
ZIP CHAR(5) );

--Creating OWNER Table For Alexamara Marina Group
CREATE TABLE OWNER
(OWNER_NUM CHAR(4) PRIMARY KEY NOT NULL,
LAST_NAME VARCHAR(30),
FIRST_NAME VARCHAR(20),
ADDRESS VARCHAR(15),
CITY VARCHAR(15),
STATE CHAR(2),
ZIP CHAR(5) );

--Creating MARINA_SLIP Table For Alexamara Marina Group
CREATE TABLE MARINA_SLIP
(SLIP_ID INT PRIMARY KEY NOT NULL,
MARINA_NUM CHAR(4),
SLIP_NUM VARCHAR(3),
LENGTH INT,
RENTAL_FEE DECIMAL(8,2),
BOAT_NAME VARCHAR(30),
BOAT_TYPE VARCHAR(30),
OWNER_NUM CHAR(4) );

--Creating SERVICE_CATEGORY TABLE For Alexamara Marina Group
CREATE TABLE SERVICE_CATEGORY
(CATEGORY_NUM INT PRIMARY KEY NOT NULL,
CATEGORY_DESCRIPTION VARCHAR(255) );

--Creating SERVICE_REQUEST Table For Alexamara Marina Group
CREATE TABLE SERVICE_REQUEST
(SERVICE_ID INT PRIMARY KEY NOT NULL,
SLIP_ID INT,
CATEGORY_NUM INT,
DESCRIPTION VARCHAR(255),
STATUS VARCHAR(255),
EST_HOURS INT,
SPENT_HOURS INT,
NEXT_SERVICE_DATE VARCHAR(10) );

--Adding Values To MARINA Table
INSERT INTO MARINA VALUES
('1', 'Alexamara East', '108 2nd Ave.', 'Brinman', 'FL', '32273'),
('2', 'Alexamara Central', '283 Branston', 'W. Brinman', 'FL', '32274');

--Adding Values To Owner Table
INSERT INTO OWNER VALUES
('AD57', 'Adney', 'Bruce and Jean', '208 Citrus', 'Bowton', 'FL', '31313'),
('AN75', 'Anderson', 'Bill', '18 Wilcox', 'Glander Bay', 'FL', '31044'),
('BL72', 'Blake', 'Mary', '2672 Commodore', 'Bowton', 'FL', '31313'),
('EL25', 'Elend', 'Sandy and Bill', '462 Riverside', 'Rivard', 'FL', '31062'),
('FE82', 'Feenstra', 'Daniel', '7822 Coventry', 'Kaleva', 'FL', '32521'),
('JU92', 'Juarez', 'Maria', '8922 Oak', 'Rivard', 'FL', '31062'),
('KE22', 'Kelly', 'Alyssa', '5271 Waters', 'Bowton', 'FL', '31313'),
('NO27', 'Norton', 'Peter', '2811 Lakewood', 'Lewiston', 'FL', '32765'),
('SM72', 'Smeltz', 'Becky and Dave', '922 Garland', 'Glander Bay', 'FL', '31044'),
('TR72', 'Trent', 'Ashton', '922 Crest', 'Bay Shores', 'FL', '30992');

--Adding Values To MARINA_SLIP Table
INSERT INTO MARINA_SLIP VALUES
(1, '1', 'A1', 40, 3800.00, 'Anderson II', 'Sprite 4000', 'AN75'),
(2, '1', 'A2', 40, 3800.00, 'Our Toy', 'Ray 4025', 'EL25'),
(3, '1', 'A3', 40, 3600.00, 'Escape', 'Sprite 4000', 'KE22'),
(4, '1', 'B1', 30, 2400.00, 'Gypsy', 'Dolphin 28', 'JU92'),
(5, '1', 'B2', 30, 2600.00, 'Anderson III', 'Sprite 3000', 'AN75'),
(6, '2', '1', 25, 1800.00, 'Bravo', 'Dolphin 25', 'AD57'),
(7, '2', '2', 25, 1800.00, 'Chinook', 'Dolphin 22', 'FE82'),
(8, '2', '3', 25, 2000.00, 'Listy', 'Dolphin 25', 'SM72'),
(9, '2', '4', 30, 2500.00, 'Mermaid', 'Dolphin 28', 'BL72'),
(10, '2', '5', 40, 4200.00, 'Axxon II', 'Dolphin 40', 'NO27'),
(11, '2', '6', 40, 4200.00, 'Karvel', 'Ray 4025', 'TR72');

--Adding Values To SERVICE_CATEGORY Table
INSERT INTO SERVICE_CATEGORY VALUES
(1, 'Routine engine maintenance'),
(2, 'Engine repair'),
(3, 'Air conditioning'),
(4, 'Electrical systems'),
(5, 'Fiberglass repair'),
(6, 'Canvas installation'),
(7, 'Canvas repair'),
(8, 'Electronic systems (radar, GPS, autopilots, etc.)' );

--Adding Values To SERVICE_REQUEST Table
INSERT INTO SERVICE_REQUEST VALUES
(1, 1, 3, 'Air conditioner periodically stops with code indicating low coolant level. Diagnose and repair.', 'Technician has verified the problem. Air conditioning specialist has been called.', 4, 2, '7/12/2010'),
(2, 5, 4, 'Fuse on port motor blown on two occasions. Diagnose and repair.', 'Open', 2, 0, '7/12/2010'),
(3, 4, 1, 'Oil change and general routine maintenance (check fluid levels, clean sea strainers etc.).', 'Service call has been scheduled.', 1, 0, '7/16/2010'),
(4, 1, 2, 'Engine oil level has been dropping drastically. Diagnose and repair.', 'Open', 2, 0, '7/13/2010'),
(5, 3, 5, 'Open pockets at base of two stantions.', 'Technician has completed the initial filling of the open pockets. Will complete the job after the initial fill has had sufficient time to dry.', 4, 2, '7/13/2010'),
(6, 11, 4, 'Electric-flush system periodically stops functioning. Diagnose and repair.', 'Open', 3, 0, ''),
(7, 6, 2, 'Engine overheating. Loss of coolant. Diagnose and repair.', 'Open', 2, 0, '7/13/2010'),
(8, 6, 2, 'Heat exchanger not operating correctly.', 'Technician has determined that the exchanger is faulty. New exchanger has been ordered.', 4, 1, '7/17/2010'),
(9, 7, 6, 'Canvas severely damaged in windstorm. Order and install new canvas.', 'Open', 8, 0, '7/16/2010'),
(10, 2, 8, 'Install new GPS and chart plotter.', 'Scheduled', 7, 0, '7/17/2010'),
(11, 2, 3, 'Air conditioning unit shuts down with HHH showing on the control panel.', 'Technician not able to replicate the problem. Air conditioning unit ran fine through multiple tests. Owner to notify technician if the problem recurs.', 1, 1, ''),
(12, 4, 8, 'Both speed and depth readings on data unit are significantly less than the owner thinks they should be.', 'Technician has scheduled appointment with owner to attempt to verify the problem.', 2, 0, '7/16/2010'),
(13, 8, 2, 'Customer describes engine as making a clattering sound.', 'Technician suspects problem with either propeller or shaft and has scheduled the boat to be pulled from the water for further investigation.', 5, 2, '7/12/2010'),
(14, 7, 5, 'Owner accident caused damage to forward portion of port side.', 'Technician has scheduled repair.', 6, 0, '7/13/2010'),
(15, 11, 7, 'Canvas leaks around zippers in heavy rain. Install overlap around zippers to prevent leaks.', 'Overlap has been created. Installation has been scheduled.', 8, 3, '7/17/2010');

--Creating REP Table For Premiere Products
CREATE TABLE REP
(REP_NUM CHAR(2) PRIMARY KEY,
LAST_NAME VARCHAR(15) NOT NULL,
FIRST_NAME VARCHAR(15) NOT NULL,
STREET VARCHAR(15),
CITY VARCHAR(15),
STATE CHAR(2),
ZIP CHAR(5),
COMMISSION DECIMAL(7,2), 
RATE DECIMAL(3,2) );

--Creating CUSTOMER Table For Premiere Products
CREATE TABLE CUSTOMER
(CUSTOMER_NUM CHAR(3) PRIMARY KEY,
CUSTOMER_NAME VARCHAR(35) NOT NULL,
STREET VARCHAR(15),
CITY VARCHAR(15),
STATE VARCHAR(5),
ZIP CHAR(5),
BALANCE DECIMAL(8,2), 
CREDIT_LIMIT DECIMAL(8,2),
REP_NUM CHAR(2) );

--Creating ORDERS Table For Premiere Products
CREATE TABLE ORDERS
(ORDER_NUM CHAR(5) PRIMARY KEY,
ORDER_DATE VARCHAR(10),
CUSTOMER_NUM CHAR(3) );

--Creating ORDER_LINE Table For Premiere Products
CREATE TABLE ORDER_LINE
(ORDER_NUM CHAR(5),
PART_NUM CHAR(4),
NUM_ORDERED INT, 
QUOTED_PRICE DECIMAL(6,2)
PRIMARY KEY (ORDER_NUM, PART_NUM) );

--Creating PART Table For Premiere Products
CREATE TABLE PART
(PART_NUM CHAR(4) PRIMARY KEY NOT NULL,
DESCRIPTION VARCHAR(15),
ON_HAND INT,
CLASS VARCHAR(3),
WAREHOUSE INT,
PRICE DECIMAL(6,2) );

--Adding Values To REP Table
INSERT INTO REP VALUES
('20', 'Kaiser', 'Valerie', '624 Randall', 'Grove', 'FL', '33321', 20542.50, 0.05),
('35', 'Hull', 'Richard', '532 Jackson', 'Sheldon', 'FL', '33553', 39216.00, 0.07),
('65', 'Perez', 'Juan', '1626 Taylor', 'Fillmore', 'FL', '33336', 23487.00, 0.05);

--Adding Values To CUSTOMER Table
INSERT INTO CUSTOMER VALUES
('148', 'Al''s Appliance and Sport', '2837 Greenway', 'Fillmore', 'FL', '33336', 6550.00, 7500.00, '20'),
('282', 'Brookings Direct', '3827 Devon', 'Grove', 'FL', '33321', 431.50, 10000.00, '35'),
('356', 'Ferguson''s', '382 Wildwood', 'Northfield', 'FL', '33146', 5785.00, 7500.00, '65'),
('408', 'The Everything Shop', '1828 Raven', 'Crystal', 'FL', '33503', 5285.25, 5000.00, '35'),
('462', 'Bargains Galore', '3829 Central', 'Grove', 'FL', '33321', 3412.00, 10000.00, '65'),
('524', 'Kline''s', '838 Ridgeland', 'Fillmore', 'FL', '33336', 12762.00, 15000.00, '20'),
('608', 'Johnson''s Department Store', '372 Oxford', 'Sheldon', 'FL', '33553', 2106.00, 10000.00, '65'),
('687', 'Lee''s Sport and Appliance', '282 Evergreen', 'Altonville', 'FL', '32543', 2851.00, 5000.00, '35'),
('725', 'Deerfield''s Four Seasons', '282 Columbia', 'Sheldon', 'FL', '33553', 248.00, 7500.00, '35'),
('842', 'All Season', '28 Lakeview', 'Grove', 'FL', '33321', 8221.00, 7500.00, '20');

--Adding Values To ORDERS Table
INSERT INTO ORDERS VALUES
('21608', '10/20/2010', '148'),
('21610', '10/20/2010', '356'),
('21613', '10/21/2010', '408'),
('21614', '10/21/2010', '282'),
('21617', '10/23/2010', '608'),
('21619', '10/23/2010', '148'),
('21623', '10/23/2010', '608');

--Adding Values To ORDER_LINE Table
INSERT INTO ORDER_LINE VALUES
('21608', 'AT94', 11, 21.95),
('21610', 'DR93', 1, 495.00),
('21610', 'DW11', 1, 399.99),
('21613', 'KL62', 4, 329.95),
('21614', 'KT03', 2, 595.00),
('21617', 'BV06', 2, 794.95),
('21617', 'CD52', 4, 150.00),
('21619', 'DR93', 1, 495.00),
('21623', 'KV29', 2, 1290.00);

--Adding Values To PART Table
INSERT INTO PART VALUES
('AT94', 'Iron', 50, 'HW', 3, 24.95),
('BV06', 'Home Gym', 45, 'SG', 2, 794.95),
('CD52', 'Microwave Oven', 32, 'AP', 1, 165),
('DL71', 'Cordless Drill', 21, 'HW', 3, 129.95),
('DR93', 'Gas Range', 8, 'AP', 2, 495.00),
('DW11', 'Washer', 12, 'AP', 3, 399.99), 
('FD21', 'Stand Mixer', 22, 'HW', 3, 159.95),
('KL62', 'Dryer', 12, 'AP', 1, 349.95),
('KT03', 'Dishwasher', 8, 'AP', 3, 595.00),
('KV29', 'Treadmill', 9, 'SG', 2, 1390.00);	

--Creating BRANCH Table For Henry Books
CREATE TABLE BRANCH
(BRANCH_NUM VARCHAR(2) PRIMARY KEY NOT NULL,
BRANCH_NAME VARCHAR(30),
BRANCH_LOCATION VARCHAR(30),
NUM_EMPLOYEES INT);

--Created PUBLISHER Table For Henry Books
CREATE TABLE PUBLISHER
(PUBLISHER_CODE VARCHAR(3) PRIMARY KEY NOT NULL,
PUBLISHER_NAME VARCHAR(30),
CITY VARCHAR(20) );

--Creating AUTHOR Table For Henry Books
CREATE TABLE AUTHOR
(AUTHOR_NUM INT PRIMARY KEY NOT NULL,
AUTHOR_LAST VARCHAR(15),
AUTHOR_FIRST VARCHAR(15));

--Creating BOOK Table For Henry Books
CREATE TABLE BOOK
(BOOK_CODE VARCHAR(4) PRIMARY KEY NOT NULL, 
TITLE VARCHAR(40),
PUBLISHER_CODE VARCHAR(3),
TYPE VARCHAR(3),
PRICE DECIMAL(4,2),
PAPERBACK CHAR(1) );

--Creating WROTE Table For Henry Books
CREATE TABLE WROTE
(BOOK_CODE CHAR(4) NOT NULL,
AUTHOR_NUM INT NOT NULL, 
SEQUENCE INT
PRIMARY KEY (BOOK_CODE, AUTHOR_NUM) );

--Creating INVENTORY Table For Henry Books
CREATE TABLE INVENTORY
(BOOK_CODE CHAR(4) NOT NULL,
BRANCH_NUM INT NOT NULL, 
ON_HAND INT
PRIMARY KEY (BOOK_CODE, BRANCH_NUM) );

--Adding Values To BRANCH Table
INSERT INTO BRANCH VALUES
('1', 'Henry Downtown', '16 Riverview', 10),
('2', 'Henry On The Hill', '1289 Bedford', 6),
('3', 'Henry Brentwood', 'Brentwood Mall', 15),
('4', 'Henry Eastshore', 'Eastshore Mall', 9);

--Adding Values To PUBLISHER Table
INSERT INTO PUBLISHER VALUES
('AH', 'Arkham House', 'Sauk City WI'),
('AP', 'Arcade Publishing', 'New York'),
('BA', 'Basic Books', 'Boulder CO'),
('BP', 'Berkley Publishing', 'Boston'),
('BY', 'Back Bay Books', 'New York'),
('CT', 'Course Technology', 'Boston'),
('FA', 'Fawcett Books', 'New York'),
('FS', 'Farrar Straus and Giroux', 'New York'),
('HC', 'HarperCollins Publishers', 'New York'),
('JP', 'Jove Publications', 'New York'),
('JT', 'Jeremy P. Tarcher', 'Los Angeles'),
('LB', 'Lb Books', 'New York'),
('MP', 'McPherson and Co', 'Kingston'),
('PE', 'Penguin USA', 'New York'),
('PL', 'Plume', 'New York'),
('PU', 'Putnam Publishing Group', 'New York'),
('RH', 'Random House', 'New York'), 
('SB', 'Schoken Books', 'New York'),
('SC', 'Scribner', 'New York'),
('SS', 'Simon and Schuster', 'New York'),
('ST', 'Scholastic Trade', 'New York'),
('TA', 'Taunton Press', 'Newtown CT'),
('TB', 'Tor Books', 'New York'), 
('TH', 'Thames and Hudson', 'New York'),
('TO', 'Touchstone Books', 'Westport CT'),
('VB', 'Vintage Books', 'New York'),
('WN', 'W.W. Norton', 'New York'),
('WP', 'Westview Press', 'Boulder CO');

--Adding Values To AUTHOR Table
INSERT INTO AUTHOR VALUES
(1, 'Morrison', 'Toni'),
(2, 'Solotaroff', 'Paul'),
(3, 'Vintage', 'Vernor'),
(4, 'Francis', 'Dick'),
(5, 'Straub', 'Peter'),
(6, 'King', 'Stephen'),
(7, 'Pratt', 'Philip'),
(8, 'Chase', 'Truddi'),
(9, 'Collins', 'Bradley'),
(10, 'Heller', 'Joseph'),
(11, 'Wills', 'Gary'), 
(12, 'Hofstadter', 'Douglas R.'), 
(13, 'Lee', 'Harper'),
(14, 'Ambrose', 'Stephen E.'),
(15, 'Rowling', 'J.K.'),
(16, 'Salinger', 'J.D.'),
(17, 'Heaney', 'Seamus'),
(18, 'Camus', 'Albert'),
(19, 'Collins, Jr.', 'Bradley'),
(20, 'Steinbeck', 'John'),
(21, 'Castelman', 'Riva'),
(22, 'Owen', 'Barbara'),
(23, 'O''Rourke', 'Randy'),
(24, 'Kidder', 'Tracy'),
(25, 'Schleining', 'Lon');

--Adding Values To BOOK Table
INSERT INTO BOOK VALUES
('0180', 'A Deepness in the Sky', 'TB', 'SFI', 7.19, 'Y'),
('0189', 'Magic Terror', 'FA', 'HOR', 7.99, 'Y'),
('0200', 'The Stranger', 'VB', 'FIC', 8.00, 'Y'),
('0378', 'Venice', 'SS', 'ART', 24.50, 'N'),
('079X', 'Second Wind', 'PU', 'MYS', 24.95, 'N'),
('0808', 'The Edge', 'JP', 'MYS', 6.99, 'Y'),
('1351', 'Dreamcatcher: A Nvel', 'SC', 'HOR', 19.60, 'N'),  
('1382', 'Treasure Chests', 'TA', 'ART', 24.46, 'N'),
('138X', 'Beloved', 'PL', 'FIC', 12.95, 'Y'),
('2226', 'Harry Potter and the Prisoner of Azkaban', 'ST', 'SFI', 13.96, 'N'),  
('2281', 'Van Gogh and Gauguin', 'WP', 'ART', 21.00, 'N'),
('2766', 'Of Mice and Men', 'PE', 'FIC', 6.95, 'Y'),
('2908', 'Electric Light', 'FS', 'POE', 14.00, 'N'), 
('3350', 'Group: Six People in Search of a Life', 'BP', 'PSY', 10.40, 'Y'), 
('3743', 'Nine Stories', 'LB', 'FIC', 5.99, 'Y'),
('3906', 'The Soul of a New Machine', 'BY', 'SCI', 11.16, 'Y'),  
('5163', 'Travels with Charley', 'PE', 'TRA', 7.95, 'Y'),
('5790', 'Catch-22', 'SC', 'FIC', 12.00, 'Y'),
('6128', 'Jazz', 'PL', 'FIC', 12.95, 'Y'),
('6328', 'Band of Brothers', 'TO', 'HIS', 9.60, 'Y'),
('669X', 'A Guide to SQL', 'CT', 'CMP', 37.95, 'Y'),
('6908', 'Franny and Zooey', 'LB', 'FIC', 5.99, 'Y'),
('7405', 'East of Eden', 'PE', 'FIC', 12.95, 'Y'),
('7443', 'Harry Potter and the Goblet of Fire', 'ST', 'SFI', 18.16, 'N'),
('7559', 'The Fall', 'VB', 'FIC', 8.00, 'Y'),
('8092', 'Godel, Escher, Bach', 'BA', 'PHI', 14.00, 'Y'), 
('8720', 'When Rabbit Howls', 'JP', 'PSY', 6.29, 'Y'),
('9611', 'Black House', 'RH', 'HOR', 18.81, 'N'),
('9627', 'Song of Solomon', 'PL', 'FIC', 14.00, 'Y'),
('9701', 'The Grapes of Wrath', 'PE', 'FIC', 13.00, 'Y'),
('9882', 'Slay Ride', 'JP', 'MYS', 6.99, 'Y'),
('9883', 'The Catcher in the Rye', 'LB', 'FIC', 5.99, 'Y'),
('9931', 'To Kill A Mockingbird', 'HC', 'FIC', 18.00, 'N');

--Adding Values To WROTE Table
INSERT INTO WROTE VALUES
('0180', 3, 1),
('0189', 5, 1), 
('0200', 18, 1), 
('0378', 11, 1), 
('079X', 4, 1), 
('0808', 4, 1), 
('1351', 6, 1), 
('1382', 23, 2),
('1382', 25, 1),
('138X', 1, 1), 
('2226', 15, 1), 
('2281', 9, 2),
('2281', 19, 1),
('2766', 20, 1), 
('2908', 17, 1), 
('3350', 2, 1), 
('3743', 16, 1), 
('3906', 24, 1), 
('5163', 20, 1), 
('5790', 10, 1), 
('6128', 1, 1), 
('6328', 14, 1), 
('669X', 7, 1), 
('6908', 16, 1), 
('7405', 20, 1), 
('7443', 15, 1), 
('7559', 18, 1), 
('8092', 12, 1), 
('8720', 8, 1),
('9611', 5, 2),
('9611', 6, 1),  
('9627', 1, 1), 
('9701', 20, 1), 
('9882', 4, 1), 
('9883', 16, 1),  
('9931', 13, 1);

--Adding Values To INVENTORY Table
INSERT INTO INVENTORY VALUES
('0180', 1, 2),
('0189', 2, 2),
('0200', 1, 1),
('0200', 2, 3),
('0378', 3, 2),
('079X', 2, 1),
('079X', 3, 2),
('079X', 4, 3),
('0808', 2, 1),
('1351', 2, 4),
('1351', 3, 2),
('1382', 2, 1),
('138X', 2, 3),
('2226', 1, 3),
('2226', 3, 2),
('2226', 4, 1),
('2281', 4, 3),
('2766', 3, 2),
('2908', 1, 3),
('2908', 4, 1),
('3350', 1, 2),
('3743', 2, 1),
('3906', 2, 1),
('3906', 3, 2),
('5163', 1, 1),
('5790', 4, 2),
('6128', 2, 4),
('6128', 3, 3),
('6328', 2, 2),
('669X', 1, 1),
('6908', 2, 2),
('7405', 3, 2),
('7443', 4, 1),
('7559', 2, 2),
('8092', 3, 1),
('8720', 1, 3),
('9611', 1, 2),
('9627', 3, 5),
('9627', 4, 2),
('9701', 1, 2),
('9701', 2, 1),
('9701', 3, 3),
('9701', 4, 2),
('9882', 3, 3),
('9883', 2, 3),
('9883', 4, 2),
('9931', 1, 2);

-- Viewing All Alexamara Marina Group Tables
SELECT * FROM MARINA;
SELECT * FROM OWNER;
SELECT * FROM MARINA_SLIP;
SELECT * FROM SERVICE_CATEGORY;
SELECT * FROM SERVICE_REQUEST;

-- Viewing All Premiere Products Tables
SELECT * FROM REP;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
SELECT * FROM ORDER_LINE;
SELECT * FROM PART;

-- Viewing All Henry Books Tables 
SELECT * FROM BRANCH;
SELECT * FROM PUBLISHER;
SELECT * FROM AUTHOR;
SELECT * FROM BOOK;
SELECT * FROM WROTE;
SELECT * FROM INVENTORY;

-- Dropping All Alexamara Marina Group Tables
DROP TABLE MARINA;
DROP TABLE OWNER;
DROP TABLE MARINA_SLIP;
DROP TABLE SERVICE_CATEGORY;
DROP TABLE SERVICE_REQUEST;

-- Dropping All Premiere Products Tables
DROP TABLE REP;
DROP TABLE CUSTOMER;
DROP TABLE ORDERS;
DROP TABLE ORDER_LINE;
DROP TABLE PART;

-- Dropping All Henry Books Tables 
DROP TABLE BRANCH;
DROP TABLE PUBLISHER;
DROP TABLE AUTHOR;
DROP TABLE BOOK;
DROP TABLE WROTE;
DROP TABLE INVENTORY;

-- Format For All Alexamara Marina Group Tables
EXEC SP_COLUMNS MARINA;
EXEC SP_COLUMNS OWNER;
EXEC SP_COLUMNS MARINA_SLIP;
EXEC SP_COLUMNS SERVICE_CATEGORY;
EXEC SP_COLUMNS SERVICE_REQUEST;

-- Format For All Premiere Products Tables
EXEC SP_COLUMNS REP;
EXEC SP_COLUMNS CUSTOMER;
EXEC SP_COLUMNS ORDERS;
EXEC SP_COLUMNS ORDER_LINE;
EXEC SP_COLUMNS PART;

-- Format For All Henry Books Tables 
EXEC SP_COLUMNS BRANCH;
EXEC SP_COLUMNS PUBLISHER;
EXEC SP_COLUMNS AUTHOR;
EXEC SP_COLUMNS BOOK;
EXEC SP_COLUMNS WROTE;
EXEC SP_COLUMNS INVENTORY;