#!/bin/bash

# HDFS 초기화 작업
echo "▶ Running init-hdfs.sh..."

# HDFS 디렉터리 생성
hdfs dfs -mkdir -p /user/hive/warehouse/dataset

# CSV 파일들을 HDFS에 업로드
hdfs dfs -put -f /hadoop/warehouse/dataset/*.csv /user/hive/warehouse/dataset/

# 확인용 로그 출력
echo "=== Uploaded CSV files to HDFS ==="
hdfs dfs -ls /user/hive/warehouse/dataset

# HDFS 초기화 작업이 끝난 후 종료
# echo "▶ HDFS initialization complete. Exiting..."
# exit 0