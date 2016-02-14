#!/usr/bin/env bash

DB=$1;

PGPASSWORD=secret psql -U postgres -c "CREATE DATABASE $1 WITH OWNER=cubebloc" || true