set -e

# 원하는 CLI 버전 지정
PRESTO_CLI_VERSION="350"
PRESTO_CLI_URL="https://repo1.maven.org/maven2/io/prestosql/presto-cli/${PRESTO_CLI_VERSION}/presto-cli-${PRESTO_CLI_VERSION}-executable.jar"
INSTALL_PATH="/usr/local/bin/presto"

# Presto CLI 다운로드
echo "[INFO] Downloading Presto CLI v${PRESTO_CLI_VERSION}..."
curl -L ${PRESTO_CLI_URL} -o ${INSTALL_PATH}

# 실행 권한 부여
chmod +x ${INSTALL_PATH}

echo "[INFO] Presto CLI installed at ${INSTALL_PATH}"

# Presto 서버 실행
echo "[INFO] Starting Presto Coordinator..."
exec /usr/lib/presto/bin/run-presto