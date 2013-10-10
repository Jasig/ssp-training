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
 * This script will run the necessary data scripts in 
 * ./dataScripts to add high-quality content, demo coaches, and the subsequent 
 * 3 high quality use case students into the ssp Postgres database for training purposes. 
 *
 * It also will add students as users such that they will be able to login into myGPS
 *  if there is a password provided (see comments below).
 *
 * To start with, the default Postgres or System User must be setup to automatically
 *  accept passwords such that psql commands can be run without a password prompt. 
 *
 *  One way is listed here: http://www.postgresql.org/docs/current/static/libpq-pgpass.html
 *   and there are other ways.
 *
 * Then the default ssp database must be setup. Typically that is done with 
 *    ant ... initportal or initdb, followed by starting up Tomcat and letting all the 
 *  liquibase run. 
 *
 * For this script to run, there must be a list of users in a txt file following the
 *  First Middle LastName Username convention. Each user is on their own line and 
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
 *(OPTIONAL) arg3 String filename = filename for the txt file list of faculty (OPTIONAL)
 *
 * Also, you need to include the jasypt-1.9.0.jar in the classpath. You can do this
 *  for all groovy instances on your system, otherwise its easy enough to include it
 *  via the command line. A sample is provided below.
 *
 * groovy -cp jasypt-1.9.0.jar SSPTrainingSetup.groovy ./sspTrainingUsers.txt ./sspTrainingStudents.txt
 *
 * Note:
 * The password generator method/constructor was pulled out of uPortal and modified 
 * into a groovy script to be used for training purposes User Password Generation.
 *
 * The sql output only shows standard error. Errors usually result from not loading the immutable content first
 *  or by having duplicate users or students. The simplest way when errors are encountered is to reset everything 
 *  and to start from scratch by wiping the database and then start over again. However, you can use the groovy file
 *  sspTrainingRemoveUsers.groovy included in this folder to try and remove the duplicate entries. But, be warned deletes can 
 *  be and are problematic with some of the circular foreign keys found in SSP and total deletion may not be possible 
 *  without a total database wipe and restart or extensive manual cleanup of the database.
 *
 */

package sspTrainingSetup;

import sspTrainingSetup.*;
import org.jasypt.digest.config.SimpleDigesterConfig;
import org.jasypt.util.password.ConfigurablePasswordEncryptor;

class SSPTrainingSetup {

   protected static final String MD5_PREFIX = "(MD5)";
   protected static final String SHA256_PREFIX = "(SHA256)";
    
   private ConfigurablePasswordEncryptor md5Encryptor;    
   private ConfigurablePasswordEncryptor sha256Encryptor;	

   public SSPTrainingSetup() {  	 
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

   if (args.size() < 2) {
       println "\nYou must have command line arguments for the user/coach and student text files!\n\n"
       System.exit(1);
   } else {
	
        SSPTrainingSetup sspTrainingSetup = new SSPTrainingSetup();
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

            //insert reference content needed by students and coaches
            println "\nInserting Reference Content (may take a few minutes)... "
            def insertContentCmd = "./dataScriptSubstitutionShellScripts/sspTrainingAddReferenceContent.sh";
            def insertContentProcess = insertContentCmd.execute()

            insertContentProcess.in.eachLine { line -> println line }
            insertContentProcess.out.close()
            insertContentProcess.waitFor()

            println "Insert Reference Content return code: ${insertContentProcess.exitValue()}"
            println "stderr: ${insertContentProcess.err.text}"


            listOfStudentsTxtFile.eachLine { line ->
            if ( !line.isAllWhitespace() && !line.contains('//') && coachCount < userFileLines.size() ){

                def (coachFirst, coachLast, coachUserName, coachPassword) =
                        userFileLines.get(coachCount).split(' ');

                if ( index == 0 ) {
                   //next or first coach
                   println "\nInserting Coach... "
                   coachUUID = UUID.randomUUID();
                   def passwordEncrypt = sspTrainingSetup.encryptPassword(coachPassword);

                   def setCoachesCommand = "./dataScriptSubstitutionShellScripts/sspTrainingSetCoachUsers.sh " +
                         coachUserName + " " + passwordEncrypt + " " + coachFirst + " " + coachLast + " " + coachUUID;
                   def setCoachesProcess = setCoachesCommand.execute()

                   setCoachesProcess.waitFor()
                   println "Add Coach User " + coachUserName + " return code: ${setCoachesProcess.exitValue()}"
                   //println "stdout: ${setCoachesProcess.in.text}"
                   println "stderr: ${setCoachesProcess.err.text}"

                }

                def studentLine = line.split(' ');

                if ( studentLine.size() == 5 ) {
                    //student password found add to uPortal users
                    println "Inserting Student User... "
                                def studentPasswordEncrypt = sspTrainingSetup.encryptPassword(studentLine[4]);

                    def setStudentUserCommand = "./dataScriptSubstitutionShellScripts/sspTrainingSetStudentUsers.sh " +
                    studentLine[3] + " " + studentPasswordEncrypt + " " + studentLine[0] + " " + studentLine[2];
                    def setStudentUserProcess = setStudentUserCommand.execute()

                    setStudentUserProcess.waitFor()
                    println "Set Student User: ${studentLine[3]} return code: ${setStudentUserProcess.exitValue()}"
                    //println "stdout: ${setStudentUserProcess.in.text}"
                    println "stderr: ${setStudentUserProcess.err.text}"
                }

                setStudentsCmd += studentLine[3] + " " + studentLine[0] + " " + studentLine[1] +" "+studentLine[2]+" ";

                if ( index == 2 ) {
                    //the 3 students
                    println "Inserting the 3 Assigned Students... "
                    setStudentsCmd += (coachUserName + " " + coachUUID + " " + UUID.randomUUID() + " " + UUID.randomUUID() + " " +
                        UUID.randomUUID() + " " + UUID.randomUUID() + " " + UUID.randomUUID());

                    def setStudentsCompleteCommand = "./dataScriptSubstitutionShellScripts/sspTrainingSetStudents.sh " + setStudentsCmd;
                    def setStudentsProcess = setStudentsCompleteCommand.execute()

                    setStudentsProcess.waitFor()
                    println "Add students for user# ${coachCount+1} return code: ${setStudentsProcess.exitValue()}"
                    //println "stdout: ${setStudentsProcess.in.text}"
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
                    userFileLines.get((coachCount-coachCount+externalSyncIndex)).split(' ');

                def externalStudentLine = line.split(' ');

                def setExternalSyncStudent = "./dataScriptSubstitutionShellScripts/sspTrainingSetOneExternalStudent.sh " +
                        externalStudentLine[3] + " " + externalStudentLine[0] + " " + externalStudentLine[1] + " " + externalStudentLine[2] + " " +
                        coachUserName;
                  println "\nCMD: " +setExternalSyncStudent +" \n\n"
               def setExternalSyncStudentProcess = setExternalSyncStudent.execute()

                setExternalSyncStudentProcess.waitFor()
                println "Add external sync student for user# ${externalSyncIndex+1} return code: ${setExternalSyncStudentProcess.exitValue()}"
                //println "stdout: ${setExternalSyncStudentProcess.in.text}"
                println "stderr: ${setExternalSyncStudentProcess.err.text}"

                externalSyncIndex++;
            }
           }
         }

         if ( args.size() > 2 ) {
             File listOfFacultyUsersTxtFile = new File(args[2]);

             if ( !listOfFacultyUsersTxtFile.exists() ) {
                 println "File :" +args[2] +" doesn't exist!\n"
             } else {
                 println "\nInserting Faculty Users... "

                 listOfFacultyUsersTxtFile.eachLine { line ->

                     if ( !line.isAllWhitespace() && !line.contains('//') ) {

                         def (facultyFirst, facultyLast, facultyUserName, facultyPassword) = line.split(' ');

                         def passwordEncrypt = sspTrainingSetup.encryptPassword(facultyPassword);

                         def setFacultyCommand = "./dataScriptSubstitutionShellScripts/sspTrainingSetFacultyUsersAndCourses.sh " +
                                 facultyUserName + " " + passwordEncrypt + " " + facultyFirst + " " + facultyLast;
                         def setFacultyProcess = setFacultyCommand.execute()

                         setFacultyProcess.waitFor()
                         println "Add Faculty User " + facultyUserName + " return code: ${setFacultyProcess.exitValue()}"
                         //println "stdout: ${setFacultyProcess.in.text}"
                         println "stderr: ${setFacultyProcess.err.text}"

                     }
                 }
             }
          }

        println "\n\n***End of script SSPTrainingSetup***\n\n"
     }
   }
} //end SSPTrainingSetup groovy
