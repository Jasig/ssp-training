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


/*
 * *** SSP TRAINING SET FACULTY USER EXTERNAL DATA FOR EARLY ALERT MSSQL Version***
 *
 * This SQL File sets a Faculty user with external data from a random selection
 *  of existing students and courses, such that the early alert portlet and subsequent 
 *  functionality can be demonstrated.  
 * 
 * The database must be setup with reference data and the basic SSP required table structure.
 * Furthermore, this script must be run after the student data, coach data, and other external data has
 *  been populated as it will use that to generate random but useful data.
 *
 * Finally, below you will find a section with deletes. This is commented out by default, but it 
 *  can be used on a populated database to "refresh" the external data if that is desired.
 *
 * WARNING: In this instance the delete will delete all the data in the two faculty course related tables!
 *
 * To use this file substitute the placeholders below via some other script
 *  or manually with the 3 names of the students you wish to reset. 
 *
 * Substitute: 
 *      $(FACULTYUSER) = the faculty user to be added
 *	$(YEAR3) = the current year
 *
 * Note: Requires MSSQL 2008 or higher 
 *
 */



--Delete Operations Can be Commented Out for Fresh Database

DELETE FROM external_faculty_course_roster WHERE faculty_school_id = '$(FACULTYUSER)';
DELETE FROM external_faculty_course WHERE faculty_school_id = '$(FACULTYUSER)';

--End of Deletes


--Load External Faculty and Course Data 


--Function to Assign Students To Faculty Courses for SSP Training

IF object_id('assignStudentsToFacultyCourse', 'p') IS NOT NULL
    exec ('DROP PROCEDURE assignStudentsToFacultyCourse');
GO

CREATE PROCEDURE assignStudentsToFacultyCourse @FACULTYSCHOOLID VARCHAR(50)
AS
     DECLARE @fallFormattedCourse VARCHAR(35);
     DECLARE @fallTermCode VARCHAR(25);
     DECLARE @fallSectionCode VARCHAR(128);
     DECLARE @fallSectionNumber VARCHAR(10);
     DECLARE @springTermCode VARCHAR(25);
     DECLARE @springFormattedCourse VARCHAR(35);
     DECLARE @springSectionCode VARCHAR(128);
     DECLARE @springSectionNumber VARCHAR(10);

     SELECT 
        @fallFormattedCourse = formatted_course, 
        @fallTermCode = term_code,
        @fallSectionCode = section_code,
        @fallSectionNumber = section_number
     FROM external_faculty_course WHERE term_code = (SELECT TOP 1 code FROM external_term WHERE name = 'Fall $(YEAR3)') AND faculty_school_id = @FACULTYSCHOOLID;

     SELECT 
        @springFormattedCourse = formatted_course, 
        @springTermCode = term_code,
        @springSectionCode = section_code,
        @springSectionNumber = section_number 
     FROM external_faculty_course WHERE term_code = (SELECT TOP 1 code FROM external_term WHERE name = 'Spring $(YEAR3)') AND faculty_school_id = @FACULTYSCHOOLID;

     UPDATE external_faculty_course SET title = (SELECT TOP 1 title FROM external_course WHERE formatted_course = @fallFormattedCourse) WHERE term_code = @fallTermCode AND faculty_school_id = @FACULTYSCHOOLID;

     UPDATE external_faculty_course SET title = (SELECT TOP 1 title FROM external_course WHERE formatted_course = @springFormattedCourse) WHERE term_code = @springTermCode AND faculty_school_id = @FACULTYSCHOOLID;    
    
 				
     INSERT INTO external_faculty_course_roster(faculty_school_id, school_id, first_name, middle_name, last_name, primary_email_address, term_code, formatted_course, status_code, section_code, section_number)
     SELECT TOP 10 @FACULTYSCHOOLID, school_id, first_name, middle_name, last_name, primary_email_address, @fallTermCode, @fallFormattedCourse, 'E', @fallSectionCode, @fallSectionNumber
     FROM person WHERE student_type_id IS NOT NULL ORDER BY NEWID();

	
     INSERT INTO external_faculty_course_roster(faculty_school_id, school_id, first_name, middle_name, last_name, primary_email_address, term_code, formatted_course, status_code, section_code, section_number) 
     SELECT TOP 10 @FACULTYSCHOOLID, school_id, first_name, middle_name, last_name, primary_email_address, @springTermCode, @springFormattedCourse, 'E', @springSectionCode, @springSectionNumber
     FROM person WHERE student_type_id IS NOT NULL ORDER BY NEWID();

GO

--End Function



INSERT INTO external_faculty_course(faculty_school_id, term_code, formatted_course, title, section_code, section_number)
VALUES ('$(FACULTYUSER)', (SELECT TOP 1 code FROM external_term WHERE name = 'Fall $(YEAR3)'), (SELECT TOP 1 formatted_course FROM
	 external_course ORDER BY NEWID()), 'x', (SELECT NEWID()), (SELECT RIGHT(REPLICATE('0',8) + CONVERT(VARCHAR(100),CAST(RAND(CAST(NEWID() AS VARBINARY(128))) * 100000000 AS INT)),8)));
GO

INSERT INTO external_faculty_course(faculty_school_id, term_code, formatted_course, title, section_code, section_number)
VALUES ('$(FACULTYUSER)', (SELECT TOP 1 code FROM external_term WHERE name = 'Spring $(YEAR3)'), (SELECT TOP 1 formatted_course FROM external_course ORDER BY NEWID()), 'x', (SELECT NEWID()), (SELECT RIGHT(REPLICATE('0',8) + CONVERT(VARCHAR(100),CAST(RAND(CAST(NEWID() AS VARBINARY(128))) * 100000000 AS INT)),8)));

GO

EXEC assignStudentsToFacultyCourse @FACULTYSCHOOLID="$(FACULTYUSER)";


GO

--***END OF SQL SCRIPT***

