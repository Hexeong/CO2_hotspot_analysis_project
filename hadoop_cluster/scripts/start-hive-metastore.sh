# Wait for PostgreSQL to be ready
/opt/wait-for-it.sh metastore-db:5432 --timeout=60 --strict -- \
  /opt/hive/bin/schematool -dbType postgres -initSchema --verbose

# Wait for HDFS NameNode to be ready
/opt/wait-for-it.sh namenode:8020 --timeout=60 --strict -- \
  /opt/hive/bin/hive --service metastore