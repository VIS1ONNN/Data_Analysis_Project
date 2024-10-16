## install.packages("tidyverse")
library(googlesheets4)
library(tidyverse)
library(dplyr)
gs4_deauth()

## variable_menu_from_googlesheet
all_menu <- read_sheet("https://docs.google.com/spreadsheets/d/1Jyb5NcAJs8P2lBezbnsUDEPCgPVAv57bBzSD3uT_5F4/edit?usp=sharing")
drink_menu <- filter(all_menu, Category== "Drinks")
food_menu <- filter(all_menu, Category== "Foods")

ordpz <- function(){
## greeting and showing a menu with prize
greeting <- c("Welcome to Pizza Picasso! We serve delicious, creative pizzas","Here is a Main menu and Drink")
print(greeting)
print(food_menu[c(2,5)])

## food first
## check for valid food selection (including 'n' to skip)
choose_food <- readline("Please choose menu (or 'n' to skip): ")
if (choose_food == "n" | choose_food %in% food_menu$Name){
  ## food selection is valid
  if (choose_food != "n"){
    food_price <- food_menu$Price.THB[match(choose_food,food_menu$Name)]
    print(paste("your pizza is gonna be",choose_food))
  } else {
    choose_food <- NULL
    food_price <- 0
} 
} else {
  print("sorry we don't have that please try again")
  return()
  ## exit
}

## showing drink menu
print(drink_menu[c(2,5)])
## check for valid drink selection (including 'n' to skip)
choose_drink <- readline("What kind of drinks do you want ? (or 'n' to skip): ")
## food selection is valid or skip
if (choose_drink == "n" | choose_drink %in% drink_menu$Name){
  if (choose_drink != "n"){
  drink_price <- drink_menu$Price.THB[match(choose_drink,drink_menu$Name)]
  print(paste("and your drink is gonna be",choose_drink))
  } else {
    choose_drink <- NULL
    drink_price <- 0
}
} else {
  print("sorry we don't have that drink")
  return()
  ## exit
}
print("check bill")

if (!is.null(choose_food) | !is.null(choose_drink)){
  total_price <- food_price + drink_price
  if(!is.null(choose_food)){
    print(paste("your food is",choose_food,"for",food_price,"THB"))
  }
  if(!is.null(choose_drink)){
    print(paste("and your drink is gonna be",choose_drink,"for",drink_price,"THB"))
  }
  print(paste("total",total_price,"THB"))
}
  else {
    print("You did not order anything.")
  }
        
}

ordpz()

# result
> ordpz()
[1] "Welcome to Pizza Picasso! We serve delicious, creative pizzas"
[2] "Here is a Main menu and Drink"                                
# A tibble: 5 × 2
  Name               Price.THB
  <chr>                  <dbl>
1 Margherita               199
2 Pepperoni Paradise       249
3 Hawaiian Delight         219
4 Carnivore's Dream        299
5 Veggie Fiesta            229
Please choose menu (or 'n' to skip): Margherita
[1] "your pizza is gonna be Margherita"
# A tibble: 3 × 2
  Name                              Price.THB
  <chr>                                 <dbl>
1 Soft Drinks (Coke, Sprite, Fanta)        35
2 Iced Tea                                 45
3 Fruit Juice                              49
What kind of drinks do you want ? (or 'n' to skip): Iced Tea
[1] "and your drink is gonna be Iced Tea"
[1] "check bill"
[1] "your food is Margherita for 199 THB"
[1] "and your drink is gonna be Iced Tea for 45 THB"
[1] "total 244 THB"
> 
