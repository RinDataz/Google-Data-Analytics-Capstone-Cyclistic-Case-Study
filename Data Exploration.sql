-- Data Exploration

-- checking the data types of all columns

SELECT column_name, data_type
FROM `GDA`.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = `GDA.2023_combined_data`;

-- checking for number of null values in all columns

SELECT COUNT(*) - COUNT(ride_id) ride_id,
 COUNT(*) - COUNT(rideable_type) rideable_type,
 COUNT(*) - COUNT(started_at) started_at,
 COUNT(*) - COUNT(ended_at) ended_at,
 COUNT(*) - COUNT(start_station_name) start_station_name,
 COUNT(*) - COUNT(start_station_id) start_station_id,
 COUNT(*) - COUNT(end_station_name) end_station_name,
 COUNT(*) - COUNT(end_station_id) end_station_id,
 COUNT(*) - COUNT(start_lat) start_lat,
 COUNT(*) - COUNT(start_lng) start_lng,
 COUNT(*) - COUNT(end_lat) end_lat,
 COUNT(*) - COUNT(end_lng) end_lng,
 COUNT(*) - COUNT(member_casual) member_casual
FROM `GDA.2023_combined_data`;

-- checking for duplicate rows

SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM `GDA.2022_combined_data`;

-- ride_id - all have length of 16

SELECT LENGTH(ride_id) AS length_ride_id, COUNT(ride_id) AS no_of_rides
FROM `GDA.2023_combined_data`
GROUP BY length_ride_id;

-- rideable_type - 3 unique types of bikes

SELECT DISTINCT rideable_type AS Bikes_types, COUNT(rideable_type) AS Rides_num
FROM `GDA.2023_combined_data`
GROUP BY rideable_type;

-- checking the formatting
-- started_at, ended_at - TIMESTAMP - YYYY-MM-DD hh:mm:ss UTC

SELECT started_at, ended_at
FROM `GDA.2023_combined_data`
LIMIT 10;

-- Checking the duration of rides
SELECT COUNT(*) AS longer_than_a_day
FROM `GDA.2023_combined_data`
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at)) / 60) >= 1440;   -- longer than a day - total rows = 6418

SELECT COUNT(*) AS less_than_a_minute
FROM `GDA.2023_combined_data`
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at)) / 60) <= 1;      -- less than a minute - total rows = 151069

-- start_station_name, start_station_id - total 875848 rows with both start station name and id missing

SELECT DISTINCT start_station_name
FROM `GDA.2023_combined_data`
ORDER BY start_station_name;

SELECT COUNT(ride_id) AS rows_with_start_station_null          -- return 875848 rows
FROM `GDA.2023_combined_data`
WHERE start_station_name IS NULL OR start_station_id IS NULL;

-- end_station_name, end_station_id - total 929343 rows with both end station name and id missing

SELECT DISTINCT end_station_name
FROM `GDA.2023_combined_data`
ORDER BY end_station_name;

SELECT COUNT(ride_id) AS rows_with_null_end_station          -- return 929343 rows
FROM `GDA.2023_combined_data`
WHERE end_station_name IS NULL OR end_station_id IS NULL;

-- end_lat, end_lng - total 6990 rows with both missing

SELECT COUNT(ride_id) AS rows_with_null_end_loc
FROM `GDA.2023_combined_data`
WHERE end_lat IS NULL OR end_lng IS NULL;

-- member_casual - 2 unique values - member and casual riders

SELECT DISTINCT member_casual AS cust_type, COUNT(member_casual) AS rides_no
FROM `GDA.2023_combined_data`
GROUP BY member_casual;

