# Parquet 형식으로 데이터 변환 및 저장
CREATE TABLE access_log_test_parquet
STORED AS PARQUET
AS
SELECT * FROM access_log_test_raw;