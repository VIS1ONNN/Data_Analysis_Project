"""
# Final Project - Analyzing Sales Data

**Date**: 14 December 2024

**Author**: Wisaithat Choocheep

**Course**: `Pandas Foundation`
"""

# import data
import pandas as pd
df = pd.read_csv("/data/notebook_files/sample-store.csv")

# preview top 5 rows
df.head()

# shape of dataframe
df.shape

# see data frame information using .info()
df.info()

# example of pd.to_datetime() function
pd.to_datetime(df['Order Date'].head(), format='%m/%d/%Y')

# TODO - convert order date and ship date to datetime in the original dataframe
df['Order Date'] = pd.to_datetime(df["Order Date"],format="%m/%d/%Y")
df['Ship Date'] = pd.to_datetime(df["Ship Date"],format="%m/%d/%Y")
df.info()

# TODO - count nan in postal code column
df["Postal Code"].isna().sum()

# TODO - filter rows with missing values
df[df["Postal Code"].isna()]

# TODO - Explore this dataset on your owns, ask your own questions
# Top-selling products in customer segment over the past
sellbypd = df.groupby(['Segment', 'Product Name'])['Sales'].agg('sum')
sellbypd.sort_values(ascending= False).reset_index()

"""
## Data Analysis Part

Answer 10 below questions to get credit from this course. Write `pandas` code to find answers.
"""

# TODO 01 - how many columns, rows in this dataset
# Check with shape fn result print - rows, column
df.shape 

print(f"This dataset has {df.shape[0]} Columns\nand {df.shape[1]} Rows")

# TODO 02 - is there any missing values?, if there is, which colunm? how many nan values?
# Check it with info fn
df.info() 
print(f"After checking the dataset, I found that there are { 9994 - 9983 } missing values in the 'Postal Code' column.")

# TODO 03 - your friend ask for `California` data, filter it and export csv for him
calidata = df[df['State'] == 'California']
calidata.to_csv("StoreCalifornia.csv",index = False)

# TODO 04 - your friend ask for all order data in `California` and `Texas` in 2017 (look at Order Date), send him csv file
# add year column to dataset * .dt.year: Extract the year.
df['Year'] = df['Order Date'].dt.year

# filter Order in 2017 out, assign it to order_2017
order_2017 = df[df['Year'] == 2017]

# filter State Cali, Texas out
calitex2017 = order_2017[(order_2017['State'] == 'California' ) | (order_2017['State'] == 'Texas')]

# write to csv
calitex2017.to_csv("California and Texas in 2017.csv", index = False )

# TODO 05 - how much total sales, average sales, and standard deviation of sales your company make in 2017
order_2017['Sales'].agg(['sum', 'mean', 'std'])

# TODO 06 - which Segment has the highest profit in 2018
# filter year 2018 out
sale2018 = df[df['Year'] == 2018]

# groupby Segment and Sum Profits
sale2018.groupby('Segment')['Profit'].sum()

# TODO 07 - which top 5 States have the least total sales between 15 April 2019 - 31 December 2019
# filter data between 15 April 2019 - 31 December 2019 out
orderbet = df[(df['Order Date'] >= '2019-04-15') & (df['Order Date'] <= '2019-12-31')]

# group by state with prep data
prepdata = orderbet.groupby('State')['Sales'].sum()

# sort by sum sale
prepdata.sort_values().head()

# TODO 08 - what is the proportion of total sales (%) in West + Central in 2019 e.g. 25% 
# filter order in 2019 out
data2019 = df[df['Year'] == 2019]

## Sum sales in west and Central
a = data2019[(data2019['Region'] == 'West') | (data2019['Region'] == 'Central')]['Sales'].sum()

## Sum sales in 2019
b = data2019['Sales'].sum()

## Answer
print(f"The proportion of total sales in West + Central in 2019 is: {round(a/b * 100, 0)}%")

# TODO 09 - find top 10 popular products in terms of number of orders vs. total sales during 2019-2020

# filter data during 2019 - 2020 out
sales1920 = df[(df['Year'] == 2019 )|( df['Year'] == 2020)]

# groupby 'Product Name' then Sum('Sales', 'Quantity')
prepdata2 = sales1920[['Product Name', 'Sales', 'Quantity']].groupby('Product Name')[['Quantity', 'Sales']].sum()

# Sort by Quantity
sq = prepdata2.sort_values('Quantity', ascending = False).head(10)

# Sort by Sales
ss = prepdata2.sort_values('Sales', ascending = False).head(10)

# Add rank number
sq = sq.reset_index()
ss = ss.reset_index()
sq.index += 1
ss.index += 1

# Print Result
print('Top 10 products with the highest order volume:\n ')
print(sq)
print('-------------------------------------------------------------\
----------')
print('Top 10 products with the highest revenue:\n ')
print(ss)

# TODO 10 - plot at least 2 plots, any plot you think interesting :)
# Regional Transaction Volume
df['Region'].value_counts().plot(kind = 'pie', autopct='%1.1f%%'); ## this came from Gemini 

df['Segment'].value_counts().plot(kind = 'bar');

# TODO Bonus - use np.where() to create new column in dataframe to help you answer your own questions
import numpy as np

# question: Order quantity can significantly impact shipping times.
# Categorize our orders into three groups based on quantity:
# Single-item orders (1 piece)
# Small quantity orders (2-5 pieces)
# Bulk orders (6 pieces and above)

# calculate shipment duration and Segmentation of order sizes
df['Shipment Duration'] = df['Ship Date'] - df['Order Date']
df['Quantity Group'] = np.where(df['Quantity'] == 1,'Single-item',np.where(df['Quantity'] >= 6,'Bulk orders','Small quantity'))
dfsmall = df.groupby(['Quantity Group'])['Shipment Duration'].mean().reset_index()
dfsmall

## Order quantity does not significantly impact shipping times.

