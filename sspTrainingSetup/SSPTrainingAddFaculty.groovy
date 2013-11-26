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
 * ./dataScripts to add faculty users and subsequently 
 * have Early Alert demo capabilities in SSP Training. 
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
 * For this script file to run, there must be a list of faculty users in a txt file following the
 *  First Middle LastName Username Password convention. Each user is on their own line and 
 * seperated by a space on that line. 
 *
 * Finally, you must have run either SSPTrainingSetup.groovy or SSPTrainingAddUsers.groovy before
 *  running this file as it will use students already populated to compile courses for the
 *  faculty you are adding. 
 *
 *
 * The file names are entered as command line arguments as listed below. 
 *
 * Params: 	 
 *         arg1 String filename = filename for the txt file list of faculty
 *
 *(OPTIONAL) arg2 String mssql = type "mssql" without the quotes this will switch it to compile
 *   the scripts for mssql and make the produced sql mssql safe
 *
 *(OPTIONAL) arg2 or arg3 String file = type "file" without the quotes as the last arg, this will switch the program
 *   to notify the scripts to output their data to a file. If mssql is used this is found in the directory above this one
 *   in the folder mssql and for postgres its in the folder postgres. The file name will be:
 *   sspTrainingDataCompiled(TODAY'S DATE).sql in the respective db version folder.
 *
 * Also, you need to include the provided jasypt-1.9.0.jar in the classpath. You can do this
 *  for all groovy instances on your system, otherwise its easy enough to include it
 *  via the command line. A sample is provided below.
 *
 * groovy -cp jasypt-1.9.0.jar SSPTrainingAddFaculty.groovy ./TrainingFaculty.txt
 *
 * Note:
 * The password generator method/constructor was pulled out of uPortal and modified 
 * into a groovy script to be used for SSP Training User Password Generation.
 *
 * The sql output only shows standard error. Errors usually result from not loading the immutable content first
 *  or by having duplicate users or students. The simplest way when errors are encountered is to reset everything 
 *  and to start from scratch by wiping the database and then start over again. However, you can use the groovy file
 *  SSPTrainingRemoveUsers.groovy included in this folder to try and remove the duplicate entries. But, be warned deletes can 
 *  be and are problematic with some of the circular foreign keys found in SSP and total deletion may not be possible 
 *  without a total database wipe and restart or extensive manual cleanup of the database.
 *
 */

package sspTrainingSetup;

import sspTrainingSetup.*;
import org.jasypt.digest.config.SimpleDigesterConfig;
import org.jasypt.util.password.ConfigurablePasswordEncryptor;

class SSPTrainingAddFaculty {

   private static final String databaseIntermediateScriptLocation = "dataScriptSubstitutionShellScripts";
   private static final String addFacultyScript = "sspTrainingSetFacultyUsersAndCourses";

   protected static final String MD5_PREFIX = "(MD5)";
   protected static final String SHA256_PREFIX = "(SHA256)";

   private ConfigurablePasswordEncryptor md5Encryptor;    
   private ConfigurablePasswordEncryptor sha256Encryptor;

   public SSPTrainingAddFaculty() {  	 
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

    if (args.size() < 1) {
        println "\nYou must have a command line argument for the faculty text file!\n\n"
        System.exit(1);
    } else {

    if ( args.size() > 1 ) {
        if ( args[1].equals("mssql") ) {
            mssqlDir = "/mssql/";
            commandFileType = ".bat ";
            preCommand = "";
        } else if ( args[1].equals("file") ) {
            fileParam = " 1";
        }

        if ( args.size() > 2 ) {
            if ( args[2].equals("file") ) {
                fileParam = " 1";
            }
        }
    }

	SSPTrainingAddFaculty sspTrainingAddFaculty = new SSPTrainingAddFaculty(); 		 
	File listOfFacultyTxtFile = new File(args[0]);

    if( !listOfFacultyTxtFile.exists() ) {
	  println "Faculty File " +args[0] +" does not exist!"
  	} else {

        listOfFacultyTxtFile.eachLine { line ->

            if ( !line.isAllWhitespace() && !line.contains('//') ) {

                println "\nInserting Faculty Users... "

                if ( !line.isAllWhitespace() && !line.contains('//') ) {

                    def (facultyFirst, facultyLast, facultyUserName, facultyPassword) = line.split(' ');

                    def passwordEncrypt = sspTrainingAddFaculty.encryptPassword(facultyPassword.trim());

                    def setFacultyCommand = preCommand + databaseIntermediateScriptLocation + mssqlDir + addFacultyScript +
                            commandFileType + facultyUserName + " " + passwordEncrypt + " " + facultyFirst + " " + facultyLast + fileParam;

                    def setFacultyProcess = setFacultyCommand.execute()

                    setFacultyProcess.waitFor()
                    println "Add Faculty User " + facultyUserName + " return code: ${setFacultyProcess.exitValue()}"
                    println "stdout: ${setFacultyProcess.in.text}"
                    println "stderr: ${setFacultyProcess.err.text}"
                }
            }
          }
	
        }

       println "\n\n***End of script SSPTrainingAddFaculty***\n\n"
      }
    }

} //end SSPTrainingAddFaculty groovy

