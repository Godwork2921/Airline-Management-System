CREATE TABLE Airplane (
    Airplane_ID INT PRIMARY KEY,
    Model VARCHAR(50) NOT NULL,
    Capacity INT NOT NULL,
    Airline VARCHAR(50) NOT NULL
);
CREATE TABLE Flight (
    Flight_ID INT PRIMARY KEY,
    Flight_Number VARCHAR(10) UNIQUE NOT NULL,
    Departure_Time Date NOT NULL,
    Arrival_Time Date NOT NULL,
    Source VARCHAR(50) NOT NULL,
    Destination VARCHAR(50) NOT NULL,
    Airplane_ID INT NOT NULL,
    CONSTRAINT FK_Flight_Airplane FOREIGN KEY (Airplane_ID)
        REFERENCES Airplane(Airplane_ID)
);

CREATE TABLE Passenger (
    Passenger_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(150),
    Contact_Number VARCHAR(15),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Reservation (
    Reservation_ID INT PRIMARY KEY,
    Flight_ID INT NOT NULL,
    Passenger_ID INT NOT NULL,
    Reservation_Date Date NOT NULL,
    Seat_Number VARCHAR(10) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    CONSTRAINT FK_Reservation_Flight FOREIGN KEY (Flight_ID)
        REFERENCES Flight(Flight_ID),
    CONSTRAINT FK_Reservation_Passenger FOREIGN KEY (Passenger_ID)
        REFERENCES Passenger(Passenger_ID)
);

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Designation VARCHAR(50),
    Contact_Details VARCHAR(100)
);

INSERT INTO Airplane (Airplane_ID, Model, Capacity, Airline) VALUES
(1, 'Boeing 737', 150, 'Airline A'),
(2, 'Airbus A320', 180, 'Airline B'),
(3, 'Boeing 777', 300, 'Airline C');

INSERT INTO Flight (Flight_ID, Flight_Number, Departure_Time, Arrival_Time, Source, Destination, Airplane_ID) VALUES
(101, 'AA101', '2022-12-01 08:00:00', '2022-12-01 10:30:00', 'New York', 'Chicago', 1),
(102, 'BB202', '2022-12-02 09:15:00', '2022-12-02 12:00:00', 'Los Angeles', 'New York', 2),
(103, 'CC303', '2022-12-03 14:00:00', '2022-12-03 18:00:00', 'Chicago', 'Miami', 3);

INSERT INTO Passenger (Passenger_ID, Name, Address, Contact_Number, Email) VALUES
(1, 'Rahmet Hab', '123 Main St, New York', '123-456-7890', 'reem@gmail.com'),
(2, 'Yeabsra And', '456 Park Ave, Los Angeles', '987-654-3210', 'yeab@gmail.com'),
(3, 'Arsema Yir', '789 Broadway, Chicago', '555-123-4567', 'arsu@gmail.com');

INSERT INTO Reservation (Reservation_ID, Flight_ID, Passenger_ID, Reservation_Date, Seat_Number, Status) VALUES
(1001, 101, 1, '2022-11-25', '12A', 'Confirmed'),
(1002, 102, 2, '2022-11-26', '15B', 'Confirmed'),
(1003, 103, 3, '2022-11-27', '8C', 'Pending');

INSERT INTO Employee (Employee_ID, Name, Designation, Contact_Details) VALUES
(1, 'Biruk Mitiku', 'Reservation Manager', 'bura.mit@airline.com'),
(2, 'Esuyawukal Abebe', 'Flight Coordinator', 'esu.abe@airline.com');

CREATE INDEX idx_flight_departure ON Flight (Departure_Time);

CREATE INDEX idx_reservation_date ON Reservation (Reservation_Date);

ALTER TABLE Reservation
ADD CONSTRAINT chk_reservation_status CHECK (Status IN ('Confirmed', 'Pending', 'Cancelled'));

CREATE VIEW FlightView AS
SELECT 
    f.Flight_ID,
    f.Flight_Number,
    f.Departure_Time,
    f.Arrival_Time,
    f.Source,
    f.Destination,
    a.Model AS Airplane_Model,
    a.Capacity AS Airplane_Capacity,
    a.Airline AS Airplane_Airline
FROM 
    Flight f
JOIN 
    Airplane a ON f.Airplane_ID = a.Airplane_ID;

commit;
	