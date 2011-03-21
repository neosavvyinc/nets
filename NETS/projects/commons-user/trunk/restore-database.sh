#!/bin/bash
#run as postgres user
#./recreate-database.sh
psql --username=commonsuser commonsuser < prod-backups/03-19-2011.sql
