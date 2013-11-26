/**
 * Licensed to Jasig under one or more contributor license
 * agreements. See the NOTICE file distributed with this work
 * for additional information regarding copyright ownership.
 * Jasig licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a
 * copy of the License at:
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */


ssp-training
============




*** WELCOME TO SSP Training ***

 Current SSP Training Version: rel-2-0-patches. Tested on and compatible with versions: SSP2.0, SSP2.1, and SSP2.2.
     Database versions: MSSQL 2008 and Postgres 9.1 tested. 

 SSP Training is designed to provide an easy to use, yet flexible way to add high quality demo-data to an empty SSP
 installation. This data can be used for training, demonstrations, and testing. The default scripts and setup files will add
 25 coaches with 3 login able students assigned per coach. Additionally, it will install  an extra 25 students that are in
 external data only (for external sync demo) and 3 faculty members with two random courses of 10 random students each for
 Early Alert demo purposes. Finally, it also installs high quality static data, from MAP templates to electives and more.  In
 summary, it is everything needed to give a good demonstration or train a small group of users on SSP. 

 For a list of the default logins see the included file in this directory SSP_TRAINING_DEFAULT_LOGIN_DATA.xlsx.

 Known Issues: In MSSQL adding or editing a uPortal/SSP-Platform user in the "manage users" interface will generate an 
     error the first time such a change (add or edit) is made. Subsequent tries will work successfully. 

 *Warning*: You may want to change the admin password after everything is setup correctly. It is the SSP install default and 
   is not changed automatically by SSP Training.


*Quick Install*

 To get started quickly with SSP Training, there are two folders for different databases. Pick the folder that represents the 
 database type on your machine. Once inside, there are  two pre-compiled scripts. Generally, except in rare situations, you 
 won't need to use the files that are named with dump in the name. These are for troubleshooting when nothing else works. The 
 file to run will be named similar to this: allSSPTrainingDefaultDataCompiled.sql. It should be one command to run it and 
 depending on your system's speed, will take a few minutes.  This file should  only be ran after Tomcat has started and all 
 the default SSP liquibase has ran. 

 The standard psql command: psql -d ssp -U postgres -f allSSPTrainingDefaultDataCompiled.sql.
 
 The standard mssql command: sqlcmd -d ssp -i allSSPTrainingDefaultDataCompiled.sql
  

*Customizable Install*

 SSP Training is flexible and easy to modify. Not only can sql files be modified for database changes quite easily, but the 
 amount of users, logins, students and faculty can all be changed.  SSP Training is separated into 3 parts, main groovy 
 script files that parse the txt files and call the shell scripts, the intermediate (shell) scripts that substitute values in 
 data sql files and run them against the database,  and finally the sql template data files that provide the database 
 commands to add users etc.

 All these files are located in the sspTrainingSetup folder. The groovy scripts are in that directory, the intermediate 
 scripts are in dataScriptSubstitutionShellScripts and the sql templates are in dataScripts. Inside those two folders another 
 sub-folder is found named mssql, which is where the mssql specific scripts are found. 
 
 The groovy file is SSPTrainingSetup.groovy. It was used to create the pre-compiled files found in the quick install section 
 above and has many options. The rest of the scripts are for other uses after the training data is setup and loaded into 
 the db or for loading only parts of the training data. Comments and instructions are found in each of the individual files. 
 
 To load the SSP Training Data via groovy you need to have the ssp  database setup and running. SSP Training does not need 
 any demo data or other modifications, just a default SSP install. Typical work flow is to install the ssp-platform database 
 by running ant ..... initportal (or initdb if platform already installed) and then running tomcat with ssp deployed. After 
 the liquibase runs and the changelog lock is released the installation is ready for the training data. 
 
 With groovy available on the command line and a knowledge of what database type you have, you can run the command below to 
 install the SSP Training data. If you have a mssql implementation then just add another argument of “mssql” without quotes 
 to the end of this command. 

   groovy -cp jasypt-1.9.0.jar SSPTrainingSetup.groovy sspTrainingUsers.txt sspTrainingStudents.txt sspTrainingFaculty.txt
 
 If you run that with the defaults supplied, you will get the same results as the compiled sql file in the database folders. 
 To modify the data specifics, there are 3 txt files that can be modified: sspTrainingUsers.txt, sspTrainingStudents.txt, and 
 sspTrainingFaculty.txt. The passwords and usernames are per-generated and are listed in those files. You can make 
 modifications to these files before you run the groovy script above and those changes will be reflected in the final 
 product. The formatting (instructions are at the top of each file) must be preserved for successful parsing. 

 To verify your installation the script should execute correctly and once you login, you can navigate to student search and 
 execute a search for active students. The digit number of students at the bottom should total what is in your list of 
 students text file. 


*Extras*

 There is the possibility to add an argument to the groovy script files (with or without mssql) name “file” without 
 the quotes. This will output the sql into one file found in the postgres or mssql folders found in the root of this 
 repository. This can be used as a run once script, just like the defaults provided. 


*Output To File*

 The shell scripts can output all the compiled sql data to a file. If this is desired, add as the last
 argument "file" to any of the groovy scripts (without the quotes). This will be last even after mssql. Once this option is
 selected the  output will only go to a file and not the db. The file will be created in it's respective database named 
 directory of postgres or mssql in this folder. The name will include today's date. 
  NOTE: If you wish to run this twice in single day, then you must delete the old one, otherwise the new data will append 
   to the old file. 
  Currently the file output doesn't work for mssql. This should be resolved in future versions. 


*Caveats*

 This setup uses 3 different script files for each action, the groovy script file, an intermediate script, and then the sql 
 files. There can be multiple failures in this system, however it is most likely there will only be an error in the 
 intermediate area, which is by design. 
   
 Generally, if you do not move the files in sspTrainingSetup and they have adequate permissions for the current 
 user and the user that owns the ssp database you will not have any problems. If a problem does occur it is 
 likely a permission issue as listed above or a bash/sed/batch version issue. 
    
 Finally, the dataScripts folder contains the sql with capitalized variables that are to be substituted with
 real values and then executed in the ssp database. These scripts are in plain text and can be 
 customized and adapted with database changes. The current version these scripts were created against was SSP 2.0. 
 So, for different versions a good workflow is to run the scripts and see what fails. If there are lots of errors, 
 you can run each script manually by making the substitutions and then running it to find what changes are necessary. 
 Generally, the sql error output will give a good indication of what went wrong.

 
 If nothing is working there is a pg_dump sql file in the postgres folder that was generated from the ssp 
 training database with the data loaded for rel-2-0-patches. It is a fixed snapshot in time including liquibase.
 So, it needs a fully empty ssp database! (No tables should be in it).

 If it does not, then there are some database setup issues or SSP installation issues that need to be addressed.

END README
