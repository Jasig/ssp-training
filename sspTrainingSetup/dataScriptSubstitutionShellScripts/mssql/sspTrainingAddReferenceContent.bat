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
set "CONTENTSQLFILE=sspTrainingStartupContent.sql"
set FILEDATESTAMP=%date:~4,2%-%date:~7,2%-%date:~10,4%
set "OUTPUTFILE=%~dp0..\..\..\mssql\sspTrainingDataCompiled%FILEDATESTAMP%.sql"
set YEAR3=%date:~10,4%
set /a YEAR2=%YEAR3%-1
set /a YEAR1=%YEAR3%-2
set /a YEAR4=%YEAR3%+1
set /a YEAR5=%YEAR3%+2
set /a YEAR6=%YEAR3%+3
set /a YEAR7=%YEAR3%+4
set /a YEAR8=%YEAR3%+5
set /a YEAR9=%YEAR3%+6
set /a YEARDEC=%YEAR3%+7
set /a TWODIGITYEAR3=%date:~10,2%
set /a TWODIGITYEAR2=%TWODIGITYEAR3%-1
set /a TWODIGITYEAR1=%TWODIGITYEAR3%-2
set /a TWODIGITYEAR4=%TWODIGITYEAR3%+1
set /a TWODIGITYEAR5=%TWODIGITYEAR3%+2
set /a TWODIGITYEAR6=%TWODIGITYEAR3%+3
set /a TWODIGITYEAR7=%TWODIGITYEAR3%+4
set /a TWODIGITYEAR8=%TWODIGITYEAR3%+5
set /a TWODIGITYEAR9=%TWODIGITYEAR3%+6
set /a TWODIGITYEARDEC=%TWODIGITYEAR3%+7

set cmdArgNumber=0
for %%x in (%*) do set /a cmdArgNumber+=1


if exist "%SQLFILEDIR%\%CONTENTSQLFILE%" (
   if "%cmdArgNumber%" == "0" (
       sqlcmd  -d ssp -i %SQLFILEDIR%\%CONTENTSQLFILE% -v YEAR3="%YEAR3%" YEAR2="%YEAR2%" YEAR1="%YEAR1%" YEAR4="%YEAR4%" YEAR5="%YEAR5%" YEAR6="%YEAR6%" YEAR7="%YEAR7%" YEAR8="%YEAR8%" YEAR9="%YEAR9%" YEARDEC="%YEARDEC%" TWODIGITYEAR1="%TWODIGITYEAR1%" TWODIGITYEAR2="%TWODIGITYEAR2%" TWODIGITYEAR3="%TWODIGITYEAR3%" TWODIGITYEAR4="%TWODIGITYEAR4%" TWODIGITYEAR5="%TWODIGITYEAR5%" TWODIGITYEAR6="%TWODIGITYEAR6%" TWODIGITYEAR7="%TWODIGITYEAR7%" TWODIGITYEAR8="%TWODIGITYEAR8%" TWODIGITYEAR9="%TWODIGITYEAR9%" TWODIGITYEARDEC="%TWODIGITYEARDEC%"       
       exit /b %errorlevel%
       echo Loading reference content complete       
   
   rem Print To File Option
   ) else if "%cmdArgNumber%" == "1" (
       if "%1" == "1" (
          sqlcmd  -d ssp -i %SQLFILEDIR%\%CONTENTSQLFILE% -v YEAR3="%YEAR3%" YEAR2="%YEAR2%" YEAR1="%YEAR1%" YEAR4="%YEAR4%" YEAR5="%YEAR5%" YEAR6="%YEAR6%" YEAR7="%YEAR7%" YEAR8="%YEAR8%" YEAR9="%YEAR9%" YEARDEC="%YEARDEC%" TWODIGITYEAR1="%TWODIGITYEAR1%" TWODIGITYEAR2="%TWODIGITYEAR2%" TWODIGITYEAR3="%TWODIGITYEAR3%" TWODIGITYEAR4="%TWODIGITYEAR4%" TWODIGITYEAR5="%TWODIGITYEAR5%" TWODIGITYEAR6="%TWODIGITYEAR6%" TWODIGITYEAR7="%TWODIGITYEAR7%" TWODIGITYEAR8="%TWODIGITYEAR8%" TWODIGITYEAR9="%TWODIGITYEAR9%" TWODIGITYEARDEC="%TWODIGITYEARDEC%" -e >> %OUTPUTFILE%  
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

