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
# *** SSP Insert Faculty Users and Courses into SSP Training Script ***
#
# This script adds a faculty member that is able to login into SSP-Platform
#  for SSP Training by using sed to substitute variables in the sql
#  file with command line arguments of real values. This is then automatically
#  executed for database 'ssp' using the psql command. 
#
#  Futhermore, it will also assign that faculty a random selection of courses
#   and a random selection of existing students as the roster. 
#
# Params: 1st arg string username for the new Faculty Login
#	  2nd arg string password for the new Faculty (sha or md5 portalPassword format)	  
#	  3rd arg string firstname for the new Faculty
#	  4th arg string lastname for the new Faculty
#
# Note: Requires Postgres 8.X or higher (SQL Script Dependency)
#

SQLFILEDIR="$(dirname $0)/../dataScripts"
SETFACULTYUSERSSQLFILE="sspTrainingDriveAddFacultyUsers.sql"
SETFACULTYEXTERNALSQLFILE="sspTrainingSetFacultyExternal.sql"

YEAR3=`date +'%Y'`

if [ -f "$SQLFILEDIR/$SETFACULTYUSERSSQLFILE" ] && [ -f "$SQLFILEDIR/$SETFACULTYEXTERNALSQLFILE" ]; then
    if [ "$#" -eq 4 ]; then        

	FACULTYUSER=$1	

	sed "s@FACULTYUSERNAME@$1@g;s@FACULTYPASSWORD@$2@g;s@FACULTYFIRSTNAME@$3@g;s@FACULTYLASTNAME@$4@g" $SQLFILEDIR/$SETFACULTYUSERSSQLFILE | psql ssp -U postgres
        if [ $? -ne 0 ]; then
      	   echo "Adding Faculty User Records Failed"
	   exit $?
   	fi

	echo "Adding Faculty User Records Complete"

	sed "s@FACULTYUSER@$FACULTYUSER@g;s@YEAR3@$YEAR3@g" $SQLFILEDIR/$SETFACULTYEXTERNALSQLFILE | psql ssp -U postgres
	
	if [ $? -ne 0 ]; then
      	   echo "Adding External Faculty Course and Roster Records Failed"
	   exit $?
   	fi

	echo "Adding External Faculty and Course and Roster Records Complete"
    else
	echo "Improper number of input arguments in script: sspTrainingSetFacultyExternal! Need 4 and $# were inputted."
	exit 1
    fi
else
    echo "Script file: $SQLFILEDIR/$SETFACULTYUSERSSQLFILE or $SQLFILEDIR/$SETFACULTYEXTERNALSQLFILE Not Found!"
    exit 1
fi

#END OF SCRIPT

