#!/bin/sh

#/**
# * Licensed to Apereo under one or more contributor license
# * agreements. See the NOTICE file distributed with this work
# * for additional information regarding copyright ownership.
# * Apereo licenses this file to you under the Apache License,
# * Version 2.0 (the "License"); you may not use this file
# * except in compliance with the License.  You may obtain a
# * copy of the License at the following location:
# *
# *   http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing,
# * software distributed under the License is distributed on an
# * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# * KIND, either express or implied.  See the License for the
# * specific language governing permissions and limitations
# * under the License.
# */

#
# *** SSP Check Database Table Count SSP Training Script ***
#
# This script checks the tables and in the future more from the ssp Postgres database
#  for SSP Training. This is to identify if SSP tables exist. It is automatically
#  executed for database 'ssp' using the psql command. 
#
# Params: 1st arg string name of the ssp database (optional)
#	  2nd arg string name of the ssp schema (optional)
#         3rd arg string name of the ssp db user (optional)
#
# Note: Requires Postgres 8.X or higher (SQL Script Dependency)
#

SQLFILEDIR="$(dirname $0)/../dataScripts"
DATABASE="ssp"
SCHEMA="public"
USER="postgres"
SSPTABLECOUNT28=265
TABLECOUNT=0


if [ "$#" -eq 3 ]; then
   DATABASE=$1
   SCHEMA=$2
   USER=$3     
   
elif [ "$#" -eq 2 ]; then
   DATABASE=$1
   SCHEMA=$2
   
elif [ "$#" -eq 1 ]; then 
   DATABASE=$1
fi 

echo "Executing: psql -d $DATABASE -U $USER -Atc \"SELECT count(*) FROM information_schema.tables WHERE table_schema = '$SCHEMA';\""
TABLECOUNT=`psql -d $DATABASE -U $USER -Atc "SELECT count(*) FROM information_schema.tables WHERE table_schema = '$SCHEMA';"`   
echo "Result: [$TABLECOUNT]"  

if [ "$TABLECOUNT" -ge "$SSPTABLECOUNT28" ]; then
    echo "Found at least $SSPTABLECOUNT28 tables!"
    exit 0
else 
    echo "Not enough tables or error connecting to database!"
    exit 1
fi

#END OF SCRIPT

