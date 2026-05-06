#!/bin/bash
set -e

cat >> "$PGDATA/postgresql.conf" <<EOF
wal_level = replica
max_wal_senders = 10
hot_standby = on
EOF

cat >> "$PGDATA/pg_hba.conf" <<EOF
host replication replicator 0.0.0.0/0 trust
EOF

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE replicator WITH REPLICATION LOGIN;
    SELECT pg_create_physical_replication_slot('standby_slot');
EOSQL
