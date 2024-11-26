# Wine Data Analysis Project

This project involves analyzing wine data from two large datasets using MySQL. The goal is to explore various SQL techniques, such as joins, aggregations, and filtering, to gain insights into the data, including price, ratings, and wine variety trends.

## Datasets

- **winemag-data-130k-v2.csv**: A dataset with 130,000+ records of wine information, including attributes such as country, variety, price, and points.
- **winemag-data_first150k.csv**: A similar dataset with 150,000 records containing wine data.

## Project Overview

The project demonstrates how to use SQL to perform data analysis on two wine datasets. Key operations such as uploading data into MySQL, joining tables, and performing aggregation are included. The following SQL operations are covered:

- **Uploading Data**: Data is uploaded from CSV files into MySQL using `LOAD DATA INFILE`.
- **Joins**: Tables are joined on the `winery` column to combine wine information from both datasets.
- **Aggregation**: Various aggregation functions such as `AVG()`, `SUM()`, and `COUNT()` are used to analyze average prices, total points, and wine counts.
- **Filtering and Grouping**: Data is filtered based on conditions (e.g., price, rating) and grouped by attributes like `winery`, `variety`, and `country`.

## Setup Instructions

To get started with the project, follow these steps:

### 1. Set Up MySQL Database

First, create a database in MySQL to store the wine data:

```sql
-- Create a new database
CREATE DATABASE winemag_data;

-- Use the new database
USE winemag_data;
