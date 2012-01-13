#!/bin/bash
#run as postgres user
#./recreate-database.sh
psql --username=commonsuser commonsuser < prod-backups/01-12-2012.sql
