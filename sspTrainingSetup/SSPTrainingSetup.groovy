/**
 * Licensed to Apereo under one or more contributor license
 * agreements. See the NOTICE file distributed with this work
 * for additional information regarding copyright ownership.
 * Apereo licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License.  You may obtain a
 * copy of the License at the following location:
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
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
 *(OPTIONAL) arg3 String filename = filename for the txt file list of other roles (OPTIONAL)
 *
 *(OPTIONAL) arg3 or arg4 String mssql = type "mssql" without the quotes as the last arg, this will switch it to compile
 *   the scripts for mssql and make the produced sql mssql safe
 *
 *(OPTIONAL) arg3 or arg4 or arg5 String file = type "file" without the quotes as the last arg, this will switch the program
 *   to notify the scripts to output their data to a file. If mssql is used this is found in the directory above this one
 *   in the folder mssql and for postgres its in the folder postgres. The file name will be:
 *   sspTrainingDataCompiled(TODAY'S DATE).sql in the respective db version folder.
 *
 * Also, you need to include the jasypt-1.9.0.jar in the classpath. You can do this
 *  for all groovy instances on your system, otherwise its easy enough to include it
 *  via the command line. A sample is provided below.
 *
 * groovy -cp jasypt-1.9.0.jar SSPTrainingSetup.groovy ./sspTrainingUsers.txt ./sspTrainingStudents.txt  ./sspTrainingFaculty.txt
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

    private static final String databaseIntermediateScriptLocation = "dataScriptSubstitutionShellScripts";
    private static final String addReferenceContentScript = "sspTrainingAddReferenceContent";
    private static final String addCoachUserScript = "sspTrainingSetCoachUsers";
    private static final String addStudentUserScript = "sspTrainingSetStudentUsers";
    private static final String addStudentDataScript = "sspTrainingSetStudents";
    private static final String addExternalStudentScript = "sspTrainingSetOneExternalStudent";
    private static final String addFacultyScript = "sspTrainingSetFacultyUsersAndCourses";
    private static final String checkTablesScript = "sspTrainingCheckTables";

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

    private String encryptPassword(String cleartext) {
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
                   if ( args[3].equals("mssql") ) {
                       mssqlDir = "/mssql/";
                       commandFileType = ".bat ";
                       preCommand = "";
                   } else if ( args[3].equals("file") ) {
                       fileParam = " 1";
                   }
               }

               if ( args.size() > 4 ) {
                   if ( args[4].equals("file") ) {
                       fileParam = " 1";
                   }
               }
           } //end check argument list for all possible combinations

           //Begin Processing 3 Text Files if Exist
            SSPTrainingSetup sspTrainingSetup = new SSPTrainingSetup();
            File listOfUsersTxtFile = new File(args[0]);
            File listOfStudentsTxtFile = new File(args[1]);
            def userFileLines = []
            def studentCount = 0
            def checkTableProcess

            if ( !listOfUsersTxtFile.exists() ) {
                 println "File " +args[0] +" does not exist!"
            } else {
                listOfUsersTxtFile.eachLine { line ->
                    if ( !line.isAllWhitespace() && !line.contains('//') ) {
                        userFileLines << line
                    }
                }  //end loop for list of user text file
            } //end processing of users text file
            
            if ( !listOfStudentsTxtFile.exists() ) {
                 println "File " +args[1] +" does not exist!"
            } else {
                listOfStudentsTxtFile.eachLine { line ->
                    if ( !line.isAllWhitespace() && !line.contains('//') ) {
                        studentCount++
                    }
                }  //end loop for list of student text file           
            } //end processing of student text file
            
            //Check if database contains correct number of tables
            if (fileParam != " 1" && commandFileType != ".bat ") {
                    println "\nChecking database for correct amount of tables... "
                    def checkTableCmd = preCommand + databaseIntermediateScriptLocation + mssqlDir +
                       checkTablesScript + commandFileType;
                    checkTableProcess = checkTableCmd.execute()

                    checkTableProcess.in.eachLine { line -> println line }
                    checkTableProcess.out.close()
                    checkTableProcess.waitFor()

                    println "Checking database table count return code: ${checkTableProcess.exitValue()}"
                    println "stderr: ${checkTableProcess.err.text}"
                    println "***Checking database table count complete! ***\n\n"
            } else {
               println "Skipping database table check because file parameter was used."
            }
            //end check database for correct tables


            if( !listOfStudentsTxtFile.exists() && !listOfUsersTxtFile.exists() ) {
              println "File " +args[0] +" or " +args[1] +" does not exist!"
            } else if (studentCount < 4 || ((studentCount%4) <= 1) ) {
              println "Not enough students in " + args[1] + ". There should be 3 internal students and 1 external student for every coach! Found [" + userFileLines.size() + "] coaches and [" + studentCount + "] students!"
            } else if (checkTableProcess && checkTableProcess.exitValue() != 0) {
              println "Not enough tables in the database or error connecting to the database. Make sure SSP specific tables such as person were added by liquibase!"
            } else {
            
                int index = 0;
                int coachCount = 0;
                int externalSyncIndex = 0;
                def coachUUID = "";
                def studentUUID = "";
                def setStudentsCmd = "";

                //insert reference content needed by students and coaches
                println "\nInserting Reference Content (may take a few minutes)... "
                def insertContentCmd = preCommand + databaseIntermediateScriptLocation + mssqlDir +
                        addReferenceContentScript + commandFileType + fileParam;
                def insertContentProcess = insertContentCmd.execute()

                insertContentProcess.in.eachLine { line -> println line }
                insertContentProcess.out.close()
                insertContentProcess.waitFor()

                println "Insert Reference Content return code: ${insertContentProcess.exitValue()}"
                println "stderr: ${insertContentProcess.err.text}"
                println "***Adding Reference Content Complete! ***\n\n"

                println("Starting Coach Users, Students and Associated Data Load")

                //Begin Processing Students Text File and Adding Coach Users and Students
                println "\nInserting Coaches and Students... "
                listOfStudentsTxtFile.eachLine { line ->
                    if ( !line.isAllWhitespace() && !line.contains('//') && coachCount < userFileLines.size() ) {

                        def (coachFirst, coachLast, coachUserName, coachPassword) =
                                userFileLines.get(coachCount).split(' ');

                        if ( index == 0 ) {
                           //next or first coach
                           println "\nInserting Coach... "
                           coachUUID = UUID.randomUUID();
                           def passwordEncrypt = sspTrainingSetup.encryptPassword(coachPassword.trim());

                           def setCoachesCommand = preCommand + databaseIntermediateScriptLocation + mssqlDir +
                                   addCoachUserScript + commandFileType + coachUserName + " " + passwordEncrypt + " " +
                                   coachFirst + " " + coachLast + " " + coachUUID + fileParam;
                           def setCoachesProcess = setCoachesCommand.execute()

                           setCoachesProcess.waitFor()
                           println "Add Coach User " + coachUserName + " return code: ${setCoachesProcess.exitValue()}"
                           println "stdout: ${setCoachesProcess.in.text}"
                           println "stderr: ${setCoachesProcess.err.text}"

                        }

                        def studentLine = line.split(' ');

                        if ( studentLine.size() == 5 ) {
                            //student password found add to uPortal users
                            println "Inserting Student User... "
                                        def studentPasswordEncrypt = sspTrainingSetup.encryptPassword(studentLine[4].trim());
                                        studentUUID = UUID.randomUUID();

                            def setStudentUserCommand = preCommand + databaseIntermediateScriptLocation + mssqlDir +
                                    addStudentUserScript + commandFileType + studentLine[3] + " " + studentPasswordEncrypt +
                                    " " + studentLine[0] + " " + studentLine[2] + " " + studentUUID + fileParam;
                            def setStudentUserProcess = setStudentUserCommand.execute()

                            setStudentUserProcess.waitFor()
                            println "Set Student User: ${studentLine[3]} return code: ${setStudentUserProcess.exitValue()}"
                            println "stdout: ${setStudentUserProcess.in.text}"
                            println "stderr: ${setStudentUserProcess.err.text}"
                        }

                        setStudentsCmd += studentLine[3] + " " + studentLine[0] + " " + studentLine[1] +" "+studentLine[2]+" ";

                        if ( index == 2 ) {
                            //the 3 students
                            println "Inserting the 3 Assigned Students... "
                            setStudentsCmd += (coachUserName + " " + coachUUID + " " + UUID.randomUUID() + " " +
                                    UUID.randomUUID() + " " + UUID.randomUUID() + " " + UUID.randomUUID() + " " +
                                    UUID.randomUUID());

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

                    } else if ( !line.isAllWhitespace() && !line.contains('//') && coachCount >= userFileLines.size() &&
                            externalSyncIndex < coachCount ) {
                        //Add external sync student
                        println "Inserting external sync student... "

                        def (coachFirst, coachLast, coachUserName, coachPassword) =
                            userFileLines.get((coachCount-coachCount+externalSyncIndex)).split(' ');

                        def externalStudentLine = line.split(' ');

                        def setExternalSyncStudent = preCommand + databaseIntermediateScriptLocation + mssqlDir +
                                addExternalStudentScript + commandFileType + externalStudentLine[3] + " " +
                                externalStudentLine[0] + " " + externalStudentLine[1] + " " + externalStudentLine[2] + " " +
                                coachUserName + fileParam;
                       def setExternalSyncStudentProcess = setExternalSyncStudent.execute()

                        setExternalSyncStudentProcess.waitFor()
                        println "Add external sync student for user# ${externalSyncIndex+1} return code: ${setExternalSyncStudentProcess.exitValue()}"
                        println "stdout: ${setExternalSyncStudentProcess.in.text}"
                        println "stderr: ${setExternalSyncStudentProcess.err.text}"

                        externalSyncIndex++;

                    } else {
                        //Do Nothing
                    }

                } //end student text file loop
                println "*** Adding Coach Users and Students with Data Complete! ***\n\n"
                
                //Attempting to add Other Roles...
                if ( args.size() > 2 ) {
                   File listOfOtherRolesTxtFile = new File(args[2]);

                   if ( !listOfOtherRolesTxtFile.exists() ) {
                    println "File :" +args[2] +" doesn't exist!\n"
                   } else {
                       println "\nInserting Other Roles... "
                       def otherRoleUUID = "";
                       def roleFlag = 0;  //0 = no role, 1 = faculty, 2 = manager 3 = support staff, 4 = developer

                       listOfOtherRolesTxtFile.eachLine { line ->
                           if ( !line.isAllWhitespace() && !line.contains('//') && roleFlag == 1) {
                               //Add faculty user
                               otherRoleUUID = UUID.randomUUID();
                               def (facultyFirst, facultyLast, facultyUserName, facultyPassword) = line.split(' ');
   
                               def passwordEncrypt = sspTrainingSetup.encryptPassword(facultyPassword.trim());
   
                               def setFacultyCommand = preCommand + databaseIntermediateScriptLocation + mssqlDir +
                                    addFacultyScript + commandFileType + facultyUserName + " " + passwordEncrypt + " " +
                                    facultyFirst + " " + facultyLast + " " + otherRoleUUID + fileParam;
                               def setFacultyProcess = setFacultyCommand.execute()

                               setFacultyProcess.waitFor()
                               println "Add Faculty User " + facultyUserName + " return code: ${setFacultyProcess.exitValue()}"
                               println "stdout: ${setFacultyProcess.in.text}"
                               println "stderr: ${setFacultyProcess.err.text}"

                           } else if ( !line.isAllWhitespace() && !line.contains('//') && roleFlag == 2 ) {
                               //Add manager user
                               otherRoleUUID = UUID.randomUUID();
                               def (managerFirst, managerLast, managerUserName, managerPassword) = line.split(' ');

                               def passwordEncrypt = sspTrainingSetup.encryptPassword(managerPassword.trim());

                               def setManagerCommand = preCommand + databaseIntermediateScriptLocation + mssqlDir +
                                    addFacultyScript + commandFileType + managerUserName + " " + passwordEncrypt + " " +
                                    managerFirst + " " + managerLast + " " + otherRoleUUID + fileParam;
                               def setManagerProcess = setManagerCommand.execute()

                               setManagerProcess.waitFor()
                               println "Add Manager User " + managerUserName + " return code: ${setManagerProcess.exitValue()}"
                               println "stdout: ${setManagerProcess.in.text}"
                               println "stderr: ${setManagerProcess.err.text}"

                           } else if ( !line.isAllWhitespace() && !line.contains('//') && roleFlag == 3 ) {
                               //Add support staff user
                               otherRoleUUID = UUID.randomUUID();
                               def (supportStaffFirst, supportStaffLast, supportStaffUserName, supportStaffPassword) = line.split(' ');

                               def passwordEncrypt = sspTrainingSetup.encryptPassword(supportStaffPassword.trim());

                               def setSupportStaffCommand = preCommand + databaseIntermediateScriptLocation + mssqlDir +
                                    addFacultyScript + commandFileType + supportStaffUserName + " " + passwordEncrypt + " " +
                                       supportStaffFirst + " " + supportStaffLast + " " + otherRoleUUID + fileParam;
                               def setSupportStaffProcess = setSupportStaffCommand.execute()

                               setSupportStaffProcess.waitFor()
                               println "Add SupportStaff User " + supportStaffUserName + " return code: ${setSupportStaffProcess.exitValue()}"
                               println "stdout: ${setSupportStaffProcess.in.text}"
                               println "stderr: ${setSupportStaffProcess.err.text}"

                           } else if ( !line.isAllWhitespace() && !line.contains('//') && roleFlag == 4 ) {
                               //Add developer user
                               otherRoleUUID = UUID.randomUUID();
                               def (developerFirst, developerLast, developerUserName, developerPassword) = line.split(' ');

                               def passwordEncrypt = sspTrainingSetup.encryptPassword(developerPassword.trim());

                               def setDeveloperCommand = preCommand + databaseIntermediateScriptLocation + mssqlDir +
                                       addFacultyScript + commandFileType + developerUserName + " " + passwordEncrypt + " " +
                                       developerFirst + " " + developerLast + " " + otherRoleUUID + fileParam;
                               def setDeveloperProcess = setDeveloperCommand.execute()

                               setDeveloperProcess.waitFor()
                               println "Add Developer User " + developerUserName + " return code: ${setDeveloperProcess.exitValue()}"
                               println "stdout: ${setDeveloperProcess.in.text}"
                               println "stderr: ${setDeveloperProcess.err.text}"

                           } else if ( !line.isAllWhitespace() && line.contains('//') ) {
                               //Determine SSP Role To Add
                               if ( line.contains('Begin') ) {
                                   //Found role beginning change flag
                                   if ( line.contains('Faculty') ) {
                                       roleFlag = 1
                                   } else if ( line.contains('Manager') ) {
                                       roleFlag = 2
                                   } else if ( line.contains('Support Staff') ) {
                                       roleFlag = 3
                                   } else if ( line.contains('Developer') ) {
                                       roleFlag = 4
                                   } else {
                                       //No valid role found
                                       roleFlag = 0
                                   }
                               }

                           } else {
                               //Do Nothing
                           }
                       } //end loop process other roles file lines
                   } //end processing other roles text file
               }    
            } //end processing of list of students text file
           
         println "\n\n***End of script SSPTrainingSetup***\n\n"
      } //end else process 3 text files
   } //end main
} //end SSPTrainingSetup groovy
