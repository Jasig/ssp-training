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
# *** SSP Delete Coach/Users and their Assigned Students From SSP Training Script ***
#
# This script deletes a coach or user from the ssp Postgres database
#  for SSP Training by using sed to substitute variables in the sql
#  file with command line arguments of real values. This is then automatically
#  executed for database 'ssp' using the psql command. 
#
# Params: 1st arg string username for the new Coach/User
#	  2nd arg string username of the new student use case
#	  3rd arg string username of the progressing student use case
#	  4th arg string username of the struggling student use case
#
#	  5th OPTIONAL arg number=1 to tell script to output to file 
#	 	instead of the db. File is set to 
#           ../postgres/sspTrainingDataCompiled(TODAY'S DATE).sql
#
#
# Note: Requires Postgres 8.X or higher (SQL Script Dependency)
#

SQLFILEDIR="$(dirname $0)/../dataScripts"
DELETEUSERSSQLFILE="sspTrainingDeleteCoachAndAssignedStudents.sql"
DATE=$(date +"%m-%d-%Y")
OUTPUTFILE="../postgres/sspTrainingDataCompiled$DATE.sql"

if [ -e "$SQLFILEDIR/$DELETEUSERSSQLFILE" ]; then
    if [ "$#" -eq 4 ]; then        

	sed "s/COACHUSERNAME/$1/g;s/NEWSTUDENT1/$2/g;s/PROGRESSINGSTUDENT2/$3/g;s/STRUGGLINGSTUDENT3/$4/g;" $SQLFILEDIR/$DELETEUSERSSQLFILE | psql ssp -U postgres
    	exit $?

    #Print To File Option
    elif [ "$#" -eq 5 ] && [ "$5" -eq 1 ]; then
	sed "s/COACHUSERNAME/$1/g;s/NEWSTUDENT1/$2/g;s/PROGRESSINGSTUDENT2/$3/g;s/STRUGGLINGSTUDENT3/$4/g;" $SQLFILEDIR/$DELETEUSERSSQLFILE >> $OUTPUTFILE
    exit $?
    #End Print To File Option
    
    else
	echo "Improper number of input arguments script: sspTrainingDeleteCoachAndAssignedStudents! Need 4 and $# were inputted."
	exit 1
    fi
else
   echo "Script file: $SQLFILEDIR/$DELETEUSERSSQLFILE Not Found!"
    exit 1
fi

#END OF SCRIPT

