Select * from covid.dbo.CovidDeaths
order by 3,4



SELECT location,date,total_cases,new_cases,total_deaths,population

FROM covid..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths
--Shows likelihood of dying in covid in bangladesh
SELECT location,date,total_cases,total_deaths,(TRY_CONVERT(float,total_deaths)/TRY_CONVERT(float,total_cases))*100 AS death_percentage
FROM covid..CovidDeaths
WHERE continent IS NOT NULL
AND location like '%Bangladesh%'
ORDER BY 1,2 DESC


--Looking at Total cases vs Population
--Shows What percentage of population got covid
SELECT location,date,total_cases,population,(TRY_CONVERT(float,total_deaths)/TRY_CONVERT(float,population))*100 AS PercentPopulationInfected
FROM covid..CovidDeaths
WHERE continent IS NOT NULL
AND location like '%Bangladesh%'
ORDER BY 1,2 DESC

--Looking at Countries with Highest Infection Rate compared to populaiton

SELECT location,MAX(TRY_CONVERT(float,total_cases))AS HighestInfectionCount,population,MAX(TRY_CONVERT(float,total_cases)/TRY_CONVERT(float,population))*100 AS PercentPopulationInfected

FROM covid..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location,population

ORDER BY PercentPopulationInfected DESC


--Contries with Highest Death Coubnt Per Population

SELECT location,MAX(TRY_CONVERT(float ,total_deaths))AS HighestDeathsCount

FROM covid..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY HighestDeathsCount DESC



--Continents with the highest death count per populaiton
SELECT continent,MAX(TRY_CONVERT(float ,total_deaths))AS TotalDeathsCount

FROM covid..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathsCount DESC

--GLOBAL NUMBERS


SELECT SUM(CAST(new_cases AS float))  as total_cases ,SUM(CAST(new_deaths as float)) as total_deaths,
CASE
        WHEN SUM(CAST(new_deaths AS FLOAT)) = 0 THEN 0
        ELSE (SUM(CAST(new_deaths AS FLOAT)) / NULLIF(SUM(CAST(new_cases AS FLOAT)), 0)) * 100
END AS DeathPercentage

FROM covid..CovidDeaths
WHERE continent is not null
--GROUP BY date
ORDER BY 1,2 DESC


--Looking at Total Population vs Vaccinations
--Percentage of Population that has recieved at least one Covid Vaccine
SELECT  dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS RollingPeopleVaccinated
FROM covid..CovidDeaths dea
JOIN covid..covidvaccination vac
ON dea.location=vac.location
and dea.date=vac.date
WHERE dea.continent is not NULL
ORDER BY 2 ,3 


-- Using CTE to perform Calculation on Partition By in previous query
WITH PopvsVac(Continent,Location,Date,Population,NewVaccinations,RollingPeopleVaccinated)

AS

(
SELECT  dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS RollingPeopleVaccinated
FROM covid..CovidDeaths dea
JOIN covid..covidvaccination vac
ON dea.location=vac.location
and dea.date=vac.date
WHERE dea.continent is not NULL
--ORDER BY 2 ,3 
)

SELECT * ,(RollingPeopleVaccinated/Population)*100 AS PercentPopulationVaccinated

FROM PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric)


Insert into #PercentPopulationVaccinated
SELECT  dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS RollingPeopleVaccinated
FROM covid..CovidDeaths dea
JOIN covid..covidvaccination vac
ON dea.location=vac.location
and dea.date=vac.date
WHERE dea.continent is not NULL
--ORDER BY 2 ,3 


SELECT * ,(RollingPeopleVaccinated/Population)*100 AS PercentPopulationVaccinated
FROM #PercentPopulationVaccinated



--Creating View to Store data for later visualization

CREATE VIEW PercentPopulationVaccinated AS 

SELECT  dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS RollingPeopleVaccinated
FROM covid..CovidDeaths dea
JOIN covid..covidvaccination vac
ON dea.location=vac.location
and dea.date=vac.date
WHERE dea.continent is not NULL
--ORDER BY 2 ,3


--FROM VIEWS
SELECT * FROM PercentPopulationVaccinated