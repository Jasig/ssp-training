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



*** WELCOME TO THE SSP Training SCRIPTS FOLDER ***

 Current SSP Training Version: SSP rel-2-0-patches


 SSP Training has one main script folder named sspTrainingSetup and a main pre-compiled for
  Postgres script file named allSSPTrainingDefaultDataCompiled in the postgres folder. 
  You can run this after Tomcat startup and all the default liquibase has ran. 
  The command is a standard psql command: psql -d ssp -U postgres -f allSSPTrainingDefaultDataCompiled.sql.
  There should be no errors and it may take several minutes to complete. 

 In the future there will be a Microsoft SQL version found in the mssql folder.



 *Read Further Only If You Wish To Modify The Scripts or Data*

 If you wish to recompile the data or to change the default data, the sspTrainingSetup folder 
  is used.The main file to run is SSPTrainingSetup.groovy. 
 The rest of the scripts are for other uses after the training data is setup and loaded into 
  the db or for loading only parts of the training data.
 
 To load the SSP Training Data you need to have the ssp Postgres 9.1 or higher database setup and running. 
  Training does not need any demo data or other modifications. Typical workflow is to install the
  ssp-platform database by running ant ..... initportal or initdb (if platform already installed) and 
  then running tomcat with ssp deployed. After the liquibase runs and you can login into the application
  it is ready. 
 
 Once you are able to login then you can navigate to the setup folder with a terminal window. You need to have 
  groovy installed on your system as well as a bash shell. From the terminal you would then run the groovy
  SSPTrainingSetup.groovy script. Instructions are in the comments in that file, but are also provided here.
  You also need the jasypt jar on your classpath, a way to run it all in one command is provided below.

    groovy -cp jasypt-1.9.0.jar SSPTrainingSetup.groovy ./sspTrainingUsers.txt ./sspTrainingStudents.txt 

 You also need two text files that provide information regarding users and students to add respectively.
  In this folder are two default files (sspTrainingUsers.txt and sspTrainingStudents.txt)that will setup 25 
  default coaches with 3 assigned students each, where all of those 3 students is able to login as well. 
  Furthermore, there will also be another student assigned per coach that is external data only and will
  need to be externally synced. The passwords and usernames are pre-generated and are listed in those files.

  The script should execute correctly and once you login, you can navigate to student search and execute a search 
   for active students. The number students at the bottom should total what is in your list of students text file. 


  *Extras*: There is the possibility to add a 3rd argument to the sspTrainingSetup.groovy file and that is the text file
   containing the information for faculty logins in the same format as the coach users above. This will add the 
   faculty usernames and passwords and make them available to login. Additionaly, it will select at random a number of 
   students and assign them to a course or two for that instructor, so that early_alert functionality can be demonstrated. 


   If a more limited and autonomous demonstration is desired, there is code in sspsspTrainingSetStudentsExternal.sql in 
    the dataScripts folder at the end, that can be uncommented out. It will setup the coaches as faculty and the 3
    assigned students will be in a course, such that early_alerts can be demonstrated without affecting the rest
    of the assigned students.



  *Warning*: You may want to change the admin password after everything is setup correctly. It is the default and
   is not changed automatically by SSP Training.



  *Caveats*: This setup uses 3 different script files for each action, the groovy script file, a bash shell script 
   executing sed, and then the sql files sent to postgres. There can be multiple failures in this system, however 
   it is most likely there will only be an error in one part, which is by design. Furthemore, this setup 
   allows a high level of customization and accomodates easier rewrites for future upgrades and adaptions.
   
   Generally, if you do not move the files in sspTrainingSetup and they have adequete permissions for the current 
   user and the user that owns the ssp database you will not have any problems. If a problem does occur it is 
   likely a permission issue as listed above or a bash/sed version issue. The bash scripts are located in the
   dataScriptSubstitutionShellScripts folder.
    
   These can be replaced entirely as they merely serve as a way to substitute variables into the sql scripts and 
   then run them without generating hard copies. To do so in groovy or sql would require alot more work, but it can
   be done. However, if there is an issue typically the error will be descriptive and you can use a search engine
   to search for solutions in your version for the bash and sed commands. 

   Finally, the dataScripts folder contains the sql with capitalized variables that are to be substituted with
   real values and then executed in postgres for the ssp database. These scripts are in plain text and can be 
   customized and adapted with database changes. The current version these scripts were created against was SSP 2.1. 
   So, for different versions a good workflow is to run the scripts and see what fails. If there are lots of errors, 
   you can run each script manually by making the substitutions and then running it to find what changes are necessary. 

   If nothing is working there is a pg_dump sql file in the postgres folder that was generated from the ssp 
   training database with the data loaded for rel-2-0-patches. It is a fixed snapshot in time including liquibase.
   So, it needs a fully empty ssp database!

   It can be run on the command line with this command: 
	psql -d ssp -U postgres -f /pathTOfile/pgDumpOfSSPTraining.sql 
   That should run successfully with a 0 table empty ssp database. 

   If it does not, then there are some database setup issues that need to be addressed.

END README
