# MySQL client 설치 (필요한 빌드 도구도 같이 설치해야 할 수 있음)
apt update && apt install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    && pip install mysqlclient \
    && pip install PyHive

# DB 마이그레이션
superset db upgrade

# 관리자 계정 생성 (이미 존재할 경우 무시됨)
export FLASK_APP=superset
superset fab create-admin \
    --username admin \
    --firstname Superset \
    --lastname Admin \
    --email s85824904@gmail.com \
    --password admin1234 || true # 이미 관리자 계정이 존재한다면 무시

# 기본 role & 권한 설정
superset init

# ✅ MySQL & Presto 데이터베이스 등록
superset import_datasources -p /app/import_datasources.yaml

# Superset 웹 서버 실행
superset run -h 0.0.0.0 -p 8088 --with-threads --reload --debugger