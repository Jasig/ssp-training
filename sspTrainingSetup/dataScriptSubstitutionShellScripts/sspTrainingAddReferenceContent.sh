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
CONTENTSQLFILE="sspTrainingStartupContent.sql"
YEAR3=`date +'%Y'`
YEAR2=`expr $YEAR3 - 1`
YEAR1=`expr $YEAR3 - 2`
YEAR4=`expr $YEAR3 + 1`
YEAR5=`expr $YEAR3 + 2`
YEAR6=`expr $YEAR3 + 3`
YEAR7=`expr $YEAR3 + 4`
YEAR8=`expr $YEAR3 + 5`
YEAR9=`expr $YEAR3 + 6`
YEARDEC=`expr $YEAR3 + 7`
TWODIGITYEAR3=`date +'%y'`
TWODIGITYEAR2=`expr $TWODIGITYEAR3 - 1`
TWODIGITYEAR1=`expr $TWODIGITYEAR3 - 2`
TWODIGITYEAR4=`expr $TWODIGITYEAR3 + 1`
TWODIGITYEAR5=`expr $TWODIGITYEAR3 + 2`
TWODIGITYEAR6=`expr $TWODIGITYEAR3 + 3`
TWODIGITYEAR7=`expr $TWODIGITYEAR3 + 4`
TWODIGITYEAR8=`expr $TWODIGITYEAR3 + 5`
TWODIGITYEAR9=`expr $TWODIGITYEAR3 + 6`
TWODIGITYEARDEC=`expr $TWODIGITYEAR1 + 7`
DATE=$(date +"%m-%d-%Y")
OUTPUTFILE="../postgres/sspTrainingDataCompiled$DATE.sql"

if [ -e "$SQLFILEDIR/$CONTENTSQLFILE" ]; then
   if [ "$#" -lt 1 ]; then

       sed "s@TWODIGITYEARDEC@$TWODIGITYEARDEC@g;s@TWODIGITYEAR9@$TWODIGITYEAR9@g;s@TWODIGITYEAR8@$TWODIGITYEAR8@g;s@TWODIGITYEAR7@$TWODIGITYEAR7@g;s@TWODIGITYEAR6@$TWODIGITYEAR6@g;s@TWODIGITYEAR5@$TWODIGITYEAR5@g;s@TWODIGITYEAR4@$TWODIGITYEAR4@g;s@TWODIGITYEAR3@$TWODIGITYEAR3@g;s@TWODIGITYEAR2@$TWODIGITYEAR2@g;s@TWODIGITYEAR1@$TWODIGITYEAR1@g;s@YEARDEC@$YEARDEC@g;s@YEAR9@$YEAR9@g;s@YEAR8@$YEAR8@g;s@YEAR7@$YEAR7@g;s@YEAR6@$YEAR6@g;s@YEAR5@$YEAR5@g;s@YEAR4@$YEAR4@g;s@YEAR3@$YEAR3@g;s@YEAR2@$YEAR2@g;s@YEAR1@$YEAR1@g" $SQLFILEDIR/$CONTENTSQLFILE | psql ssp -U postgres
       echo "Loading reference content complete"
       exit $?
   
   #Print To File Option
   elif [ "$#" -eq 1 ] && [ "$1" -eq 1 ]; then
       sed "s@TWODIGITYEARDEC@$TWODIGITYEARDEC@g;s@TWODIGITYEAR9@$TWODIGITYEAR9@g;s@TWODIGITYEAR8@$TWODIGITYEAR8@g;s@TWODIGITYEAR7@$TWODIGITYEAR7@g;s@TWODIGITYEAR6@$TWODIGITYEAR6@g;s@TWODIGITYEAR5@$TWODIGITYEAR5@g;s@TWODIGITYEAR4@$TWODIGITYEAR4@g;s@TWODIGITYEAR3@$TWODIGITYEAR3@g;s@TWODIGITYEAR2@$TWODIGITYEAR2@g;s@TWODIGITYEAR1@$TWODIGITYEAR1@g;s@YEARDEC@$YEARDEC@g;s@YEAR9@$YEAR9@g;s@YEAR8@$YEAR8@g;s@YEAR7@$YEAR7@g;s@YEAR6@$YEAR6@g;s@YEAR5@$YEAR5@g;s@YEAR4@$YEAR4@g;s@YEAR3@$YEAR3@g;s@YEAR2@$YEAR2@g;s@YEAR1@$YEAR1@g" $SQLFILEDIR/$CONTENTSQLFILE >> $OUTPUTFILE 
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

