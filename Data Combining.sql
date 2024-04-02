-- Data Combining

DROP TABLE IF EXISTS `GDA.2023_combined_data`;

-- combining all the 12 months data tables into a single table containing data from Jan 2023 to Dec 2023.

CREATE TABLE IF NOT EXISTS `GDA.2023_combined_data` AS (
  SELECT * FROM `GDA.202301`
  UNION ALL
  SELECT * FROM `GDA.202302`
  UNION ALL
  SELECT * FROM `GDA.202303`
  UNION ALL
  SELECT * FROM `GDA.202304`
  UNION ALL
  SELECT * FROM `GDA.202305`
  UNION ALL
  SELECT * FROM `GDA.202306`
  UNION ALL
  SELECT * FROM `GDA.202307`
  UNION ALL
  SELECT * FROM `GDA.202308`
  UNION ALL
  SELECT * FROM `GDA.202309`
  UNION ALL
  SELECT * FROM `GDA.202310`
  UNION ALL
  SELECT * FROM `GDA.202311`
  UNION ALL
  SELECT * FROM `GDA.202312`
);

-- checking no of rows which are 5719877

SELECT COUNT(*)
FROM `GDA.2023_combined_data`;
