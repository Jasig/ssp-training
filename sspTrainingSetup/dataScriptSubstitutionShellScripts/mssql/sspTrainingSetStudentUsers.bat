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
rem *** SSP Insert Student Users into SSP Training Script MSSQL Version ***
rem
rem This script adds a student that is able to login into SSP-Platform
rem  for SSP Training by using sed to substitute variables in the sql
rem  file with command line arguments of real values. This is then automatically
rem  executed for database 'ssp' using the psql command. 
rem
rem Params: 1st arg string username for the new Student Login
rem	  2nd arg string password for the new Student Login (sha or md5 portalPassword format)
rem	  3rd arg string firstname for the new Student Login
rem	  4th arg string lastname for the new Student Login
rem
rem	  5th OPTIONAL arg number=1 to tell script to output to file 
rem	 	instead of the db. File is set to 
rem           ../mssql/sspTrainingDataCompiled(TODAY'S DATE).sql
rem
rem Note: Requires MSSQL 2008 or higher (SQL Script Dependency)
rem

:endOfComments

set "SQLFILEDIR=%~dp0..\..\dataScripts\mssql"
set "SETSTUDENTUSERSSQLFILE=sspTrainingAddStudentUsers.sql"
set FILEDATESTAMP=%date:~4,2%-%date:~7,2%-%date:~10,4%
set "OUTPUTFILE=%~dp0..\..\..\mssql\sspTrainingDataCompiled%FILEDATESTAMP%.sql"

if exist "%SQLFILEDIR%\%SETSTUDENTUSERSSQLFILE%" (
    if "%5" == "" (        
       if NOT "%4" == "" (
	  sqlcmd  -d ssp -i %SQLFILEDIR%\%SETSTUDENTUSERSSQLFILE% -v STUDENTUSERNAME="%1" STUDENTPASSWORD="%2==" STUDENTFIRSTNAME="%3" STUDENTLASTNAME="%4"
 
          exit /b %errorlevel%

       ) else (
          echo Not enough input arguments in script: sspTrainingSetStudentUsers.bat! 
	  exit /b 1
       )
    
    rem Print To File Option
    ) else if "%6" == "" (
       if "%5" == "1" (

          rem  sqlcmd  -d ssp -i %SQLFILEDIR%\%SETSTUDENTUSERSSQLFILE% -v STUDENTUSERNAME1="%1" STUDENTPASSWORD="%2==" STUDENTFIRSTNAME="%3" STUDENTLASTNAME="%4" >> %OUTPUTFILE%	

            exit /b %errorlevel%
   
        ) else (
           echo Improper fifth argument! Expected: 1  Recieved: %5 
           exit /b 1
        )        
    rem End Print To File Option
    
   ) else (
	echo Improper number of input arguments in script: sspTrainingSetStudentUsers.bat! 
	exit /b 1
   )

) else (
   echo Script file: %SQLFILEDIR%\%SETSTUDENTUSERSSQLFILE% Not Found!
   exit /b 1
)

rem END OF SCRIPT

