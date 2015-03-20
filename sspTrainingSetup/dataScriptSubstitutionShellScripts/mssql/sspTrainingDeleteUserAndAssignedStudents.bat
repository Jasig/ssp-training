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
rem *** SSP Delete Coach/Users and their Assigned Students From SSP Training Script MSSQL Version***
rem
rem This script deletes a coach or user from the ssp mssql database
rem  for SSP Training by using sed to substitute variables in the sql
rem  file with command line arguments of real values. This is then automatically
rem  executed for database 'ssp' using the psql command. 
rem
rem Params: 1st arg string username for the new Coach/User
rem	  2nd arg string username of the new student use case
rem	  3rd arg string username of the progressing student use case
rem	  4th arg string username of the struggling student use case
rem
rem	  5th OPTIONAL arg number=1 to tell script to output to file 
rem	 	instead of the db. File is set to 
rem           ../mssql/sspTrainingDataCompiled(TODAY'S DATE).sql
rem
rem
rem Note: Requires MSSQL 2008 or higher (SQL Script Dependency)
rem


rem THE CALLED SQL SCRIPT IS NOT COMPLETE YET!!! DO NOT USE!

:endOfComments

set "SQLFILEDIR=%~dp0..\..\dataScripts\mssql"
set "DELETEUSERSSQLFILE=sspTrainingDeleteCoachAndAssignedStudents.sql"
set FILEDATESTAMP=%date:~4,2%-%date:~7,2%-%date:~10,4%
set "OUTPUTFILE=%~dp0..\..\..\mssql\sspTrainingDataCompiled%FILEDATESTAMP%.sql"

set cmdArgNumber=0
for %%x in (%*) do set /a cmdArgNumber+=1


if exist "%SQLFILEDIR%/%DELETEUSERSSQLFILE%" (
    if "%cmdArgNumber%" == "4" (        
        sqlcmd  -d ssp -i %SQLFILEDIR%/%DELETEUSERSSQLFILE% -v COACHUSERNAME="%1" NEWSTUDENT1="%2" PROGRESSINGSTUDENT2="%3" STRUGGLINGSTUDENT3="%4"
    	exit /b %errorlevel%

    rem Print To File Option
    ) else if "%cmdArgNumber%" == "5" (
         if "%5" == "1" (
             sqlcmd  -d ssp -i %SQLFILEDIR%/%DELETEUSERSSQLFILE% -v COACHUSERNAME="%1" NEWSTUDENT1="%2" PROGRESSINGSTUDENT2="%3" STRUGGLINGSTUDENT3="%4" -e >> %OUTPUTFILE%
            exit /b %errorlevel%
         ) else (
            echo Improper fifth argument! Expected: 1  Recieved: %5 
            exit /b 1 
         )
    rem End Print To File Option
    
    ) else (
	echo Improper number of input arguments script: sspTrainingDeleteCoachAndAssignedStudents! Need 4 and %cmdArgNumber% were inputted.
	exit /b 1 
    )
) else (
   echo Script file: %SQLFILEDIR%/%DELETEUSERSSQLFILE% Not Found!
   exit /b 1
)

rem END OF SCRIPT

