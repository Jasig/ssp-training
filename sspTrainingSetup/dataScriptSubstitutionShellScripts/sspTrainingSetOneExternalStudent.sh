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
# *** SSP Set 1 High Quality External Student for SSP Training Script ***
#
# This script adds 1 student in External Data into a Postgres database
#  for SSP Training of the external sync process. This script uses sed 
#  to substitute variables in the sql file with command line arguments of 
#  real values. This is then automatically executed for database 'ssp' 
#  using the psql command. 
#
# Params: 1st arg string username for the External Student 
#	  2nd arg string firstname External Student
#	  3rd arg string secondname External Student
#	  4th arg string lastname External Student
#	  5th arg string username for the Assigned Coach Username
#
#	  6th OPTIONAL arg number=1 to tell script to output to file 
#	 	instead of the db. File is set to 
#           ../postgres/sspTrainingDataCompiled(TODAY'S DATE).sql
#
# Note: Requires Postgres 8.X or higher (SQL Script Dependency)
#

SQLFILEDIR="$(dirname $0)/../dataScripts"
SETSTUDENTEXTERNALSQLFILE="sspTrainingSetOneStudentExternal.sql"
YEAR3=`date +'%Y'`
YEAR2=`expr $YEAR3 - 1`
DATE=$(date +"%m-%d-%Y")
OUTPUTFILE="../postgres/sspTrainingDataCompiled$DATE.sql"

if [ -f "$SQLFILEDIR/$SETSTUDENTEXTERNALSQLFILE" ]; then
    if [ "$#" -eq 5 ]; then        

	sed "s@EXTERNALSYNC1@$1@g;s@EXTERNALSYNCFIRSTNAME@$2@g;s@EXTERNALSYNCMIDDLENAME@$3@g;s@EXTERNALSYNCLASTNAME@$4@g;s@YEAR3@$YEAR3@g;s@YEAR2@$YEAR2@g;s@COACHASSIGNED@$5@g" $SQLFILEDIR/$SETSTUDENTEXTERNALSQLFILE | psql ssp -U postgres
	
	if [ $? -ne 0 ]; then
      	   echo "Loading One Student External Record Failed"
	   exit $?
   	fi

	echo "Loading One Student External Record Done"

    #Print To File Option  
    elif [ "$#" -eq 6 ] && [ "$6" -eq 1 ]; then
	sed "s@EXTERNALSYNC1@$1@g;s@EXTERNALSYNCFIRSTNAME@$2@g;s@EXTERNALSYNCMIDDLENAME@$3@g;s@EXTERNALSYNCLASTNAME@$4@g;s@YEAR3@$YEAR3@g;s@YEAR2@$YEAR2@g;s@COACHASSIGNED@$5@g" $SQLFILEDIR/$SETSTUDENTEXTERNALSQLFILE  >> $OUTPUTFILE
	
	if [ $? -ne 0 ]; then
      	   echo "Printing One Student External Record To File Failed"
	   exit $?
   	fi

	echo "Printing One Student External Record To File Done" 
    #End Print To File Option 

    else
	echo "Improper number of input arguments! Need 5 and $# were inputted."
	exit 1
    fi
else
    echo "Script file: $SQLFILEDIR/$SETSTUDENTEXTERNALSQLFILE Not Found!"
    exit 1
fi

#END OF SCRIPT

