-- hive에 저장된 통합 테이블로 집계 결과 생성
INSERT INTO mysql.datamart.hotspot_daily_emissions (day, Clat, Clon, total_co2_emission_estimate, emission_rank)
SELECT
  sub.day,
  TRY_CAST(sub.Clat AS DOUBLE) AS Clat,
  TRY_CAST(sub.Clon AS DOUBLE) AS Clon,
  sub.total_co2_emission_estimate,
  CAST(sub.emission_rank AS INTEGER) AS emission_rank
FROM (
  SELECT
    DATE("timestamp") AS day,
    Clat,
    Clon,
    SUM(COALESCE(body_bytes, 0)) AS total_co2_emission_estimate,
    RANK() OVER (
      PARTITION BY DATE("timestamp")
      ORDER BY SUM(COALESCE(body_bytes, 0)) DESC
    ) AS emission_rank
  FROM hive.default.access_log_test_parquet
  WHERE Clat IS NOT NULL AND Clon IS NOT NULL
  GROUP BY DATE("timestamp"), Clat, Clon
) AS sub
ORDER BY sub.day, sub.emission_rank;


-- 결과 출력
SELECT
  day,
  Clat,
  Clon,
  total_co2_emission_estimate,
  emission_rank
FROM mysql.datamart.hotspot_daily_emissions
WHERE emission_rank <= 10
ORDER BY day, emission_rank;