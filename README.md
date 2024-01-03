# COVID-19 Data Analysis Project

## Overview

This project aims to analyze COVID-19 data using SQL queries. The dataset is sourced from [Our World in Data](https://ourworldindata.org/covid-deaths). The raw data is processed in Microsoft Excel, creating two tables, and then imported into Microsoft SQL Server Management Studio for further analysis. The analysis includes insights into infection rates, death rates, vaccination progress, and more. The project is organized into various SQL queries, each serving a specific analytical purpose.

## Table of Contents

- [Database Structure](#database-structure)
- [SQL Queries](#sql-queries)
- [Analysis Highlights](#analysis-highlights)
- [How to Use](#how-to-use)
- [Contributing](#contributing)
- [License](#license)

## Database Structure

The database (`covid`) consists of tables such as `CovidDeaths` and `CovidVaccination` to store COVID-19 related information. The tables are designed to capture essential data like location, date, total cases, new cases, total deaths, population, and new vaccinations.

## SQL Queries
The SQL queries in this project cover a wide range of analyses, including:

- **Total Cases vs Total Deaths:** Analyzing the likelihood of death in COVID-19 in specific locations, such as Bangladesh.

- **Total Cases vs Population:** Examining what percentage of the population has contracted COVID-19 in specific locations.

- **Countries with Highest Infection Rate:** Identifying countries with the highest infection rate compared to their population.

- **Countries with Highest Death Count:** Listing countries with the highest death count.

- **Continents with Highest Death Count:** Highlighting continents with the highest death count per population.

- **Global Numbers:** Presenting global statistics on total cases, total deaths, and death percentage.

- **Population vs Vaccinations:** Analyzing the percentage of the population that has received at least one COVID vaccine.
...

## Analysis Highlights
### Likelihood of Dying in COVID-19 (Bangladesh)
The query calculates the death percentage in Bangladesh by comparing total deaths to total cases.

### Population Infected vs Population
This analysis provides insights into what percentage of the population in Bangladesh has been infected with COVID-19.

### Countries with Highest Infection Rate
The query identifies countries with the highest infection rate compared to their population.

### Population Vaccination Progress
Analyzing the progress of population vaccination by calculating the percentage of the population vaccinated over time.

### Views and Temporary Tables
The project utilizes SQL Views and Temporary Tables to simplify complex calculations and create reusable datasets for later analysis.


## How to Use

1. **Create Database into Microsoft SQL Server Management Studio:**
2. **Import tables into Newly Created Database:**
   - Table1 : Import **CovidDeaths.xlsx**
   - Table2 : Import **CovidVaccination.xlsx**
3. **Execute SQL queries:**
   - Run the provided SQL queries to perform various analyses.


## Contributing
This project features a comprehensive dataset of COVID-19, capturing data up to the latest available information. There is a myriad of opportunities for analysis, and contributions from the community are highly encouraged. Whether you have insights to share, additional analyses to conduct, or improvements to suggest, your input is valuable. Feel free to explore the dataset, run new SQL queries, or propose novel ways to extract meaningful information. Together, we can harness the power of this extensive dataset to gain deeper insights into the trends and patterns of the ongoing pandemic. Your contributions play a vital role in enhancing the overall understanding of COVID-19 through data analysis.
## License
This project is licensed under the **MIT License**.
