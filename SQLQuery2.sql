CREATE DATABASE Prescription_System;


CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100),
    Phone VARCHAR(20),
    Age INT,
    Address VARCHAR(50),
    Email VARCHAR(100),
    Medicare_Card_Number VARCHAR(30)
);

CREATE TABLE Doctors (
    Doc_ID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Specialty VARCHAR(50),
    Phone VARCHAR(50),
    Years_Experience INT
);
alter table Doctors
alter column Years_Experience varchar(20)


CREATE TABLE Pharmaceutical_company (
    Company_Name VARCHAR(50) not null primary key,
    Phone VARCHAR(50),
    Address VARCHAR(100)

);

CREATE TABLE Drugs (
    Trade_Name VARCHAR(50) not null PRIMARY KEY,
    Strength VARCHAR(50),
    CompanyName VARCHAR(50),
    CONSTRAINT fk_group FOREIGN KEY (CompanyName) REFERENCES Pharmaceutical_company(Company_Name)
);

CREATE TABLE Prescription (
    Prescription_ID INT PRIMARY KEY IDENTITY,
    Date DATETIME,
    Quantity INT,
    Patient_ID INT,
    Doc_Id INT,
    CONSTRAINT fk_Patienst FOREIGN KEY (Patient_ID) REFERENCES dbo.Patients(Patient_ID),
    CONSTRAINT fk_Doctor FOREIGN KEY (Doc_Id) REFERENCES dbo.Doctors(Doc_ID)
);
drop table Prescription


DELETE FROM Drugs;
