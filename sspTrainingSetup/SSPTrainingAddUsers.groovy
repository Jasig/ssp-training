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

/**
 * This script that will run the necessary data scripts in 
 * ./dataScripts to add users and subsequently 
 * the 3 high quality use case students for each user into the 
 * ssp Postgres database for ssp training. 
 *
 * The ssp database must be setup and running. In addition, the
 *  default Postgres or System User must be setup to automatically
 *  accept passwords such that psql commands can be run without 
 *  a password prompt. 
 *
 *  One way is listed here: http://www.postgresql.org/docs/current/static/libpq-pgpass.html
 *   and there are other ways.
 *
 * Futhermore, the default SSP users and the immutable SSP Training content 
 *  has to be loaded before running this script. Typically that means running
 *  ant ... initportal or initdb and then starting up Tomcat and letting all the 
 *  liquibase run. Finally, you use the command line and the cmd found below.
 *
 *	psql -d ssp -U postgres -f /PATHTOSCRIPTS/sspTrainingImmutableStartupContent.sql
 * 
 * For this script file to run, there must be a list of users in a txt file following the
 *  First Middle LastName Username Password convention. Each user is on their own line and 
 * seperated by a space on that line. 
 *
 * There also must be a list of students in a txt file following the
 *  First Middle Lastname Username  convention. Again each student is on
 *  it's own line and seperated by a space. The script will assign 3
 *  students for one coach. There must be the required amount otherwise
 *  you will get an index out of bounds exception.
 *
 * Also, if you want the students or a student to be able to login, 
 *   the student file line for that student must contain the password as the last parameter.
 *
 * The file names are entered as command line arguments as listed below. 
 *
 * Params: 	 
 *         arg1 String filename = filename for the txt file list of users 
 *	   arg2 String filename = filename for the txt file list of students
 *
 *(OPTIONAL) arg3 String mssql = type "mssql" without the quotes, this will switch it to compile
 *   the scripts for mssql and make the produced sql mssql safe
 *
 *(OPTIONAL) arg3 or arg4 String file = type "file" without the quotes as the last arg, this will switch the program
 *   to notify the scripts to output their data to a file. If mssql is used this is found in the directory above this one
 *   in the folder mssql and for postgres its in the folder postgres. The file name will be:
 *   sspTrainingDataCompiled(TODAY'S DATE).sql in the respective db version folder.
 *
 * Also, you need to include the provided jasypt-1.9.0.jar in the classpath. You can do this
 *  for all groovy instances on your system, otherwise its easy enough to include it
 *  via the command line. A sample is provided below.
 *
 * groovy -cp jasypt-1.9.0.jar SSPTrainingAddUsers.groovy ./sspTrainingUsers.txt ./sspTrainingStudents.txt 
 *
 * Note:
 * The password generator method/constructor was pulled out of uPortal and modified 
 * into a groovy script to be used for SSP Training User Password Generation.
 *
 * The sql output only shows standard error. Errors usually result from not loading the immutable content first
 *  or by having duplicate users or students. The simplest way when errors are encountered is to reset everything 
 *  and to start from scratch by wiping the database and then start over again. However, you can use the groovy file
 *  SSPTrainingRemoveUsers.groovy included in this folder to try and remove the duplicate entries. But be warned, deletes can 
 *  be and are problematic with some of the circular foreign keys found in SSP and total deletion may not be possible 
 *  without a total wipe and restart or extensive manual cleanup of the database.
 *
 */

package sspTrainingSetup;

import sspTrainingSetup.*;
import org.jasypt.digest.config.SimpleDigesterConfig;
import org.jasypt.util.password.ConfigurablePasswordEncryptor;

class SSPTrainingAddUsers {

   private static final String databaseIntermediateScriptLocation = "dataScriptSubstitutionShellScripts";
   private static final String addCoachUserScript = "sspTrainingSetCoachUsers";
   private static final String addStudentUserScript = "sspTrainingSetStudentUsers";
   private static final String addStudentDataScript = "sspTrainingSetStudents";
   private static final String addExternalStudentScript = "sspTrainingSetOneExternalStudent";

   protected static final String MD5_PREFIX = "(MD5)";
   protected static final String SHA256_PREFIX = "(SHA256)";
    
   private ConfigurablePasswordEncryptor md5Encryptor;    
   private ConfigurablePasswordEncryptor sha256Encryptor;	

   public SSPTrainingAddUsers() {  	 
        sha256Encryptor = new ConfigurablePasswordEncryptor();
        SimpleDigesterConfig shaConfig = new SimpleDigesterConfig();
        shaConfig.setIterations(1000);
        shaConfig.setAlgorithm("SHA-256");
        shaConfig.setSaltSizeBytes(8);
        sha256Encryptor.setConfig(shaConfig);
    }

    public String encryptPassword(String cleartext) {
        String encrypted = sha256Encryptor.encryptPassword(cleartext);
        if (encrypted.endsWith("\n")) {
            encrypted = encrypted.substring(0, encrypted.length()-1);
        }
        encrypted = SHA256_PREFIX.concat(encrypted);
        return encrypted;
    }	
	
  
   public static void main(String[] args) {

   def mssqlDir = "/";  //default acts as file separator otherwise holds location of mssql directory
       //form should be /directory/  need a separator before and after
   def fileParam = ""; //defaults to empty, if file is specified will tell scripts to output data to a
       //single file for backup or ease of use
   def commandFileType = ".sh " //defaults to shell if mssql, then bat
   def preCommand = "./"

   if (args.size() < 2) {
       println "\nYou must have command line arguments for the user/coach and student text files!\n\n"
       System.exit(1);
   } else {

       if ( args.size() > 2 ) {
           if ( args[2].equals("mssql") ) {
               mssqlDir = "/mssql/";
               commandFileType = ".bat ";
               preCommand = "";
           } else if ( args[2].equals("file") ) {
               fileParam = " 1";
           }

           if ( args.size() > 3 ) {
               if ( args[3].equals("file") ) {
                   fileParam = " 1";
               }
           }
       }

        SSPTrainingAddUsers sspTrainingAddUsers = new SSPTrainingAddUsers();
        File listOfUsersTxtFile = new File(args[0]);
        File listOfStudentsTxtFile = new File(args[1]);
        def userFileLines = []

        if ( !listOfUsersTxtFile.exists() ) {
             println "File " +args[0] +" does not exist!"
        } else {
            listOfUsersTxtFile.eachLine { line ->
                if ( !line.isAllWhitespace() && !line.contains('//') ) {
                    userFileLines << line
                }
                 }
        }

        if( !listOfStudentsTxtFile.exists() && !listOfUsersTxtFile.exists() ) {
          println "File " +args[0] +" or " +args[1] +" does not exist!"
        } else {
            int index = 0;
            int coachCount = 0;
            int externalSyncIndex = 0;
            def coachUUID = "";
            def setStudentsCmd = "";

            listOfStudentsTxtFile.eachLine { line ->
            if ( !line.isAllWhitespace() && !line.contains('//') && coachCount < userFileLines.size() ) {
                //load students into external and ssp
                def (coachFirst, coachLast, coachUserName, coachPassword) =
                        userFileLines.get(coachCount).split(' ');

                if ( index == 0 ) {
                   //next or first coach
                   println "\nInserting Coach... "
                   coachUUID = UUID.randomUUID();
                   def passwordEncrypt = sspTrainingAddUsers.encryptPassword(coachPassword.trim());

                   def setCoachesCommand = preCommand + databaseIntermediateScriptLocation + mssqlDir +
                           addCoachUserScript + commandFileType + coachUserName + " " + passwordEncrypt + " " +
                           coachFirst + " " + coachLast + " " + coachUUID + fileParam;
                   def setCoachesProcess = setCoachesCommand.execute()

                   setCoachesProcess.waitFor()
                   println "Add Coach User " +coachUserName +" return code: ${setCoachesProcess.exitValue()}"
                   println "stdout: ${setCoachesProcess.in.text}"
                   println "stderr: ${setCoachesProcess.err.text}"

                }

                def studentLine = line.split(' ');

                if ( studentLine.size() == 5 ) {
                    //student password found add to uPortal users
                    println "Inserting Student User... "
                                def studentPasswordEncrypt = sspTrainingAddUsers.encryptPassword(studentLine[4].trim());

                    def setStudentUserCommand = preCommand + databaseIntermediateScriptLocation + mssqlDir +
                            addStudentUserScript + commandFileType + studentLine[3] + " " + studentPasswordEncrypt +
                            " " + studentLine[0] + " " + studentLine[2] + fileParam;
                    def setStudentUserProcess = setStudentUserCommand.execute()

                    setStudentUserProcess.waitFor()
                    println "Add Student User: " +studentLine[3] +" return code: ${setStudentUserProcess.exitValue()}"
                    println "stdout: ${setStudentUserProcess.in.text}"
                    println "stderr: ${setStudentUserProcess.err.text}"
                }

                setStudentsCmd += studentLine[3] + " " + studentLine[0] + " " + studentLine[1] +" "+studentLine[2]+" ";

                if ( index == 2 ) {
                    //the 3 students
                    println "Inserting the 3 Assigned Students... "
                    setStudentsCmd += (coachUserName + " " + coachUUID + " " + UUID.randomUUID() + " " + UUID.randomUUID() + " " +
                        UUID.randomUUID() + " " + UUID.randomUUID() + " " + UUID.randomUUID());

                    def setStudentsCompleteCommand = preCommand + databaseIntermediateScriptLocation + mssqlDir +
                            addStudentDataScript + commandFileType + setStudentsCmd + fileParam;
                    def setStudentsProcess = setStudentsCompleteCommand.execute()

                    setStudentsProcess.waitFor()
                    println "Add students for user# ${coachCount+1} return code: ${setStudentsProcess.exitValue()}"
                    println "stdout: ${setStudentsProcess.in.text}"
                    println "stderr: ${setStudentsProcess.err.text}"

                    coachCount++;
                    index = 0;
                    setStudentsCmd = "";
                } else {
                   index++;
                }
              } else if ( !line.isAllWhitespace() && !line.contains('//') && coachCount >= userFileLines.size() && externalSyncIndex < coachCount ) {
                //Add external sync student
                println "Inserting external sync student... "
                def (coachFirst, coachLast, coachUserName, coachPassword) =
                    userFileLines.get((externalSyncIndex)).split(' ');

                def externalStudentLine = line.split(' ');

                def setExternalSyncStudent = preCommand + databaseIntermediateScriptLocation  + mssqlDir +
                        addExternalStudentScript + commandFileType + externalStudentLine[3] + " " +
                        externalStudentLine[0] + " " + externalStudentLine[1] + " " + externalStudentLine[2] + " " +
                        coachUserName + fileParam;

                def setExternalSyncStudentProcess = setExternalSyncStudent.execute()

                setExternalSyncStudentProcess.waitFor()
                println "Add external sync student for user# ${externalSyncIndex+1} return code: ${setExternalSyncStudentProcess.exitValue()}"
                println "stdout: ${setExternalSyncStudentProcess.in.text}"
                println "stderr: ${setExternalSyncStudentProcess.err.text}"

                externalSyncIndex++;

            }
           }
          }
         println "\n\n***End of script SSPTrainingAddUsers***\n\n"
       }
   }

} //end SSPTrainingAddUsers groovy

