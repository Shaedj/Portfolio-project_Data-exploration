-- Exploratory Data Analysis

SELECT*
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;
-- According to this data, there's a company which laid off 12000 people in a day, and another/others which laid off 100% of its employees!!

SELECT*
FROM layoffs_staging2
WHERE percentage_laid_off = '1'
Order by total_laid_off desc;
-- The Company 'Katerra' is one of the companies which laid off 100% of it's employees, laying off the highest amount.

SELECT*
FROM layoffs_staging2
WHERE percentage_laid_off = '1'
Order by funds_raised_millions Desc;
-- The company 'Britishvolt' has made the most money is another company to lay off 100% of their employees. 

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP by company
Order by 2 Desc;
-- Company All time laid off highest to lowest

Select *
FROM layoffs_staging2
WHERE company = 'AMAZON';
-- Amazon has the highest layoff of all time. (In the dataset)

Select*
FROM layoffs_staging2
WHERE total_laid_off = '12000';
-- Google has the highest layoff in a day. (In the dataset)

SELECT Min(`date`), MAX(`date`)
FROM layoffs_staging2;
-- Dates the dateset starts and ends with

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP by industry
Order by 2 Desc;
-- Highest to lowest industry lay offs of all time

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP by country
Order by 2 Desc;
-- Country from highest to lowest in all time lay offs.

SELECT `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP by `date`
Order by 2 Desc;
-- Dates with the highest to lowest lay offs all time

SELECT `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP by `date`
Order by 1 ASC;
-- Layoff everyday from earliest to latest. 

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP by YEAR(`date`)
Order by 1 ASC;
-- Layoffs every year

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP by stage
Order by 2 Desc;
-- Stage layoffs from highest to lowest

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP by company
Order by 2 Desc;

SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) is not null
GROUP by `MONTH`
ORDER by 1 asc;
-- Every month on the dataset earliest to latest, and their lay offs.
 
 WITH Rolling_Total AS
 (
 SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS total_off
 FROM layoffs_staging2
 WHERE SUBSTRING(`date`, 1, 7) is not NULL
 GROUP by `MONTH`
 ORDER by 1 ASC
 )
 SELECT `MONTH`, total_off,
 SUM(total_off) OVER(Order BY `MONTH`) AS rolling_total
 FROM Rolling_total;
-- This shows how as the months progress, the total laid off keep adding on for the 'rolling_total' column, and side by side we can see how many lay offs each month has in general. 
-- Good for visualizations

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP by company
Order by 2 Desc;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP by company, YEAR(`date`)
Order by 3 desc;

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP by company, YEAR(`date`)
), Company_year_Rank AS
(SELECT*, DENSE_RANK() OVER (partition by YEARS ORDER BY total_laid_off desc) AS Ranking
FROM Company_Year
Where years is not NULL
)
SELECT *
FROM Company_year_Rank
WHERE RANKING <= 5;
-- The top 5 Rankings for every year, when it comes to people being layed off. 








