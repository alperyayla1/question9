use db;

SELECT *, 
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY daily_vaccinations) 
           OVER (PARTITION BY country) AS median_daily_vaccinations
		   INTO #temp_updated_data
		   from tableName


UPDATE #temp_updated_data
SET daily_vaccinations = median_daily_vaccinations
WHERE daily_vaccinations IS NULL OR daily_vaccinations = 0;
select * from #temp_updated_data

SELECT DISTINCT TOP 3 country, median_daily_vaccinations
FROM #temp_updated_data
ORDER BY median_daily_vaccinations DESC;

SELECT SUM(daily_vaccinations) AS total_vaccinations
FROM #temp_updated_data
WHERE date = '1/6/2021';

SELECT *
INTO country_vaccination_stats_updated
FROM #temp_updated_data;

SELECT * FROM country_vaccination_stats_updated