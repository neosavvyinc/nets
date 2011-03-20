#!/bin/bash
#run as postgres user
#./recreate-database.sh
psql commonsuser < prod-backups/03-19-2011.sql
