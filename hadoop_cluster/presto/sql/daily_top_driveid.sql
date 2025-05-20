WITH daily_traffic AS (
  SELECT
    DATE(timestamp) AS day,
    DriveID,
    COUNT(*) AS traffic_count
  FROM access_log_test_parquet
  GROUP BY DATE(timestamp), DriveID
),
ranked_traffic AS (
  SELECT
    day,
    DriveID,
    traffic_count,
    ROW_NUMBER() OVER (PARTITION BY day ORDER BY traffic_count DESC) AS rank
  FROM daily_traffic
)
SELECT
  day,
  DriveID,
  traffic_count
FROM ranked_traffic
WHERE rank = 1
ORDER BY day;
