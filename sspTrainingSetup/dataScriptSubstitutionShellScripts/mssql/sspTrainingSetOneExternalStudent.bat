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
rem *** SSP Set 1 High Quality External Student for SSP Training Script MSSQL Version***
rem
rem This script adds 1 student in External Data into a mssql database
rem  for SSP Training of the external sync process. This script uses sed 
rem  to substitute variables in the sql file with command line arguments of 
rem  real values. This is then automatically executed for database 'ssp' 
rem  using the psql command. 
rem
rem Params: 1st arg string username for the External Student 
rem	  2nd arg string firstname External Student
rem	  3rd arg string secondname External Student
rem	  4th arg string lastname External Student
rem	  5th arg string username for the Assigned Coach Username
rem
rem	  6th OPTIONAL arg number=1 to tell script to output to file 
rem	 	instead of the db. File is set to 
rem           ../mssql/sspTrainingDataCompiled(TODAY'S DATE).sql
rem
rem Note: Requires MSSQL 2008 or higher (SQL Script Dependency)
rem

:endOfComments

set "SQLFILEDIR=%~dp0..\..\dataScripts\mssql"
set "SETSTUDENTEXTERNALSQLFILE=sspTrainingSetOneStudentExternal.sql"
set YEAR3=%date:~10,4%
set /a YEAR2=%YEAR3%-1
set FILEDATESTAMP=%date:~4,2%-%date:~7,2%-%date:~10,4%
set "OUTPUTFILE=%~dp0..\..\..\mssql\sspTrainingDataCompiled%FILEDATESTAMP%.sql"

set "cmdArgNumber=0"
for %%x in (%*) do set /a cmdArgNumber+=1

if exist "%SQLFILEDIR%/%SETSTUDENTEXTERNALSQLFILE%" (
    if "%cmdArgNumber%" == "5" (
        sqlcmd  -d ssp -i %SQLFILEDIR%\%SETSTUDENTEXTERNALSQLFILE% -v EXTERNALSYNC1="%1" EXTERNALSYNCFIRSTNAME="%2" EXTERNALSYNCMIDDLENAME="%3" EXTERNALSYNCLASTNAME="%4" YEAR3="%YEAR3%" YEAR2="%YEAR2%" COACHASSIGNED="%5" 
	
	exit /b %errorlevel%
	echo "Loading One Student External Record Done"

    rem Print To File Option  
    ) else if "%cmdArgNumber%" == "6" (
        if "%6"== "1" (
	      sqlcmd  -d ssp -i %SQLFILEDIR%\%SETSTUDENTEXTERNALSQLFILE% -v EXTERNALSYNC1="%1" EXTERNALSYNCFIRSTNAME="%2" EXTERNALSYNCMIDDLENAME="%3" EXTERNALSYNCLASTNAME="%4" YEAR3="%YEAR3%" YEAR2="%YEAR2%" COACHASSIGNED="%5" -e >> %OUTPUTFILE%
	
           exit /b %errorlevel%
	   echo "Printing One Student External Record To File Done" 
        ) else (
             echo Improper 6th argument! Expected 1 Recieved: %6
        )
    rem End Print To File Option 

    ) else (
	echo Improper number of input arguments! Need 5 and %cmdArgNumber% were inputted.
	exit /b 1
    )
) else (
    echo Script file: %SQLFILEDIR%/%$SETSTUDENTEXTERNALSQLFILE% Not Found!
    exit /b 1
)

rem END OF SCRIPT

