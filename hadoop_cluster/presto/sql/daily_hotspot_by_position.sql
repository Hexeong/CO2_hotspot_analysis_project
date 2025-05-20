WITH daily_location_emissions AS (
  SELECT
    DATE("timestamp") AS day,
    Clat,
    Clon,
    SUM(COALESCE(body_bytes, 0)) AS total_co2_emission_estimate
  FROM access_log_test_parquet
  WHERE Clat IS NOT NULL AND Clon IS NOT NULL
  GROUP BY DATE("timestamp"), Clat, Clon
),
ranked_hotspots AS (
  SELECT
    day,
    Clat,
    Clon,
    total_co2_emission_estimate,
    RANK() OVER (PARTITION BY day ORDER BY total_co2_emission_estimate DESC) AS emission_rank
  FROM daily_location_emissions
)

SELECT
  day,
  Clat,
  Clon,
  total_co2_emission_estimate,
  emission_rank
FROM ranked_hotspots
WHERE emission_rank <= 10
ORDER BY day, emission_rank;
