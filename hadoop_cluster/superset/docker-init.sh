# DB 마이그레이션
superset db upgrade

# 관리자 계정 생성 (이미 존재할 경우 무시됨)
export FLASK_APP=superset
superset fab create-admin \
    --username admin \
    --firstname Admin \
    --lastname User \
    --email admin@example.com \
    --password admin1234

# 기본 role & 권한 설정
superset init

# Superset 웹 서버 실행
superset run -h 0.0.0.0 -p 8088 --with-threads --reload --debugger