#!/bin/sh
psql -d routehappy -U routehappy -c "DROP SCHEMA routehappy CASCADE;"
psql -d routehappy -U routehappy -c "CREATE SCHEMA routehappy;"
#psql -d routehappytest -U routehappytest -c "DROP SCHEMA routehappytest CASCADE;"
#psql -d routehappytest -U routehappytest -c "CREATE SCHEMA routehappytest;"

