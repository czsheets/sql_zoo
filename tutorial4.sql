-- SELECT within SELECT


-- 1. List each country name where the population is larger than 'Russia'.

SELECT name FROM world
WHERE population >
  (SELECT population FROM world
      WHERE name='Russia')


-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name
FROM world
WHERE continent = 'Europe'
AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom')


-- 3. List the name and continent of countries in the continents containing 'Belize', 'Belgium'.

SELECT name, continent
FROM world
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Belize', 'Belgium'))


 -- 4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.

SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland')


 -- 5. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

SELECT name
FROM world
WHERE gdp > ALL (SELECT gdp FROM world WHERE continent = 'Europe' and gdp IS NOT NULL)


-- 6. Find the largest country (by area) in each continent, show the continent, the name and the area:

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)


-- 7. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.

SELECT name, continent, population FROM world WHERE continent IN (SELECT continent
FROM world
GROUP BY continent
HAVING MAX(population) <= 25000000)


-- 8. Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.

SELECT name, continent
FROM world x
WHERE x.population > ALL (SELECT population * 3 FROM world y WHERE x.continent = y.continent AND x.name <> y.name)