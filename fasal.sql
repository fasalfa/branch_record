-- Create the 'library' database
CREATE DATABASE library;
-- Use the 'library' database
USE library;
-- Create the 'Branch' table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(20));

-- Insert data into the 'Branch' table
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
    (1, 101, 'Address_1', '9999999991'),
    (2, 102, 'Address_2', '9999999992'),
    (3, 103, 'Address_3', '9999999993');
    
-- Create the 'Employee' table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(50),
    Position VARCHAR(50),
    Branch_no INT,
    Salary FLOAT(10, 2));

-- Insert data into the 'Employee' table
INSERT INTO Employee (Emp_Id, Emp_name, Position, Branch_no, Salary)
VALUES
    (1, 'Emp_1', 'Librarian',1, 50000.00),
    (2, 'Emp_2', 'Clerk',1, 15000.00),
    (3, 'Emp_3', 'Manager',1, 75000.00), 
    (4, 'Emp_4', 'Librarian',2, 40000.00),
    (5, 'Emp_5', 'Clerk',2, 14000.00),
    (6, 'Emp_6', 'Manager',2, 65000.00),
	(7, 'Emp_7', 'Librarian',3, 30000.00),
    (8, 'Emp_8', 'Clerk',3, 10000.00),
    (9, 'Emp_9', 'Manager',3, 55000.00);
    
    -- Create the 'Books' table
CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(100),
    Category VARCHAR(50),
    Rental_Price FLOAT(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(100),
    Publisher VARCHAR(100));

-- Insert data into the 'Books' table
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
    (101, 'Book_1', 'Fiction', 50, 'yes', 'Author_1', 'Publisher_1'),
    (102, 'Book_2', 'Mystery', 25, 'yes', 'Author_2', 'Publisher_2'),
    (103, 'Book_3', 'History', 15, 'no', 'Author_3', 'Publisher_3'),
	(104, 'Book_4', 'Novel', 25, 'yes', 'Author_1', 'Publisher_1'),
    (105, 'Book_5', 'Romance', 100, 'yes', 'Author_2', 'Publisher_2'),
    (106, 'Book_6', 'Thriller', 75, 'no', 'Author_3', 'Publisher_3'),
	(107, 'Book_7', 'Fantasy', 30, 'no', 'Author_3', 'Publisher_1');

-- Create the 'Customer' table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE);

-- Insert data into the 'Customer' table
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
    (1, 'Customer_1', 'Customer_Address_1', '2021-05-15'),
    (2, 'Customer_2', 'Customer_Address_2', '2022-03-20'),
    (3, 'Customer_3', 'Customer_Address_3', '2023-01-10'),
    (4, 'Customer_4', 'Customer_Address_4', '2021-01-15'),
    (5, 'Customer_5', 'Customer_Address_5', '2022-02-20'),
    (6, 'Customer_6', 'Customer_Address_6', '2023-03-10'),
	(7, 'Customer_7', 'Customer_Address_7', '2021-04-15'),
    (8, 'Customer_8', 'Customer_Address_8', '2022-06-20'),
    (9, 'Customer_9', 'Customer_Address_9', '2023-07-10'),
    (10, 'Customer_10', 'Customer_Address_10', '2021-08-15'),
    (11, 'Customer_11', 'Customer_Address_11', '2022-09-20'),
    (12, 'Customer_12', 'Customer_Address_12', '2023-10-10'),
	(13, 'Customer_13', 'Customer_Address_13', '2021-11-15'),
    (14, 'Customer_14', 'Customer_Address_14', '2022-12-20'),
    (15, 'Customer_15', 'Customer_Address_15', '2023-01-01');

-- Create the 'IssueStatus' table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(100),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES customer (Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES books(ISBN));

-- Insert data into the 'IssueStatus' table
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
    (1, 2, 'Book_1', '2023-07-10', 101),
    (2, 4, 'Book_2', '2023-08-15', 102),
    (3, 6, 'Book_3', '2023-09-20', 103),
	(4, 8, 'Book_1', '2023-07-10', 101),
    (5, 10, 'Book_2', '2023-08-15', 102),
    (6, 12, 'Book_3', '2023-09-20', 103);

-- Create the 'ReturnStatus' table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(100),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Isbn_book2) REFERENCES books(ISBN));

-- Insert data into the 'ReturnStatus' table
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
	(1, 4, 'Book_2', '2023-08-15', 102),
    (2, 6, 'Book_3', '2023-09-20', 103),
	(3, 8, 'Book_1', '2023-07-10', 101),
    (4, 10, 'Book_2', '2023-08-15', 102);

SHOW TABLES;
SELECT * FROM information_schema.columns Where TABLE_SCHEMA='library'; -- display all tables skelton in this databse


-- Questions ---
-- 1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- 2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT books.Book_title, customer.Customer_name FROM IssueStatus
INNER JOIN Books ON IssueStatus.Isbn_book = books.ISBN
INNER JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

-- 4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- 8. Display the names of customers who have issued books in the month of July 2023.
SELECT DISTINCT customer.Customer_name FROM IssueStatus
INNER JOIN Customer ON IssueStatus.Issued_cust = customer.Customer_Id
WHERE YEAR(IssueStatus.Issue_date) = 2023 AND MONTH(IssueStatus.Issue_date) = 7;

-- 9. Retrieve book_title from book table containing book.
SELECT Book_title
FROM Books
WHERE book_title LIKE '%Book%';

-- 10. Retrieve the branch numbers along with the count of employees for branches having more than 2 employees.
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 2;











    

