@ECHO OFF

goto endOfComments

rem * Licensed to Apereo under one or more contributor license
rem * agreements. See the NOTICE file distributed with this work
rem * for additional information regarding copyright ownership.
rem * Apereo licenses this file to you under the Apache License,
rem * Version 2.0 (the "License"); you may not use this file
rem * except in compliance with the License.  You may obtain a
rem * copy of the License at the following location:
rem *
rem *   http://www.apache.org/licenses/LICENSE-2.0
rem *
rem * Unless required by applicable law or agreed to in writing,
rem * software distributed under the License is distributed on an
rem * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
rem * KIND, either express or implied.  See the License for the
rem * specific language governing permissions and limitations
rem * under the License.
rem */


rem
rem *** SSP Set 3 High Quality Assigned Use Case Students for SSP Training Script MSSQL Version***
rem
rem This script adds 3 high quailty use case students into a mssql database
rem  for SSP Training. This script uses sed to substitute variables in the sql
rem  file with command line arguments of real values. This is then automatically
rem  executed for database 'ssp' using the psql command. 
rem
rem Params: 1st arg string username for the New Student Use Case
rem	  2nd arg string firstname New Student
rem	  3rd arg string secondname New Student
rem	  4th arg string lastname New Student
rem
rem	  5th arg string username for the Progressing Student Use Case
rem	  6th arg string firstname Progressing Student
rem	  7th arg string secondname Progressing Student
rem	  8th arg string lastname Progressing Student
rem
rem	  9th arg string username for the Struggling Student Use Case
rem	  10th arg string firstname Struggling Student
rem	  11th arg string secondname Struggling Student
rem	  12th arg string lastname Struggling Student
rem
rem	  13th arg string username for the Assigned Coach Username
rem	  14th arg string UUID for the Assigned Coach UUID
rem	  15th-19th string UUID for tasks, must be unique
rem
rem
rem	  20th OPTIONAL arg number=1 to tell script to output to file 
rem	 	instead of the db. File is set to 
rem           ../mssql/sspTrainingDataCompiled(TODAY'S DATE).sql
rem
rem Note: Requires MSSQL 2008 or higher (SQL Script Dependency)
rem

:endOfComments

set "SQLFILEDIR=%~dp0..\..\dataScripts\mssql"
set "SETSTUDENTSEXTERNALSQLFILE=sspTrainingSetStudentsExternal.sql"
set "SETSTUDENTSINTERNALSQLFILE=sspTrainingSetStudentsInternal.sql"
set YEAR3=%date:~10,4%
set /a YEAR2=%YEAR3%-1
set /a YEAR1=%YEAR3%-2
set /a YEAR4=%YEAR3%+1
set /a YEAR5=%YEAR3%+2
set /a YEAR6=%YEAR3%+3
set FILEDATESTAMP=%date:~4,2%-%date:~7,2%-%date:~10,4%
set "OUTPUTFILE=%~dp0..\..\..\mssql\sspTrainingDataCompiled%FILEDATESTAMP%.sql"
set "shiftIndex=9"
set "cmdArgNumber=0"

for %%x in (%*) do set /a cmdArgNumber+=1

if "%cmdArgNumber%" == "20" set "shiftIndex=9"

set NEWSTUDENTUSERNAME=%1
set NEWFIRSTNAME=%2
set NEWMIDDLENAME=%3
set NEWLASTNAME=%4
set PROGSTUDENTUSERNAME=%5
set PROGRESSINGFIRSTNAME=%6
set PROGRESSINGMIDDLENAME=%7
set PROGRESSINGLASTNAME=%8 
set STRUGSTUDENTUSERNAME=%9

shift       
set STRUGGLINGFIRSTNAME=%9
	   
shift
set STRUGGLINGMIDDLENAME=%9

for /l %%i in (1, 1, %shiftIndex%) do shift

if exist "%SQLFILEDIR%\%SETSTUDENTSEXTERNALSQLFILE%" (
   
   if exist "%SQLFILEDIR%\%SETSTUDENTSINTERNALSQLFILE%" (          
	 
	 if "%cmdArgNumber%" == "19" (	  	 

	sqlcmd -d ssp -i %SQLFILEDIR%\%SETSTUDENTSEXTERNALSQLFILE% -v NEWSTUDENT1="%NEWSTUDENTUSERNAME%" NEWSTUDENTFIRSTNAME="%NEWFIRSTNAME%" NEWSTUDENTMIDDLENAME="%NEWMIDDLENAME%" NEWSTUDENTLASTNAME="%NEWLASTNAME%" PROGRESSINGSTUDENT2="%PROGSTUDENTUSERNAME%" PROGRESSINGSTUDENTFIRSTNAME="%PROGRESSINGFIRSTNAME%" PROGRESSINGSTUDENTMIDDLENAME="%PROGRESSINGMIDDLENAME%" PROGRESSINGSTUDENTLASTNAME="%PROGRESSINGLASTNAME%" STRUGGLINGSTUDENT3="%STRUGSTUDENTUSERNAME%" STRUGGLINGSTUDENTFIRSTNAME="%STRUGGLINGFIRSTNAME%" STRUGGLINGSTUDENTMIDDLENAME="%STRUGGLINGMIDDLENAME%" STRUGGLINGSTUDENTLASTNAME="%1" YEAR3="%YEAR3%" YEAR2="%YEAR2%" YEAR1="%YEAR1%" COACHASSIGNED="%2" COACHID="%3" TASKID1="%4" TASKID2="%5" TASKID3="%6" TASKID4="%7" TASKID5="%8"
	
	echo Loading External Records Done
        
    sqlcmd -d ssp -i %SQLFILEDIR%\%SETSTUDENTSINTERNALSQLFILE% -v NEWSTUDENT1="%NEWSTUDENTUSERNAME%" PROGRESSINGSTUDENT2="%PROGSTUDENTUSERNAME%" STRUGGLINGSTUDENT3="%STRUGSTUDENTUSERNAME%" COACHID="%3" YEAR3="%YEAR3%" YEAR2="%YEAR2%" YEAR1="%YEAR1%" YEAR4="%YEAR4%" YEAR5="%YEAR5%" YEAR6="%YEAR6%" TASKID1="%4" TASKID2="%5" TASKID3="%6" TASKID4="%7" TASKID5="%8"
 	
	exit /b %errorlevel%
	
	echo Loading Internal Records Done
  
      rem Print To File Option     
      ) else if "%cmdArgNumber%" == "20" (
	  
         if "%9" == "1" (

          sqlcmd -d ssp -i %SQLFILEDIR%\%SETSTUDENTSEXTERNALSQLFILE% -v NEWSTUDENT1="%NEWSTUDENTUSERNAME%" NEWSTUDENTFIRSTNAME="%NEWFIRSTNAME%" NEWSTUDENTMIDDLENAME="%NEWMIDDLENAME%" NEWSTUDENTLASTNAME="%NEWLASTNAME%" PROGRESSINGSTUDENT2="%PROGSTUDENTUSERNAME%" PROGRESSINGSTUDENTFIRSTNAME="%PROGRESSINGFIRSTNAME%" PROGRESSINGSTUDENTMIDDLENAME="%PROGRESSINGMIDDLENAME%" PROGRESSINGSTUDENTLASTNAME="%PROGRESSINGLASTNAME%" STRUGGLINGSTUDENT3="%STRUGSTUDENTUSERNAME%" STRUGGLINGSTUDENTFIRSTNAME="%STRUGGLINGFIRSTNAME%" STRUGGLINGSTUDENTMIDDLENAME="%STRUGGLINGMIDDLENAME%" STRUGGLINGSTUDENTLASTNAME="%1" YEAR3="%YEAR3%" YEAR2="%YEAR2%" YEAR1="%YEAR1%" COACHASSIGNED="%2" COACHID="%3" TASKID1="%4" TASKID2="%5" TASKID3="%6" TASKID4="%7" TASKID5="%8" -e >> %OUTPUTFILE%            

            echo Printing External Records To File Done

             sqlcmd -d ssp -i %SQLFILEDIR%\%SETSTUDENTSINTERNALSQLFILE% -v NEWSTUDENT1="%NEWSTUDENTUSERNAME%" PROGRESSINGSTUDENT2="%PROGSTUDENTUSERNAME%" STRUGGLINGSTUDENT3="%STRUGSTUDENTUSERNAME%" COACHID="%3" YEAR3="%YEAR3%" YEAR2="%YEAR2%" YEAR1="%YEAR1%" YEAR4="%YEAR4%" YEAR5="%YEAR5%" YEAR6="%YEAR6%" TASKID1="%4" TASKID2="%5" TASKID3="%6" TASKID4="%7" TASKID5="%8" -e >> %OUTPUTFILE%

            exit /b %errorlevel%
	    echo Printing Internal Records To File Done

        ) else (
           echo Improper 20th argument! Expected: 1  Recieved: %9
           exit /b 1
        )  	
      rem End Print To File Option

      ) else (
  	 echo Improper number of input arguments! Need 19 and %cmdArgNumber% were inputted.
	 exit /b 1
      )
  
  ) else (
    echo Script file: %SQLFILEDIR%\%SETSTUDENTSINTERNALSQLFILE% Not Found!
    exit /b 1
  )
  
) else (
    echo Script file: %SQLFILEDIR%\%SETSTUDENTSEXTERNALSQLFILE% Not Found!
    exit /b 1
)

rem END OF SCRIPT

