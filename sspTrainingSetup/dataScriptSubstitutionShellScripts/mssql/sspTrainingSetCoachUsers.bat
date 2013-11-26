@ECHO OFF

goto endOfComments
rem Licensed to Jasig under one or more contributor license
rem agreements. See the NOTICE file distributed with this work
rem for additional information regarding copyright ownership.
rem Jasig licenses this file to you under the Apache License,
rem Version 2.0 (the "License"); you may not use this file
rem except in compliance with the License. You may obtain a
rem copy of the License at:

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
rem *** SSP Insert Coach/Users into SSP Training Script MSSQL Version***
rem
rem This script adds a coach or user into a mssql database
rem  for SSP Training by using sed to substitute variables in the sql
rem  file with command line arguments of real values. This is then automatically
rem  executed for database 'ssp' using the psql command. 
rem
rem Params: 1st arg string username for the new Coach/User
rem	  2nd arg string password for the new Coach/User (sha or md5 portalPassword format)
rem	  3rd arg string firstname for the new Coach
rem	  4th arg string lastname for the new Coach
rem	  5th arg string uuid for the new Coach  (string plaintext of propper uuid form)
rem
rem	  6th OPTIONAL arg number=1 to tell script to output to file 
rem	 	instead of the db. File is set to 
rem           ../mssql/sspTrainingDataCompiled(TODAY'S DATE).sql
rem
rem
rem Note: Requires MSSQL 2008 or higher (SQL Script Dependency)
rem

:endOfComments

set "SQLFILEDIR=%~dp0..\..\dataScripts\mssql"
set "SETCOACHUSERSSQLFILE=sspTrainingAddCoachUsers.sql"
set YEAR3=%date:~10,4%
set /a YEAR2=%YEAR3%-1
set FILEDATESTAMP=%date:~4,2%-%date:~7,2%-%date:~10,4%
set "OUTPUTFILE=%~dp0..\..\..\mssql\sspTrainingDataCompiled%FILEDATESTAMP%.sql"

if exist "%SQLFILEDIR%/%SETCOACHUSERSSQLFILE%" (
    if "%6" == "" (        
       if NOT %5 == "" ( 
          sqlcmd  -d ssp -i %SQLFILEDIR%\%SETCOACHUSERSSQLFILE% -v COACHUSERNAME="%1" COACHPASSWORD="%2==" COACHFIRSTNAME="%3" COACHLASTNAME="%4" COACHUUID="%5" YEAR3="%YEAR3%" YEAR2="%YEAR2%" COACHASSIGNED="%5"  

          exit /b %errorlevel%

       ) else (
         echo Not enough input Arguments script: sspTrainingSetCoachUsers.bat!  
         exit /b 1
       )    	

    rem Print To File Option
    ) else if "%7" == "" (
         if "%6" == "1" (

	    rem sqlcmd  -d ssp -i %SQLFILEDIR%\%SETCOACHUSERSSQLFILE% -v COACHUSERNAME="%1" COACHPASSWORD="%2==" COACHFIRSTNAME="%3" COACHLASTNAME="%4" COACHUUID="%5" YEAR3="%YEAR3%" YEAR2="%YEAR2%" COACHASSIGNED="%5" >> %OUTPUTFILE%  
  	    
            exit /b %errorlevel%

         ) else (
             echo Improper sixth argument! Expected: 1  Recieved: %6 
             exit /b 1 
         )
    rem End Print To File Option

    ) else (
	echo Improper number of input arguments script: sspTrainingSetCoachUsers.bat! 
	exit /b 1
    )
) else (
   echo Script file: %SQLFILEDIR%/%SETCOACHUSERSSQLFILE% Not Found!
   exit /b 1
)

rem END OF SCRIPT

