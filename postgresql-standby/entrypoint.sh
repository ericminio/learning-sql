#!/bin/bash
set -e

if [ "$(id -u)" = '0' ]; then
    mkdir -p "$PGDATA"
    chown -R postgres:postgres "$PGDATA"
    chmod 0700 "$PGDATA"
    exec gosu postgres "$BASH_SOURCE" "$@"
fi

if [ ! -s "$PGDATA/PG_VERSION" ]; then
    until pg_isready -h postgresql -p 5432 -q; do
        echo "standby waiting for primary..."
        sleep 1
    done

    pg_basebackup -h postgresql -D "$PGDATA" -U replicator -Fp -Xs -P -R --slot=standby_slot
fi

exec postgres
