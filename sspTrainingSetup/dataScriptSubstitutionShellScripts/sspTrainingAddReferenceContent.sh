#!/bin/sh

# Licensed to Jasig under one or more contributor license
# agreements. See the NOTICE file distributed with this work
# for additional information regarding copyright ownership.
# Jasig licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file
# except in compliance with the License. You may obtain a
# copy of the License at:
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#

#
# *** SSP Insert Static Reference Content into SSP Training Script ***
#
# This script inserts static reference content that is referenced by students and coaches
#  into a postgres SSP database. It does so by calling a psql command on database 'ssp' 
#  that loads a sql file and inserts it into the database. 
#
# Params: 1st OPTIONAL arg number=1 to tell script to output to file 
#	 	instead of the db. File is set to 
#           ../postgres/sspTrainingDataCompiled(TODAY'S DATE).sql
#
#
# Note: Requires Postgres 8.X or higher (SQL Script Dependency)
#

SQLFILEDIR="$(dirname $0)/../dataScripts"
CONTENTSQLFILE="sspTrainingImmutableStartupContent.sql"
DATE=$(date +"%m-%d-%Y")
OUTPUTFILE="../postgres/sspTrainingDataCompiled$DATE.sql"

if [ -e "$SQLFILEDIR/$CONTENTSQLFILE" ]; then
   if [ "$#" -lt 1 ]; then
       psql -d ssp -U postgres -f $SQLFILEDIR/$CONTENTSQLFILE   
       echo "Loading reference content complete"
       exit $?
   
   #Print To File Option
   elif [ "$#" -eq 1 ] && [ "$1" -eq 1 ]; then
       cat $SQLFILEDIR/$CONTENTSQLFILE  >> $OUTPUTFILE 
       echo "Printing reference content to file complete"
       exit $?
   #End Print To File Option

   else
	echo "Improper number of input arguments script: sspTrainingDeleteCoachAndAssignedStudents! Need 0 or 1 and $# were inputted."
	exit 1
    fi

else
   echo "Script file: $SQLFILEDIR/$CONTENTSQLFILE Not Found!"
    exit 1
fi

#END OF SCRIPT

