# 탄소배출 핫스팟 분석용 Hadoop 클러스터
차량 이동 데이터를 기반으로 경도, 위도별 차량 이동량을 집계하기 위한 빅데이터 처리용 클러스터 입니다.

## Framework/Library

### 🗂 Data Lake
![Apache Hadoop](https://img.shields.io/badge/apache_hadoop-66CCFF.svg?style=for-the-badge&logo=apachehadoop&logoColor=white)

### 📦 Metastore
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

### 🏛 Data Warehouse
![Apache Hive](https://img.shields.io/badge/apache_hive-FDEE21.svg?style=for-the-badge&logo=apachehive&logoColor=white)

### 📊 Analysis Query Engine
![Presto](https://img.shields.io/badge/presto-5890FF.svg?style=for-the-badge&logo=presto&logoColor=white)

### 🌐 Distributed Network
![Docker Compose](https://img.shields.io/badge/docker_compose-2496ED.svg?style=for-the-badge&logo=docker&logoColor=white)

### 🗄 Aggregation Data Storage
![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white)

### 📈 Visualization
![Superset](https://img.shields.io/badge/mysql-20A6C9.svg?style=for-the-badge&logo=apachesuperset&logoColor=white)



## 분석방법
```
// namenode 컨테이너에서 실행, raw_data인 csv파일을 hdfs 상에 업로드하는 script 실행
# /init-hdfs.sh

// hive-server 컨테이너에서 실행, hive-metastore postgres schema init 작업이 모두 완료된
// 상태에서 시작하기 위해 script 자동화를 포기 및 따로 script를 분리.
// 해당 script는 hiveserver2를 실행하는 코드
# /opt/init-and-start-hive.sh

// hive-server 컨테이너에서 실행, beeline을 통해 저장된 sql 문을 사용하여 hdfs상에 업로드된
// csv 파일에서 데이터를 뽑아 외부테이블 생성 및 Parquet으로 변환
# beeline -u jdbc:hive2://localhost:10000 -n "" -p "" -f /etc/hive/create_external_and_transform_parquet_test.sql

// 이후 presto-coordinator에서 , presto를 통해 hive의 parquet으로 변환한 테이블이 
// 잘 저장되어 있는지와 hive와 잘 연결되었는지 확인
# presto-cli --catalog hive --schema default
# show tables;
# exit

// 만약, .sql 파일로 실행시키고자 한다면 다음과 같은 명령어 실행
# presto-cli --file /sql/daily_hotspot_by_position.sql --catalog hive --schema default
-> prestodb/presto는 /opt/persto 폴더를 default 설정으로 사용하지 않고, /opt/presto-server
-> 폴더를 사용하는 문제가 있었지만, iamage docs를 찾아본 다음 해결

-> 이후, Query 실행시 메모리 초과 오류 발생, Presto는 모든 데이터를 메모리에 올린다음 빠르게 
-> 실행시키기 떄문에 데이터를 불러오는 과정에서 Heap 메모리가 초과된 것
-> 이를 해결하고자 config.properties 파일에서 query.max-memory값을 높여서 해결

-> 나중에는 더 적은 메모리로 가능하도록 쿼리 최적화 진행을 할 예정

```