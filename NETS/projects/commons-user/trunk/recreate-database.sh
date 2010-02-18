#!/bin/sh
psql -d commonsuser -U commonsuser -c "DROP SCHEMA commonsuser CASCADE;"
psql -d commonsuser -U commonsuser -c "CREATE SCHEMA commonsuser;"

