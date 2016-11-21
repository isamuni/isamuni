#!/bin/bash
set -e

POSTGRES_USER="postgres"
POSTGRES="psql --username ${POSTGRES_USER}"

DB_USER="isamuni"
DB_PASS="isamuni"
echo "Creating database role: ${DB_USER}"

$POSTGRES <<-EOSQL
CREATE USER ${DB_USER} WITH CREATEDB PASSWORD '${DB_PASS}';
EOSQL
