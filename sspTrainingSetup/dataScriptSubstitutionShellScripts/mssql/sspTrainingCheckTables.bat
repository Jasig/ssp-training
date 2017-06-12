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
rem *** SSP Check Database Table Count SSP Training Script ***
rem
rem This script checks the tables and in the future more from the ssp Sql Server database
rem  for SSP Training. This is to identify if SSP tables exist. It is automatically
rem  executed for database 'ssp' using the psql command. 
rem
rem Params: 1st arg string name of the ssp database (optional)
rem	  2nd arg string name of the ssp schema (optional) *not used at this time
rem         3rd arg string name of the ssp db user (optional)
rem
rem
rem Note: Requires MSSQL 2008 or higher (SQL Script Dependency)
rem

:endOfComments

set "SQLFILEDIR=%~dp0..\..\dataScripts\mssql"
set "DATABASE=ssp"
set "SCHEMA=dbo"
set "USER=sspadmin"
set SSPTABLECOUNT28=265

set cmdArgNumber=0
for %%x in (%*) do set /a cmdArgNumber+=1

if "%cmdArgNumber%" == "3" (
   set DATABASE=%1
   set SCHEMA=%2
   set USER=%3
   
) else if "%cmdArgNumber%" == "2" (   
   set DATABASE=%1
   set SCHEMA=%2
   
) else if "%cmdArgNumber%" == "2" (
   set DATABASE=%1 
   
) else (
   rem do nothing at this time
)   

set "tableCount="
for /f %%A in (
  'sqlcmd -d %DATABASE% -U %USER%  -Q "SET NOCOUNT ON;SELECT COUNT(*) from information_schema.tables WHERE table_type = base table;"'
) do set "tableCount=%%A"

echo Result: [%tableCount%] 



if "%tableCount%" == "%SSPTABLECOUNT28%" (
   echo "Found at least "%SSPTABLECOUNT28%" tables!"
   exit /b 0
   
) else (
   echo "Not enough tables or error connecting to database!"
   exit /b 1
)

rem END OF SCRIPT
