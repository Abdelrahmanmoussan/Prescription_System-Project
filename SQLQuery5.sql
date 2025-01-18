
--1.	SELECT: Retrieve all columns from the Doctor table.
 select *
 from Doctors

 --2.	ORDER BY: List patients in the Patient table in ascending order of their ages.
 SELECT * 
 FROM Patients
ORDER BY Age ASC;

--3.	OFFSET FETCH: Retrieve the first 10 patients from the Patient table, starting from the 5th record.
Select *
from Patients
order by Patient_ID
offset 4 rows
fetch next 10 rows only

--4.	SELECT TOP: Retrieve the top 5 doctors from the Doctor table.
select top 5 *
from Doctors

--5.	SELECT DISTINCT: Get a list of unique address from the Patient table.
select distinct Address from Patients

--6.	WHERE: Retrieve patients from the Patient table who are aged 25.
select *
from Patients
where Age = 25

--7.	NULL: Retrieve patients from the Patient table whose email is not provided.
select *
from Patients
where Email is null

--8.	AND: Retrieve doctors from the Doctor table who have experience greater than 5 years and specialize in 'Cardiology'.
SELECT * 
FROM Doctors
WHERE Years_Experience > 5 AND Specialty = 'Cardiology';

--9.	IN: Retrieve doctors from the Doctor table whose speciality is either 'Dermatology' or 'Oncology'.
select *
from Doctors
where Specialty in ('Dermatology', 'Oncology');


--10.	BETWEEN: Retrieve patients from the Patient table whose ages are between 18 and 30.
select *
from Patients
where Age between 18 and 30;

--11.	LIKE: Retrieve doctors from the Doctor table whose names start with 'Dr.'.
select *
from Doctors
where Name like 'Dr.%'

--12.	Column & Table Aliases: Select the name and email of doctors, aliasing them as 'DoctorName' and 'DoctorEmail'.
select Name As DoctorName, Email As DoctorEmail
from Doctors

--13.	Joins: Retrieve all prescriptions with corresponding patient names.
SELECT Prescription.*, Patients.Name AS PatientName
FROM Prescription
JOIN Patients ON Prescription.Patient_ID = Patient_ID;

--14. Retrieve the count of patients grouped by their cities
SELECT Address, COUNT(*) AS PatientCount
FROM Patients
GROUP BY Address;

--15. Retrieve cities with more than 3 patients
SELECT Address, COUNT(*) AS PatientCount
FROM Patients
GROUP BY Address
HAVING COUNT(*) > 3;

--16. Retrieve counts of patients grouped by cities and ages using GROUPING SETS
SELECT Address, Age, COUNT(*) AS PatientCount
FROM Patients
GROUP BY GROUPING SETS ((Address), (Age), ());

--17. Retrieve counts of patients with CUBE
SELECT Address, Age, COUNT(*) AS PatientCount
FROM Patients
GROUP BY CUBE(Address, Age);

--18. Retrieve counts of patients rolled up by city
SELECT Address, COUNT(*) AS PatientCount
FROM Patients
GROUP BY ROLLUP(Address);

--19. Retrieve patients with at least one prescription
SELECT * FROM Patients
WHERE EXISTS (
    SELECT 1 FROM Prescription
    WHERE Prescription.Patient_ID = Patients.Patient_ID 
);

--20. Retrieve a combined list of doctors and patients
SELECT Name, Specialty AS Role FROM Doctors
UNION
SELECT Name, 'Patient' AS Role FROM Patients;

--21. Retrieve patients along with their doctors using a CTE
WITH PatientDoctor AS (
    SELECT Patients.Name AS PatientName, Doctors.Name AS DoctorName
    FROM Patients
    JOIN Prescription ON Patients.Patient_ID = Prescription.Patient_ID
    JOIN Doctors ON Prescription.Doc_Id = Doctors.Doc_ID
)
SELECT * FROM PatientDoctor;

--22. Insert a new doctor into the Doctor table
INSERT INTO Doctors (Name, Specialty, Years_Experience, Email)
VALUES ('Dr. John Smith', 'Pediatrics', 8, 'john.smith@example.com');

--23. Insert multiple patients into the Patient table
INSERT INTO Patients (Name, Age, Address, Email)
VALUES 
('Alice Brown', 30, '123 Maple St', 'alice@example.com'),
('Bob White', 25, '456 Oak St', 'bob@example.com'),
('Charlie Black', 35, '789 Pine St', NULL);

--24. Update the phone number of a doctor
UPDATE Doctors
SET Phone = '123-456-7890'
WHERE Name = 'Dr. John Smith';

--25. Update the city of patients with prescriptions from a specific doctor
UPDATE Patients
SET Address = 'New York'
WHERE Patient_ID IN (
    SELECT Patient_ID
    FROM Prescription
    WHERE Doc_Id = (SELECT Doc_Id FROM Doctors WHERE Name = 'Dr. John Smith')
);

--26. Delete a patient from the Patient table
DELETE FROM Patients
WHERE Name = 'Alice Brown';

--27. Insert a doctor and a patient within a transaction
BEGIN TRANSACTION;
INSERT INTO Doctors (Name, Specialty, Years_Experience, Email)
VALUES ('Dr. Jane Doe', 'Neurology', 10, 'jane.doe@example.com');
INSERT INTO Patients (Name, Age, Address, Email)
VALUES ('Eve Green', 40, '456 Elm St', 'eve@example.com');
COMMIT TRANSACTION;

--28. Create a view combining patient and doctor information
CREATE VIEW PatientDoctorView AS
SELECT Patients.Name AS PatientName, Doctors.Name AS DoctorName, Prescription.Date
FROM Patients
JOIN Prescription ON Patients.Patient_ID = Prescription.Patient_ID
JOIN Doctors ON Prescription.Doc_Id = Doctors.Doc_ID;

--29. Create an index on the 'phone' column of the Patient table
CREATE INDEX idx_patient_phone ON Patients(Phone);

--30. Backup the database
BACKUP DATABASE Prescription_System
TO DISK = 'C:\Backup\YourDatabaseName.bak';










