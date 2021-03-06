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
# *** SSP Insert Student Users into SSP Training Script ***
#
# This script adds a student that is able to login into SSP-Platform
#  for SSP Training by using sed to substitute variables in the sql
#  file with command line arguments of real values. This is then automatically
#  executed for database 'ssp' using the psql command. 
#
# Params: 1st arg string username for the new Student Login
#	  2nd arg string password for the new Student Login (sha or md5 portalPassword format)
#	  3rd arg string firstname for the new Student Login
#	  4th arg string lastname for the new Student Login
#         5th arg string UUID for the new student Login
#
#	  6th OPTIONAL arg number=1 to tell script to output to file 
#	 	instead of the db. File is set to 
#           ../postgres/sspTrainingDataCompiled(TODAY'S DATE).sql
#
# Note: Requires Postgres 8.X or higher (SQL Script Dependency)
#

SQLFILEDIR="$(dirname $0)/../dataScripts"
SETSTUDENTUSERSSQLFILE="sspTrainingAddUsers.sql"
DATE=$(date +"%m-%d-%Y")
OUTPUTFILE="../postgres/sspTrainingDataCompiled$DATE.sql"

if [ -e "$SQLFILEDIR/$SETSTUDENTUSERSSQLFILE" ]; then
    if [ "$#" -eq 5 ]; then
	sed "s@USERNAME@$1@g;s@USERPASSWORD@$2@g;s@USERFIRSTNAME@$3@g;s@USERLASTNAME@$4@g;s@USERUUID@$5@g;s@USERROLE@STUDENT@g;s@IS_MAP_TEMPLATE_ADMIN@false@g" $SQLFILEDIR/$SETSTUDENTUSERSSQLFILE | psql ssp -U postgres
        exit $?

    #Print To File Option
    elif [ "$#" -eq 6 ] && [ "$6" -eq 1 ]; then
	sed "s@USERNAME@$1@g;s@USERPASSWORD@$2@g;s@USERFIRSTNAME@$3@g;s@USERLASTNAME@$4@g;s@USERUUID@$5@g;s@USERROLE@STUDENT@g;s@IS_MAP_TEMPLATE_ADMIN@false@g" $SQLFILEDIR/$SETSTUDENTUSERSSQLFILE >> $OUTPUTFILE
        exit $?
    #End Print To File Option

    else
	echo "Improper number of input arguments in script: sspTrainingAddStudentUsers! Need 5 and $# were inputted."
	exit 1
    fi
else
   echo "Script file: $SQLFILEDIR/$SETSTUDENTUSERSSQLFILE Not Found!"
    exit 1
fi

#END OF SCRIPT

