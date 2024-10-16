https://replit.com/@wisaithatch/hwSqldsb10Tiiw

/* 
Create at least 3 tables: restaurants
-Staff
-Menus
-Transaction

Write a queries at least 3 queries
- with clause
- subquery
- aggregrate function & Group by 
*/

-- Creating Staff Table
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    staff_name TEXT,
    staff_role TEXT,
    staff_salary INT
    );

INSERT INTO Staff VALUES
    ( 1 , 'Pakin' , 'Manager' , 100000 ),
    ( 2 , 'Tiiw' , 'Head Chef' , 70000 ),
    ( 3 , 'Nop' , 'Waiter' , 55000),
    ( 4 , 'Ice Kogo' , 'Chef' ,58000),
    ( 5 , 'Dom' , 'Waiter' , 50000) ;

/*+----------+------------+------------+--------------+
| staff_id | staff_name | staff_role | staff_salary |
+----------+------------+------------+--------------+
| 1        | Pakin      | Manager    | 100000       |
| 2        | Tiiw       | Head Chef  | 70000        |
| 3        | Nop        | Waiter     | 55000        |
| 4        | Ice Kogo   | Chef       | 58000        |
| 5        | Dom        | Waiter     | 50000        |
+----------+------------+------------+--------------+*/

-- Creating Menus Table    
CREATE TABLE Menus (
    menu_id INT PRIMARY KEY,
    name TEXT, 
    price INT,
    categories TEXT
  );
INSERT INTO Menus VALUES
    ( 1 , 'Tom Yum Kung' , 120 , 'Main Dish'),
    ( 2 , 'Pad Thai' , 80 , 'Main Dish'),
    ( 3 , 'Green Curry' , 100 , 'Main Dish'),
    ( 4 , 'Mango Sticky Rice' , 50 , 'Dessert'),
    ( 5 , 'Thai Iced Tea' , 40 , 'Drink'),
    ( 6 , 'Thai Milk Tea' , 40 , 'Drink'),
    ( 7 , 'Spring Rolls' , 60 , 'Appetizer'),
    ( 8 , 'Satay' , 70 , 'Appetizer');

/*+---------+-------------------+-------+------------+
| menu_id |       name        | price | categories |
+---------+-------------------+-------+------------+
| 1       | Tom Yum Kung      | 120   | Main Dish  |
| 2       | Pad Thai          | 80    | Main Dish  |
| 3       | Green Curry       | 100   | Main Dish  |
| 4       | Mango Sticky Rice | 50    | Dessert    |
| 5       | Thai Iced Tea     | 40    | Drink      |
| 6       | Thai Milk Tea     | 40    | Drink      |
| 7       | Spring Rolls      | 60    | Appetizer  |
| 8       | Satay             | 70    | Appetizer  |
+---------+-------------------+-------+------------+*/

-- Creating Transaction Table
  
CREATE TABLE Transactions(
  transaction_id INT PRIMARY KEY,
  menu_id INT,
  transaction_datetime DATETIME,
  staff_id INT,
  total_amount REAL,
  FOREIGN KEY (menu_id) REFERENCES Menus(menu_id),
  FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
  );

INSERT INTO Transactions VALUES
  ( 1 , 1 , '2023-07-01 12:00:00' , 3 , 120 ),
  ( 2 , 2 , '2023-07-01 12:30:00' , 5 , 80 ),
  ( 3 , 3 , '2023-07-01 13:00:00' , 3 , 100 ),
  ( 4 , 4 , '2023-07-01 13:30:00' , 5 , 50 ),
  ( 5 , 5 , '2023-07-01 14:00:00' , 3 , 40 ),
  ( 6 , 6 , '2023-07-01 14:30:00' , 5 , 40 ),
  ( 7 , 7 , '2023-07-01 15:00:00' , 3 , 60 ),
  ( 8 , 8 , '2023-07-01 15:30:00' , 5 , 70 ),
  ( 9 , 1 , '2023-07-02 12:00:00' , 3 , 120 ),
  ( 10 , 2 , '2023-07-02 12:30:00' , 5 , 80 ),
  ( 11 , 3 , '2023-07-02 13:00:00' , 3 , 100 ),
  ( 12 , 4 , '2023-07-02 13:30:00' , 5 , 50 ),
  ( 13 , 5 , '2023-07-02 14:00:00' , 3 , 40 ),
  ( 14 , 6 , '2023-07-02 14:30:00' , 5 , 40 ),
  ( 15 , 7 , '2023-07-02 15:00:00' , 3 , 60 ),
  ( 16 , 8 , '2023-07-02 15:30:00' , 5 , 70 ),
  ( 17 , 1 , '2023-07-03 12:00:00' , 3 , 120 ),
  ( 18 , 2 , '2023-07-03 12:30:00' , 5 , 80 ),
  ( 19 , 3 , '2023-07-03 13:00:00' , 3 , 100 ),
  ( 20 , 4 , '2023-07-03 13:30:00' , 5 , 50 );

/*+----------------+---------+----------------------+----------+--------------+
| transaction_id | menu_id | transaction_datetime | staff_id | total_amount |
+----------------+---------+----------------------+----------+--------------+
| 1              | 1       | 2023-07-01 12:00:00  | 3        | 120.0        |
| 2              | 2       | 2023-07-01 12:30:00  | 5        | 80.0         |
| 3              | 3       | 2023-07-01 13:00:00  | 3        | 100.0        |
| 4              | 4       | 2023-07-01 13:30:00  | 5        | 50.0         |
| 5              | 5       | 2023-07-01 14:00:00  | 3        | 40.0         |
| 6              | 6       | 2023-07-01 14:30:00  | 5        | 40.0         |
| 7              | 7       | 2023-07-01 15:00:00  | 3        | 60.0         |
| 8              | 8       | 2023-07-01 15:30:00  | 5        | 70.0         |
| 9              | 1       | 2023-07-02 12:00:00  | 3        | 120.0        |
| 10             | 2       | 2023-07-02 12:30:00  | 5        | 80.0         |
| 11             | 3       | 2023-07-02 13:00:00  | 3        | 100.0        |
| 12             | 4       | 2023-07-02 13:30:00  | 5        | 50.0         |
| 13             | 5       | 2023-07-02 14:00:00  | 3        | 40.0         |
| 14             | 6       | 2023-07-02 14:30:00  | 5        | 40.0         |
| 15             | 7       | 2023-07-02 15:00:00  | 3        | 60.0         |
| 16             | 8       | 2023-07-02 15:30:00  | 5        | 70.0         |
| 17             | 1       | 2023-07-03 12:00:00  | 3        | 120.0        |
| 18             | 2       | 2023-07-03 12:30:00  | 5        | 80.0         |
| 19             | 3       | 2023-07-03 13:00:00  | 3        | 100.0        |
| 20             | 4       | 2023-07-03 13:30:00  | 5        | 50.0         |
+----------------+---------+----------------------+----------+--------------+*/

.mode table
.header on

-- Query with WITH clause
WITH StaffSales AS (
  SELECT 
    staff_name,
    SUM(total_amount) AS staff_total
  FROM Staff
  JOIN Transactions ON Staff.staff_id = Transactions.staff_id
  GROUP BY staff_name
)
SELECT 
  staff_name, 
  staff_total
FROM StaffSales
ORDER BY staff_total DESC;

-- Query with subquery
SELECT 
  staff_name Nickname,
  staff_role Position,
  (SELECT COUNT(*) FROM Transactions
      WHERE Staff.staff_id = Transactions.staff_id) 'Total Transaction'

FROM Staff;

-- Query with aggregate function and GROUP BY
SELECT 
  staff_role, 
  COUNT(*) AS total_staff
FROM Staff
GROUP BY staff_role;

/*+------------+-------------+
| staff_name | staff_total |
+------------+-------------+
| Nop        | 860.0       |
| Dom        | 610.0       |
+------------+-------------+
+----------+-----------+-------------------+
| Nickname | Position  | Total Transaction |
+----------+-----------+-------------------+
| Pakin    | Manager   | 0                 |
| Tiiw     | Head Chef | 0                 |
| Nop      | Waiter    | 10                |
| Ice Kogo | Chef      | 0                 |
| Dom      | Waiter    | 10                |
+----------+-----------+-------------------+
+------------+-------------+
| staff_role | total_staff |
+------------+-------------+
| Chef       | 1           |
| Head Chef  | 1           |
| Manager    | 1           |
| Waiter     | 2           |
+------------+-------------+*/
