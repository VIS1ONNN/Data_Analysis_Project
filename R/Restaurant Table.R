 ## load library
> 
> library(dplyr)
> library(RSQLite)
> library(sqldf)
> 
> ## create database if not have , will create new
> conn <- dbConnect(SQLite(), "restuarant_sql_Tiiw.db")
> 
> ## create data.frame  
> 
> ## staff
> staff <- data.frame(
+   staff_id = 1:5, # Added staff_id as a primary key
+   staff_name = c("Pakin", "Tiiw", "Nop", "Ice Kogo", "Dom"),
+   staff_role = c("Manager", "Head Chef", "Waiter", "Chef", "Waiter"),
+   staff_salary = c(100000, 70000, 55000, 58000, 50000)
+ )
> 
> ## menus
> menus <- data.frame(
+   menu_id = 1:4, # Added menu_id as a primary key
+   menu_name = c("Tom Yum Kung", "Pad Thai", "Thai Iced Tea", "Spring Rolls"),
+   price = c(120, 80, 40, 60),
+   categories = c("Main Dish", "Main Dish", "Drink", "Appetizer")
+ )
> 
> # Hypothetical transactions data
>   ## transaction_id = 1:10,
>   ## staff_id = sample(1:5, 10, replace = TRUE),
> 
> ## transactions by hypothetical technique
> transactions <- data.frame(
+   transaction_id = c(1, 2, 3),
+   order_date = c("2023-04-16", "2023-01-11", "2023-12-11"),
+   staff_id = c(3, 3, 5), #FK
+   menu_id = c(4, 2, 1), #FK
+   quantity = c(3, 2, 3)
+ )
> 
> ## add total price in transaction
> transactions <- transactions %>%
+   left_join(menus, by = "menu_id") %>%
+   mutate(total_price = quantity * price)
> 
> # write each data frame to a table
> dbWriteTable(conn, "staff", staff, overwrite=TRUE)
> dbWriteTable(conn, "menus", menus, overwrite=TRUE)
> dbWriteTable(conn, "transactions", transactions, overwrite=TRUE)
> 
> ## check table
> dbListTables(conn)
[1] "menus"        "staff"        "transactions"
> 
> ## check field
> dbListFields(conn,"menus")
[1] "menu_id"    "menu_name"  "price"      "categories"
> 
> # view the tables
> dbGetQuery(conn, "select * from staff")
  staff_id staff_name staff_role staff_salary
1        1      Pakin    Manager       100000
2        2       Tiiw  Head Chef        70000
3        3        Nop     Waiter        55000
4        4   Ice Kogo       Chef        58000
5        5        Dom     Waiter        50000
> dbGetQuery(conn, "select * from menus")
  menu_id     menu_name price categories
1       1  Tom Yum Kung   120  Main Dish
2       2      Pad Thai    80  Main Dish
3       3 Thai Iced Tea    40      Drink
4       4  Spring Rolls    60  Appetizer
> dbGetQuery(conn, "select * from transactions")
  transaction_id order_date staff_id menu_id quantity    menu_name
1              1 2023-04-16        3       4        3 Spring Rolls
2              2 2023-01-11        3       2        2     Pad Thai
3              3 2023-12-11        5       1        3 Tom Yum Kung
  price categories total_price
1    60  Appetizer         180
2    80  Main Dish         160
3   120  Main Dish         360
> 
> ## test query
> ## calculate the total income for each employee.
> dbGetQuery(conn,"SELECT s.staff_name, SUM(m.price * t.quantity) AS total_income
+            FROM staff s
+            JOIN transactions t ON s.staff_id = t.staff_id
+            JOIN menus m ON t.menu_id = m.menu_id
+            GROUP BY s.staff_name;")
  staff_name total_income
1        Dom          360
2        Nop          340
> 
> ## disconnect from the database
> dbDisconnect(conn)


 > ## you can generate more transactions by
  transactions <- data.frame(
  transactions_id = 1:20,
  order_date = c(sample(seq(as.Date('yyyy-mm-dd'),as.Date('yyyy-mm-dd'), by="day"),20,replace = T)),
  staff_id = c(sample(1:5, 20, replace = T)),
  menu_id = c(sample(1:4, 20, replace = T)),
  quantity = c(sample(1:3, 20, replace = T))
  )
