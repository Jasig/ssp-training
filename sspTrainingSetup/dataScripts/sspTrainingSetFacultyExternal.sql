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


/*
 * *** SSP TRAINING SET FACULTY USER EXTERNAL DATA FOR EARLY ALERT ***
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
 *      FACULTYUSER = the faculty user to be added
 *	YEAR3 = the current year
 *
 * Note: Requires Postgres 8.X or higher 
 *
 */


--Function to Create Approximately Randmo Pseudo UUID's 

CREATE OR REPLACE FUNCTION generateUUID() RETURNS uuid AS $BODY$

SELECT CAST( md5(current_database() || user || current_timestamp || random()) as uuid )

$BODY$ LANGUAGE 'sql' VOLATILE;

--End function



--Delete Operations Can be Commented Out for Fresh Database

DELETE FROM external_faculty_course_roster WHERE faculty_school_id = 'FACULTYUSER';
DELETE FROM external_faculty_course WHERE faculty_school_id = 'FACULTYUSER';

--End of Deletes


--Load External Faculty and Course Data 


--Function to Assign Students To Faculty Courses for SSP Training

CREATE OR REPLACE FUNCTION assignStudentsToFacultyCourse (text) RETURNS void AS $$

DECLARE   
  studentRecordRoster1 RECORD; 
  studentRecordRoster2 RECORD;
  facultyCourseRecordFall RECORD;
  facultyCourseRecordSpring RECORD;

BEGIN

 SELECT * INTO facultyCourseRecordFall FROM external_faculty_course WHERE term_code = (SELECT code FROM external_term WHERE name = 'Fall YEAR3' LIMIT 1) AND faculty_school_id = $1;

 SELECT * INTO facultyCourseRecordSpring FROM external_faculty_course WHERE term_code = (SELECT code FROM external_term WHERE name = 'Spring YEAR3' LIMIT 1) AND faculty_school_id = $1;

 UPDATE external_faculty_course SET title = (SELECT title FROM external_course WHERE formatted_course = facultyCourseRecordFall.formatted_course LIMIT 1) WHERE term_code = facultyCourseRecordFall.term_code AND faculty_school_id = $1;

 UPDATE external_faculty_course SET title = (SELECT title FROM external_course WHERE formatted_course = facultyCourseRecordSpring.formatted_course LIMIT 1) WHERE term_code = facultyCourseRecordSpring.term_code AND faculty_school_id = $1;

 FOR studentRecordRoster1 IN (SELECT * FROM person WHERE student_type_id IS NOT NULL ORDER BY RANDOM() LIMIT 10) LOOP
 				
	INSERT INTO external_faculty_course_roster(faculty_school_id, school_id, first_name, middle_name, last_name, 
		    primary_email_address, term_code, formatted_course, status_code, section_code, section_number)
	    VALUES ($1, studentRecordRoster1.school_id, studentRecordRoster1.first_name, studentRecordRoster1.middle_name, studentRecordRoster1.last_name, studentRecordRoster1.primary_email_address, facultyCourseRecordFall.term_code, facultyCourseRecordFall.formatted_course, 'E', facultyCourseRecordFall.section_code, facultyCourseRecordFall.section_number);

 END LOOP;

 FOR studentRecordRoster2 IN (SELECT * FROM person WHERE student_type_id IS NOT NULL ORDER BY RANDOM() LIMIT 10) LOOP
 				
	INSERT INTO external_faculty_course_roster(faculty_school_id, school_id, first_name, middle_name, last_name, 
		    primary_email_address, term_code, formatted_course, status_code, section_code, section_number)
	    VALUES ($1, studentRecordRoster2.school_id, studentRecordRoster2.first_name, studentRecordRoster2.middle_name, studentRecordRoster2.last_name, studentRecordRoster2.primary_email_address, facultyCourseRecordSpring.term_code, facultyCourseRecordSpring.formatted_course, 'E', facultyCourseRecordSpring.section_code, facultyCourseRecordSpring.section_number);

 END LOOP;

END;

$$ LANGUAGE plpgsql;

-- End Function



INSERT INTO external_faculty_course(faculty_school_id, term_code, formatted_course, title, section_code,
		section_number)
VALUES ('FACULTYUSER', (SELECT code FROM external_term WHERE name = 'Fall YEAR3' LIMIT 1), (SELECT formatted_course FROM
	 external_course ORDER BY random() LIMIT 1), 'x', (SELECT generateUUID()), (SELECT trunc(random() * 999 + 1)));

INSERT INTO external_faculty_course(faculty_school_id, term_code, formatted_course, title, section_code,
		section_number)
VALUES ('FACULTYUSER', (SELECT code FROM external_term WHERE name = 'Spring YEAR3' LIMIT 1), (SELECT formatted_course FROM
	 external_course ORDER BY random() LIMIT 1), 'x', (SELECT generateUUID()), (SELECT trunc(random() * 999 + 1)));

SELECT assignStudentsToFacultyCourse('FACULTYUSER');

--***END OF SQL SCRIPT***

