USE uber_project;
LOAD DATA INFILE "C:\Users\Dell\OneDrive\Desktop\uber_data.csv"
INTO TABLE uber_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SHOW VARIABLES LIKE "secure_file_priv";

Select * from uber_data LIMIT 10;
--   1. Total number of requests
SELECT COUNT(*) AS total_requests FROM uber_data;
-- 2. Requests per pickup point
SELECT 'Pickup point', COUNT(*) AS total_requests 
FROM uber_data GROUP BY 'Pickup point' ;
-- 3. Status wise request count
SELECT Status, COUNT(*) AS count 
FROM uber_data 
GROUP BY Status;
-- 4. Request status per pickup poin
select 'Pickup point', Status, COUNT(*) AS count 
FROM uber_data 
GROUP BY 'Pickup point', Status;
-- 5. Hourly demand trend
SELECT Hour, COUNT(*) AS total_requests 
FROM uber_data 
GROUP BY Hour 
ORDER BY Hour;
-- 6. Supply-Demand Gap (Unfulfilled Requests)
SELECT 'Pickup point', COUNT(*) AS supply_gap 
FROM uber_data 
WHERE Status != 'Trip Completed' 
GROUP BY 'Pickup point';
-- 7. Cancellations per hour
SELECT Hour, COUNT(*) AS cancelled_rides 
FROM uber_data 
WHERE Status = 'Cancelled' 
GROUP BY Hour 
ORDER BY cancelled_rides DESC;
-- 8. Trip duration stats
SELECT 
  MIN('Trip Duration (mins)') AS min_duration,
  MAX('Trip Duration (mins)') AS max_duration,
  AVG('Trip Duration (mins)') AS avg_duration
FROM uber_data
WHERE Status = 'Trip Completed';