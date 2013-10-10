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
 * ./dataScripts to remove users and subsequently the 3 high quality 
 *  use case students from the ssp Postgres database for SSP Training. 
 *
 * For this script file, there must be a list of users in a txt file following the
 *  First Middle LastName Username convention. Each user is on their own line and 
 *  seperated by a space on that line. 
 *
 * There also must be a list of students in a txt file following the
 *  First Middle Lastname Username  convention. Again each student is on
 *  it's own line and seperated by a space. The script will de 3
 *  students for one coach. There must be the required amount otherwise
 *  you will get an index out of bounds exception.
 *
 * The file names are entered as command line arguments as listed below. 
 *
 * Params: 	 
 *         arg1 String filename = filename for the txt file list of users 
 *	   arg2 String filename = filename for the txt file list of students
 *
 * A sample is provided below.
 *
 * groovy SSPTrainingRemoveUsers.groovy ./sspTrainingUsers.txt ./sspTrainingStudents.txt 
 *
 */

package sspTrainingSetup;

import sspTrainingSetup.*;

class SSPTrainingRemoveUsers {

   public static void main(String[] args) {

   if (args.size() < 2) {
       println "\nYou must have command line arguments for the user/coach and student text files!\n\n"
       System.exit(1);
   } else {
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
            def deleteStudentsCmd = "";

            listOfStudentsTxtFile.eachLine { line ->
            if ( !line.isAllWhitespace() && !line.contains('//') && coachCount < userFileLines.size() ){

                def (coachFirst, coachLast, coachUserName, coachPassword) =
                        userFileLines.get(coachCount).split(' ');

                def (first, middle, last, username) = line.split(' ');

                    deleteStudentsCmd += username + " ";

                if ( index == 2 ) {
                    println "\nDeleting User " +coachUserName +" and the Assigned Students... "
                    def deleteUserAndStudentsCmd = "./dataScriptSubstitutionShellScripts/sspTrainingDeleteUserAndAssignedStudents.sh " +
                    coachUserName + " " + deleteStudentsCmd;
                    def deleteStudentsProcess = deleteUserAndStudentsCmd.execute()
                        deleteStudentsProcess.waitFor()
                    println "Delete students for user# ${coachCount+1} return code: ${ deleteStudentsProcess.exitValue()}"
                    println "stdout: ${deleteStudentsProcess.in.text}"
                    println "stderr: ${deleteStudentsProcess.err.text}"
                    coachCount++;
                    index = 0;
                    deleteStudentsCmd = "";
                } else {
                   index++;
                }
            }
          }
        }
        println "\n\n***End of script SSPTrainingRemoveUsers***\n\n"
      }
   }

} //end SSPTrainingRemoveUsers.groovy

