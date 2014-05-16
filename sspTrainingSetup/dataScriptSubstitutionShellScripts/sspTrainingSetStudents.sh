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
# *** SSP Set 3 High Quality Assigned Use Case Students for SSP Training Script ***
#
# This script adds 3 high quailty use case students into a Postgres database
#  for SSP Training. This script uses sed to substitute variables in the sql
#  file with command line arguments of real values. This is then automatically
#  executed for database 'ssp' using the psql command. 
#
# Params: 1st arg string username for the New Student Use Case
#	  2nd arg string firstname New Student
#	  3rd arg string secondname New Student
#	  4th arg string lastname New Student
#
#	  5th arg string username for the Progressing Student Use Case
#	  6th arg string firstname Progressing Student
#	  7th arg string secondname Progressing Student
#	  8th arg string lastname Progressing Student
#
#	  9th arg string username for the Struggling Student Use Case
#	  10th arg string firstname Struggling Student
#	  11th arg string secondname Struggling Student
#	  12th arg string lastname Struggling Student
#
#	  13th arg string username for the Assigned Coach Username
#	  14th arg string UUID for the Assigned Coach UUID
#	  15th-19th string UUID for tasks, must be unique
#
#
#	  20th OPTIONAL arg number=1 to tell script to output to file 
#	 	instead of the db. File is set to 
#           ../postgres/sspTrainingDataCompiled(TODAY'S DATE).sql
#
# Note: Requires Postgres 8.X or higher (SQL Script Dependency)
#

SQLFILEDIR="$(dirname $0)/../dataScripts"
SETSTUDENTSEXTERNALSQLFILE="sspTrainingSetStudentsExternal.sql"
SETSTUDENTSINTERNALSQLFILE="sspTrainingSetStudentsInternal.sql"
YEAR3=`date +'%Y'`
YEAR2=`expr $YEAR3 - 1`
YEAR1=`expr $YEAR3 - 2`
YEAR4=`expr $YEAR3 + 1`
YEAR5=`expr $YEAR3 + 2`
YEAR6=`expr $YEAR3 + 3`
DATE=$(date +"%m-%d-%Y")
OUTPUTFILE="../postgres/sspTrainingDataCompiled$DATE.sql"

if [ -f "$SQLFILEDIR/$SETSTUDENTSEXTERNALSQLFILE" ] && [ -f "$SQLFILEDIR/$SETSTUDENTSINTERNALSQLFILE" ]; then
    TASK1=${15}
    TASK2=${16}
    TASK3=${17}
    TASK4=${18}
    TASK5=${19}
    NEWSTUDENTUSERNAME=$1
    PROGSTUDENTUSERNAME=$5
    STRUGSTUDENTUSERNAME=$9
    COACHUUID=${14}

    if [ "$#" -eq 19 ]; then
	sed "s@NEWSTUDENT1@$NEWSTUDENTUSERNAME@g;s@NEWSTUDENTFIRSTNAME@$2@g;s@NEWSTUDENTMIDDLENAME@$3@g;s@NEWSTUDENTLASTNAME@$4@g;s@PROGRESSINGSTUDENT2@$PROGSTUDENTUSERNAME@g;s@PROGRESSINGSTUDENTFIRSTNAME@$6@g;s@PROGRESSINGSTUDENTMIDDLENAME@$7@g;s@PROGRESSINGSTUDENTLASTNAME@$8@g;s@STRUGGLINGSTUDENT3@$STRUGSTUDENTUSERNAME@g;s@STRUGGLINGSTUDENTFIRSTNAME@${10}@g;s@STRUGGLINGSTUDENTMIDDLENAME@${11}@g;s@STRUGGLINGSTUDENTLASTNAME@${12}@g;s@YEAR3@$YEAR3@g;s@YEAR2@$YEAR2@g;s@YEAR1@$YEAR1@g;s@COACHASSIGNED@${13}@g;s@COACHID@$COACHUUID@g;s@TASKID1@$TASK1@g;s@TASKID2@$TASK2@g;s@TASKID3@$TASK3@g;s@TASKID4@$TASK4@g;s@TASKID5@$TASK5@g" $SQLFILEDIR/$SETSTUDENTSEXTERNALSQLFILE | psql ssp -U postgres
	
	if [ $? -ne 0 ]; then
      	   echo "Loading External Records Failed"
	   exit $?
   	fi

	echo "Loading External Records Done"

	sed "s@NEWSTUDENT1@$NEWSTUDENTUSERNAME@g;s@PROGRESSINGSTUDENT2@$PROGSTUDENTUSERNAME@g;s@STRUGGLINGSTUDENT3@$STRUGSTUDENTUSERNAME@g;s@COACHID@$COACHUUID@g;s@YEAR3@$YEAR3@g;s@YEAR2@$YEAR2@g;s@YEAR1@$YEAR1@g;s@YEAR4@$YEAR4@g;s@YEAR5@$YEAR5@g;s@YEAR6@$YEAR6@g;s@TASKID1@$TASK1@g;s@TASKID2@$TASK2@g;s@TASKID3@$TASK3@g;s@TASKID4@$TASK4@g;s@TASKID5@$TASK5@g" $SQLFILEDIR/$SETSTUDENTSINTERNALSQLFILE | psql ssp -U postgres
	
	if [ $? -ne 0 ]; then
      	   echo "Loading Internal Records Failed"
	   exit $?
   	fi

	echo "Loading Internal Records Done"
    
    #Print To File Option     
    elif [ "$#" -eq 20 ] && [ "$20" -eq 1 ]; then

        sed "s@NEWSTUDENT1@$NEWSTUDENTUSERNAME@g;s@NEWSTUDENTFIRSTNAME@$2@g;s@NEWSTUDENTMIDDLENAME@$3@g;s@NEWSTUDENTLASTNAME@$4@g;s@PROGRESSINGSTUDENT2@$PROGSTUDENTUSERNAME@g;s@PROGRESSINGSTUDENTFIRSTNAME@$6@g;s@PROGRESSINGSTUDENTMIDDLENAME@$7@g;s@PROGRESSINGSTUDENTLASTNAME@$8@g;s@STRUGGLINGSTUDENT3@$STRUGSTUDENTUSERNAME@g;s@STRUGGLINGSTUDENTFIRSTNAME@${10}@g;s@STRUGGLINGSTUDENTMIDDLENAME@${11}@g;s@STRUGGLINGSTUDENTLASTNAME@${12}@g;s@YEAR3@$YEAR3@g;s@YEAR2@$YEAR2@g;s@YEAR1@$YEAR1@g;s@COACHASSIGNED@${13}@g;s@COACHID@$COACHUUID@g;s@TASKID1@$TASK1@g;s@TASKID2@$TASK2@g;s@TASKID3@$TASK3@g;s@TASKID4@$TASK4@g;s@TASKID5@$TASK5@g" $SQLFILEDIR/$SETSTUDENTSEXTERNALSQLFILE >> $OUTPUTFILE
	
	if [ $? -ne 0 ]; then
      	   echo "Printing External Records To File Failed"
	   exit $?
   	fi

	echo "Printing External Records To File Done"

	sed "s@NEWSTUDENT1@$NEWSTUDENTUSERNAME@g;s@PROGRESSINGSTUDENT2@$PROGSTUDENTUSERNAME@g;s@STRUGGLINGSTUDENT3@$STRUGSTUDENTUSERNAME@g;s@COACHID@$COACHUUID@g;s@YEAR3@$YEAR3@g;s@YEAR2@$YEAR2@g;s@YEAR1@$YEAR1@g;s@YEAR4@$YEAR4@g;s@YEAR5@$YEAR5@g;s@YEAR6@$YEAR6@g;s@TASKID1@$TASK1@g;s@TASKID2@$TASK2@g;s@TASKID3@$TASK3@g;s@TASKID4@$TASK4@g;s@TASKID5@$TASK5@g" $SQLFILEDIR/$SETSTUDENTSINTERNALSQLFILE >> $OUTPUTFILE

        if [ $? -ne 0 ]; then
      	   echo "Printing Internal Records To File Failed"
	   exit $?
   	fi

	echo "Printing Internal Records To File Done"	
    #End Print To File Option

    else
	echo "Improper number of input arguments! Need 19 and $# were inputted."
	exit 1
    fi
else
    echo "Script file: $SQLFILEDIR/$SETSTUDENTSEXTERNALSQLFILE or $SQLFILEDIR/$SETSTUDENTSINTERNALSQLFILE Not Found!"
    exit 1
fi

#END OF SCRIPT

