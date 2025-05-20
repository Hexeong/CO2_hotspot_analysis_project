# CSV 파일을 읽어 외부 테이블 생성
CREATE EXTERNAL TABLE access_log_test_raw (
    Clat STRING,
    Clon STRING,
    Decoding_Feat STRING,
    Dlat STRING,
    Dlon STRING,
    DriveID STRING,
    Guidance STRING,
    OP STRING,
    Reset INT,
    TP_Apps STRING,
    TP_SID STRING,
    Traffic_Mode STRING,
    Vers STRING,
    body_bytes INT,
    `method` STRING,
    referrer STRING,
    response_time FLOAT,
    `status` INT,
    `timestamp` TIMESTAMP,
    uaVers STRING,
    user_agent STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse/dataset';

# Parquet 형식으로 데이터 변환 및 저장
CREATE TABLE access_log_test_parquet
STORED AS PARQUET
AS
SELECT * FROM access_log_test_raw;