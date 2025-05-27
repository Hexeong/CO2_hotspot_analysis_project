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
SELECT 
  (CAST(Clat AS DOUBLE) / POWER(2, 32)) * 360 AS Clat,
  (CAST(Clon AS DOUBLE) / POWER(2, 32)) * 360 AS Clon,
  Decoding_Feat,
  Dlat,
  Dlon,
  DriveID,
  Guidance,
  OP,
  `Reset`,
  TP_Apps,
  TP_SID,
  Traffic_Mode,
  Vers,
  body_bytes,
  `method`,
  referrer,
  response_time,
  `status`,
  `timestamp`,
  uaVers,
  user_agent
FROM access_log_test_raw
WHERE `status` = 200
AND NOT (
  DriveID LIKE 'AKAMA%' OR 
  DriveID LIKE 'MONIT%' OR 
  DriveID LIKE 'NAVIS%'
);
