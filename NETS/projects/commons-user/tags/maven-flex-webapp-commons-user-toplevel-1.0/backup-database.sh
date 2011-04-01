#!/bin/bash
# su to postgres user to run this script
DATE=`date +"%m-%d-%Y"`
pg_dump commonsuser > prod-backups/$DATE.sql
