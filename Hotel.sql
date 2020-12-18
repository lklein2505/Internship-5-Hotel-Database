CREATE DATABASE Hotel

--

CREATE TABLE Hotels (
	Id int IDENTITY(1,1) PRIMARY KEY,
	HotelName nvarchar(50) NOT NULL,
	HotelLocation nvarchar(50) NOT NULL,
	HotelRating int CHECK(HotelRating between 1 and 5)
)

CREATE TABLE Rooms(
	Id int IDENTITY(1,1) PRIMARY KEY,
	HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL,
	RoomNumber int NOT NULL,
	Capacity int NOT NULL,
	Category nvarchar(50) NOT NULL,
	Price int NOT NULL
)

CREATE TABLE Employees(
	Id int IDENTITY(1,1) PRIMARY KEY,
	HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	Age int NOT NULL,
	Salary int NOT NULL,
	Job nvarchar(50) CHECK(Job = 'Room service' or Job = 'Receptionist' or Job = 'Cleaner') NOT NULL,
)

CREATE TABLE Guests(
	Id int IDENTITY(1,1) PRIMARY KEY,
	RoomId int FOREIGN KEY REFERENCES Rooms(Id) NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	Oib nvarchar(11) NOT NULL,
	PhoneNumber nvarchar(20)
)

CREATE TABLE Buyers(
	Id int IDENTITY(1,1) PRIMARY KEY,	
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	Oib nvarchar(11) NOT NULL,
	PhoneNumber nvarchar(20) NOT NULL
)

CREATE TABLE Purchases(
	Id int IDENTITY(1,1) PRIMARY KEY,
	BuyerId int FOREIGN KEY REFERENCES Buyers(Id) NOT NULL,
	RoomId int FOREIGN KEY REFERENCES Rooms(Id) NOT NULL,
	StayType nvarchar(50) CHECK(StayType = 'Regular' or StayType = 'Half pansion' or StayType = 'Pansion') NOT NULL,
	Price int NOT NULL,
	TransactionDate datetime2 NOT NULL,
	StartTime datetime2 NOT NULL,
	EndTime datetime2 NOT NULL,	
)

CREATE TABLE GuestStays(
	GuestId int FOREIGN KEY REFERENCES Guests(Id) NOT NULL,
	PurchasesId int FOREIGN KEY REFERENCES Purchases(Id) NOT NULL,
	CONSTRAINT GuestStaysPrimaryKey PRIMARY KEY(GuestId, PurchasesId)
)

--

INSERT INTO Hotels(HotelName, HotelLocation, HotelRating) VALUES
('Amphora', 'Split', 4),
('Sheraton', 'Zagreb', 5),
('Garbage', 'Split', 2),
('Hercegovka', 'Mostar', 4),
('Opatija', 'Opatija', 5);


INSERT INTO Employees(FirstName, LastName, Age, Salary, Job, HotelId) VALUES
('Miroslav', 'Tonki?', 45, 8000, 'Receptionist', 2),
('Jozo', 'Vranješ', 58, 7500, 'Receptionist', 1),
('Katica', 'Miji?', 65, 6000, 'Cleaner', 2),
('Lucija', 'Brekalo', 38, 5500, 'Cleaner', 3),
('Marija', 'Zadro', 30, 6500, 'Room service', 1);


INSERT INTO Rooms (RoomNumber, Capacity, Category, Price, HotelId) VALUES
(125, 3, 'Standard', 350, 1),
(202, 2, 'Elite', 850, 3),
(105, 2, 'Standard', 400, 4),
(301, 4, 'Standard', 300, 4),
(108, 2, 'Romantic', 580, 5);


INSERT INTO Buyers (FirstName, LastName, Oib, PhoneNumber) VALUES
('Grigor', 'Dimitrov', '15487542357', '0915789464'),
('Ante', 'Kivi?', '54876512987', '0984579412'),
('Mirko', 'Barbari?', '64852242154', '0986795545'),
('Josip', 'Broz', '33554875124', '0955847787'),
('Nelson', 'Mandela', '99988844452', '0918545584');


INSERT INTO Guests (RoomId, FirstName, LastName, Oib, PhoneNumber) VALUES
(2, 'Klara', 'Dimitrov', '15488442357', '0916544464'),
(3 ,'Ante', 'Bosan?i?', '48744512987', '0984584711'),
(4, 'Katarina', 'Su?i?', '22544742154', '0915595548'),
(2, 'Grigor', 'Dimitrov', '15487542357', '0915789464'),
(3, 'Martin', 'Bosan?i?', '91187844452', '0918889584');


INSERT INTO Purchases (BuyerId, RoomId, StayType, Price, TransactionDate, StartTime, EndTime) VALUES
(2, 4, 'Regular', 1500, '2020-5-5', '2020-8-8', '2020-8-10'),
(4, 4, 'Half pansion', 2550, '2020-12-2', '2020-12-8', '2020-12-10'),
(1, 2, 'Half pansion', 3000, '2020-7-7', '2020-9-15', '2020-9-18'),
(5, 1, 'Pansion', 5000, '2020-6-25', '2020-7-24', '2020-7-28'),
(3, 1, 'Regular', 1800, '2020-11-11', '2020-11-24', '2020-11-27');


INSERT INTO GuestStays (GuestId, PurchasesId) VALUES
(1, 3),
(2, 5),
(3, 2),
(4, 3),
(5, 2);
