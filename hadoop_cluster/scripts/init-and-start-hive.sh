chmod +x /opt/init-and-start-hive.sh

echo "Waiting for Hive Metastore to be ready..."
/opt/wait-for-it.sh hive-metastore:9083 --timeout=60 --strict -- echo "Hive Metastore is up"

echo "Starting HiveServer2..."
exec /opt/hive/bin/hive --service hiveserver2