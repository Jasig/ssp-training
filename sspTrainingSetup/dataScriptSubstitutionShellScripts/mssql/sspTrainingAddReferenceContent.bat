@ECHO OFF

goto endOfComments
rem Licensed to Jasig under one or more contributor license
rem agreements. See the NOTICE file distributed with this work
rem for additional information regarding copyright ownership.
rem Jasig licenses this file to you under the Apache License,
rem Version 2.0 (the "License"); you may not use this file
rem except in compliance with the License. You may obtain a
rem copy of the License at:
rem
rem http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing,
rem software distributed under the License is distributed on
rem an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
rem KIND, either express or implied. See the License for the
rem specific language governing permissions and limitations
rem under the License.
rem

rem
rem *** SSP Insert Static Reference Content into SSP Training Script MSSQL Version***
rem
rem This script inserts static reference content that is referenced by students and coaches
rem  into a mssql SSP database. It does so by calling a psql command on database 'ssp' 
rem  that loads a sql file and inserts it into the database. 
rem
rem Params: 1st OPTIONAL arg number=1 to tell script to output to file 
rem	 	instead of the db. File is set to 
rem           ../mssql/sspTrainingDataCompiled(TODAY'S DATE).sql
rem
rem
rem Note: Requires MSSQL 2008 or higher (SQL Script Dependency)
rem

:endOfComments

set "SQLFILEDIR=%~dp0..\..\dataScripts\mssql"
set "CONTENTSQLFILE=sspTrainingImmutableStartupContent.sql"
set FILEDATESTAMP=%date:~4,2%-%date:~7,2%-%date:~10,4%
set "OUTPUTFILE=%~dp0..\..\..\mssql\sspTrainingDataCompiled%FILEDATESTAMP%.sql"

set cmdArgNumber=0
for %%x in (%*) do set /a cmdArgNumber+=1


if exist "%SQLFILEDIR%\%CONTENTSQLFILE%" (
   if "%cmdArgNumber%" == "0" (
       sqlcmd -d ssp -i %SQLFILEDIR%\%CONTENTSQLFILE%   
       exit /b %errorlevel%
       echo Loading reference content complete       
   
   rem Print To File Option
   ) else if "%cmdArgNumber%" == "1" (
       if "%1" == "1" (
          rem copy /b %OUTPUTFILE%+%SQLFILEDIR%\%CONTENTSQLFILE% %OUTPUTFILE% 
          echo Printing reference content to file complete
          exit /b %errorlevel%
       ) else (
          echo Improper first argument! Expected: 1  Recieved: %1 
          exit /b 1 
       )
   rem End Print To File Option

   ) else (
	echo Improper number of input arguments script: sspTrainingDeleteCoachAndAssignedStudents! Need 0 or 1 and %cmdArgNumber% was inputted.
	exit /b 1 
   )

) else (
   echo Script file: %SQLFILEDIR%\%CONTENTSQLFILE% Not Found!
   exit /b 1 
)

rem END OF SCRIPT

