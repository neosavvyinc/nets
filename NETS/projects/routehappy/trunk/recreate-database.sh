#!/bin/sh
psql -d commonsuser -U commonsuser -c "DROP SCHEMA commonsuser CASCADE;"
psql -d commonsuser -U commonsuser -c "CREATE SCHEMA commonsuser;"
psql -d commonstest -U commonstest -c "DROP SCHEMA commonstest CASCADE;"
psql -d commonstest -U commonstest -c "CREATE SCHEMA commonstest;"

