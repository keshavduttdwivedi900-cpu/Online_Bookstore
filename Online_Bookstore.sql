DROP TABLE IF EXISTS Books;
Create TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(50),
	Published_Year INT,
	Price NUMERIC(10,2),
	Stock INT
);

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(150)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  Order_ID SERIAL PRIMARY KEY,
  Customer_ID INT REFERENCES Customers(Customer_ID),
  Book_ID INT REFERENCES Books(Book_ID),
  Order_Date DATE,
  Quantity INT,
  Total_Amount NUMERIC(10,2)
);  



--Import Data into Books Table
COPY Books(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
FROM 'C:\Debugshalla\Bhavya Parmar mam\Power BI\Satish Dhawle\Books.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER, QUOTE '"', ESCAPE '"');

--Import Data into Customers Table
Copy Customers(Customer_ID,NAME,Email,Phone,City,Country)
FROM 'C:\Debugshalla\Bhavya Parmar mam\Power BI\Satish Dhawle\Customers.csv'
CSV HEADER;

--Import Data into Orders Table
Copy Orders(Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
FROM 'C:\Debugshalla\Bhavya Parmar mam\Power BI\Satish Dhawle\Orders (1).csv'
CSV HEADER;

--1) Retrive all books in the "Fiction" genre:
SELECT * FROM Books
where genre = 'Fiction';

--2)Find books published after the year 1950:
SELECT * FROM BOOKS
WHERE published_year > 1950 ;

--3) List all the customers from the Canada;
SELECT * FROM Customers
WHERE country = 'Canada';

--4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

--5)Retrive the total stocks of books available:
SELECT SUM(stock) AS Total_Stock
FROM BOOKS 

--6)Find the details of the most expensive books:

SELECT *
FROM BOOKS
ORDER BY Price DESC
LIMIT 1;

--7)Show all customers who ordered more than 1 quantity of a book:

SELECT * 
FROM ORDERS
WHERE QUANTITY > 1;

--8)Retrieve all orders where the total amount excees $20:
SELECT * 
FROM ORDERS
WHERE total_amount > 20;

--9)List all genres available in the Books table:

SELECT genre
FROM BOOKS
GROUP BY genre

--or

SELECT DISTINCT genre
FROM BOOKS

--10)Find the book with the lowest stock:

SELECT *
FROM BOOKS
ORDER BY STOCK
LIMIT 1;

--11)Calculate the total revenue generated from all orders:

SELECT SUM(TOTAL_AMOUNT) AS total_revenue
FROM ORDERS

--Advance Questions :

--1) Retreive the total number of books sold for each genre:

select  b.genre, SUM(o.quantity) AS Total_Books_sold

FROM Orders o
JOIN Books b ON b.book_id = o.book_id
GROUP BY b.genre

--2)Find the average price of books in the "Fantasy" genre:

SELECT AVG(price) AS average_Price
FROM books
WHERE genre = 'Fantasy';

--3)List customers who have placed at least 2 orders:
select * from customers;
select * from orders;


SELECT c.customer_id,c.name,count(o.order_id) AS order_count
FROM Customers c
JOIN Orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id,c.name
Having count (order_id) >= 2

--4) Find the most frequently ordered book;

SELECT O.book_id,B.title,count(order_id)
FROM BOOKS B
JOIN ORDERS O ON B.book_id = O.book_id
group by B.title,O.book_id
Order by Count(order_id) DESC
LIMIT 1;

--5) Show the top 3 most expensive books of 'Fantasy' Genre:

SELECT *
FROM Books 
WHERE genre = 'Fantasy'
ORDER BY price DESC
Limit 3;

--6) Retrieve the total quantity of books sold by each author:
SELECT B.author,SUM(O.quantity) AS TOTAL_Book_Sold
FROM BOOKS B
JOIN ORDERS O ON B.book_id = O.book_id
Group by B.author

--7)List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city,o.total_amount
FROM Customers c
JOIN Orders o On o.customer_id = c.customer_id
WHERE o.total_amount > 30;

--8) Find the customer who spent the most on orders;
SELECT c.name,c.customer_id,sum(total_amount)
FROM Customers c
JOIN Orders o On o.customer_id = c.customer_id
GROUP BY c.name,c.customer_id
ORDER BY sum(total_amount) DESC
LIMIT 1

--9)Calculate the stock remaining after fulfilling all orders;
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;



Select b.book_id,b.title,b.stock,COALESCE(SUM(o.quantity),0) AS Order_quantity,
b.stock-COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM Books b
LEFT Join Orders o On b.book_id = O.book_id
Group by b.book_id
ORDER BY b.book_id
























  
