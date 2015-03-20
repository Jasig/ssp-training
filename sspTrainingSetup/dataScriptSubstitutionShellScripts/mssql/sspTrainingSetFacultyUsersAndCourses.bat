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
rem *** SSP Insert Faculty Users and Courses into SSP Training Script MSSQL Version***
rem
rem This script adds a faculty member that is able to login into SSP-Platform
rem  for SSP Training by using sed to substitute variables in the sql
rem  file with command line arguments of real values. This is then automatically
rem  executed for database 'ssp' using the psql command. 
rem
rem  Futhermore, it will also assign that faculty a random selection of courses
rem   and a random selection of existing students as the roster. 
rem
rem Params: 1st arg string username for the new Faculty Login
rem	  2nd arg string password for the new Faculty (sha or md5 portalPassword format)	  
rem	  3rd arg string firstname for the new Faculty
rem	  4th arg string lastname for the new Faculty
rem       5th arg string UUID for the new Faculty
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
set "SETFACULTYUSERSSQLFILE=sspTrainingAddUsers.sql"
set "SETFACULTYEXTERNALSQLFILE=sspTrainingSetFacultyExternal.sql"
set "OUTPUTFILE=%~dp0..\..\..\mssql\sspTrainingDataCompiled%FILEDATESTAMP%.sql"
set YEAR3=%date:~10,4%
set FILEDATESTAMP=%date:~4,2%-%date:~7,2%-%date:~10,4%
set "OUTPUTFILE=%~dp0..\..\..\mssql\sspTrainingDataCompiled%FILEDATESTAMP%.sql"


if exist "%SQLFILEDIR%\%SETFACULTYUSERSSQLFILE%" (
   if exist "%SQLFILEDIR%\%SETFACULTYEXTERNALSQLFILE%" (

    set "FACULTYUSER=%1"	

    if "%6" == "" (	
       if NOT "%5" == "" (
	      
          sqlcmd -d ssp -i %SQLFILEDIR%\%SETFACULTYUSERSSQLFILE% -v USERNAME="%1" USERPASSWORD="%2==" USERFIRSTNAME="%3" USERLASTNAME="%4" USERUUID="%5" USERROLE="FACULTY" USER_IS_MAP_TEMPLATE_ADMIN="0"               
          
	  echo Adding Faculty User Records Complete

	  sqlcmd  -d ssp -i %SQLFILEDIR%\%SETFACULTYEXTERNALSQLFILE% -v FACULTYUSER="%FACULTYUSER%" YEAR3="%YEAR3%"
	
          exit /b %errorlevel%
	 
	 echo Adding External Faculty and Course and Roster Records Complete

        ) else (
          echo Not enough input arguments in script: sspTrainingSetFacultyExternal.bat!
          exit /b 1
        )
    
     rem Print To File Option
     ) else if "%7" == "" (
          if "%6" == "1" (
		  
             sqlcmd -d ssp -i %SQLFILEDIR%\%SETFACULTYUSERSSQLFILE% -v USERNAME="%1" USERPASSWORD="%2==" USERFIRSTNAME="%3" USERLASTNAME="%4" USERUUID="%5" USERROLE="FACULTY" USER_IS_MAP_TEMPLATE_ADMIN="0" -e >> %OUTPUTFILE% 
	
             echo Printing Faculty User Records To File Complete
             
             sqlcmd  -d ssp -i %SQLFILEDIR%\%SETFACULTYEXTERNALSQLFILE% -v FACULTYUSER="%FACULTYUSER%" YEAR3="%YEAR3%" -e >> %OUTPUTFILE%  	     	
             
			 exit /b %errorlevel%
	     
		 echo Printing External Faculty and Course and Roster Records to File Complete

          ) else (
              echo Improper 6th argument! Expected: 1  Recieved: %6
              exit /b 1 
          )
    rem End Print To File Option

    ) else (
	echo Improper number of input arguments in script: sspTrainingSetFacultyExternal.bat!
	exit /b 1 
    )
  ) else (    
    echo Script file: %SQLFILEDIR%\%SETFACULTYEXTERNALSQLFILE% Not Found!
    exit /b 1 
  )
) else (
    echo Script file: %SQLFILEDIR%\%SETFACULTYUSERSSQLFILE% Not Found!
    exit /b 1 
)

rem END OF SCRIPT

