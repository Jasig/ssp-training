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
 * *** SSP TRAINING SET INDIVIDUAL USER EXTERNAL DATA FOR 3 USE CASE STUDENTS ***
 *
 * This SQL File sets 3 high quality use case students with external data that makes
 *  them useful for demonstrations, user training, and other scenarios. 
 *
 * The database must be setup with reference data and the basic SSP required table structure.
 * Furthermore, this must be run before any internal data script as it populates external data. The internal
 *  script can be ran afterwords to populate internal data.
 *
 * Also, there is a commented section at the end, when uncommented, this will setup the coach as a course
 *  instructor with the 3 students as assigned students. This may be used to setup an Early Alert demo process.
 *
 * Finally, below you will find a section with deletes. This is commented out by default, but it 
 *  can be used on a populated database to "refresh" the external data if that is desired.
 *
 * To use this file substitute the placeholders below via some other script
 *  or manually with the 3 names of the students you wish to reset. 
 *
 * Substitute: 
 *	EXTERNALSYNC1 = usernname of the New Student Use Case
 *	EXTERNALSYNCFIRSTNAME = first name of New Student Use Case
 *	EXTERNALSYNCMIDDLENAME = middle name of New Student Use Case
 *	EXTERNALSYNCLASTNAME = last name of New Student Use Case
 *
 *	COACHASSIGNED = username for assigned coach
 *
 *	YEAR# = the year(s) to use in the script (There are 2 and YEAR3 usually is equal to the current year).
 *		(YEAR3 and YEAR2 only are used!)		
 *
 * Note: Requires Postgres 8.X or higher 
 *
 */


--Function to Create Approximately Randmo Pseudo UUID's 

CREATE OR REPLACE FUNCTION generateUUID() RETURNS uuid AS $BODY$

SELECT CAST( md5(current_database() || user || current_timestamp || random()) as uuid )

$BODY$ LANGUAGE 'sql' VOLATILE;

--End functions



--Delete Operations Can be Commented Out for Fresh Database
/*
DELETE FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED';

DELETE FROM external_faculty_course_roster WHERE school_id = 'EXTERNALSYNC1';
DELETE FROM external_person WHERE school_id = 'EXTERNALSYNC1';
DELETE FROM external_person_note WHERE school_id = 'EXTERNALSYNC1';
DELETE FROM external_person_planning_status WHERE school_id = 'EXTERNALSYNC1';
DELETE FROM external_registration_status_by_term WHERE school_id = 'EXTERNALSYNC1';
DELETE FROM external_student_academic_program WHERE school_id = 'EXTERNALSYNC1';
DELETE FROM external_student_financial_aid WHERE school_id = 'EXTERNALSYNC1';
DELETE FROM external_student_test WHERE school_id = 'EXTERNALSYNC1';
DELETE FROM external_student_transcript WHERE school_id = 'EXTERNALSYNC1';
DELETE FROM external_student_transcript_course WHERE school_id = 'EXTERNALSYNC1';
DELETE FROM external_student_transcript_term  WHERE school_id = 'EXTERNALSYNC1';

*/
--End of Deletes



--EXTERNALSYNC1

INSERT INTO external_person(school_id, username, first_name, middle_name, last_name, birth_date, primary_email_address, address_line_1, address_line_2, city, state, zip_code, home_phone, work_phone, office_location, office_hours, department_name, actual_start_term, actual_start_year, marital_status, ethnicity, gender, is_local, balance_owed, coach_school_id, cell_phone, photo_url, residency_county, f1_status, non_local_address, student_type_code, race_code)
VALUES ('EXTERNALSYNC1', 'EXTERNALSYNC1', 'EXTERNALSYNCFIRSTNAME', 'EXTERNALSYNCMIDDLENAME', 'EXTERNALSYNCLASTNAME', '1983-08-20','demo@trainingssp.com', '458 N. Demo St.', 'Apt. 852', 'Phoenix', 'AZ', '55555', '(555) 555-5555', '', '', '', '', 'SPYEAR3', 'YEAR3', 'Single', 'Caucasian/White', 'M', 't', 0.00, 'COACHASSIGNED', '', NULL, 'DemoCounty', 'Y', 'N', 'FTIC', '');         


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name,
            test_date, score, status)
VALUES ('EXTERNALSYNC1', 'Scholastic Assessment Test','SAT', 'COMP', 'COMP', 'YEAR2-04-11', '1585.00', 'Accepted');


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status)
VALUES ('EXTERNALSYNC1', 'American College Testing','ACT', 'COMP', 'COMP', 'YEAR2-04-15', '23', 'Accepted');


INSERT INTO external_student_academic_program(school_id, degree_code, degree_name, program_code, program_name, 
            intended_program_at_admit)
VALUES ('EXTERNALSYNC1', 'ASC', '', '', '', '');


INSERT INTO external_student_financial_aid(school_id, financial_aid_gpa, gpa_20_b_hrs_needed, gpa_20_a_hrs_needed, 
            needed_for_67ptc_completion, current_year_financial_aid_award, 
            sap_status, fafsa_date, financial_aid_remaining, original_loan_amount, remaining_loan_amount)
VALUES ('EXTERNALSYNC1', 2.44, 6.00, 6.00, 12.00, 'Y', 'Y', 'YEAR3-08-24', 53.00, 4850.00, 2500.00);


INSERT INTO external_student_transcript(school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            total_quality_points, grade_point_average, academic_standing, credit_hours_not_completed, credit_completion_rate, 		    gpa_trend_indicator, current_restrictions)
VALUES ('EXTERNALSYNC1', 9.00, 9.00, 9.00, 70.00, 2.10, 'Good', 1.00, 100.00, 'New', '');


INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('EXTERNALSYNC1', 'FAYEAR3', 5, 'Y');


INSERT INTO external_person_planning_status(
            school_id, status, status_reason)
    VALUES ('EXTERNALSYNC1', 'ON', 'On plan.');


INSERT INTO external_student_transcript_term(
	    school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
	    credit_hours_not_completed, credit_completion_rate, total_quality_points, 
	    grade_point_average, term_code)
    VALUES ('EXTERNALSYNC1',9.00,9.00,0.00,9.00,9.00,2.00,2.10,'SPYEAR3');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, "number", formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id)
     VALUES ('EXTERNALSYNC1', 'MAT', '085', 'MAT085', '801', 'Introductory Algebra', 'Preparation for college algebra',
	    'B', 3, 'SPYEAR3', 'Transfer', 'EXTERNALSYNCFIRSTNAME', 'EXTERNALSYNCMIDDLENAME', 
	    'EXTERNALSYNCLASTNAME', 'N', 'E', 'MAT085-801', 'jmartinez110');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, "number", formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id)
     VALUES ('EXTERNALSYNC1', 'ENG', '101', 'ENG101', '694', 'English Composition I', 'Introduction to college english',
	    'C+', 3, 'SPYEAR3', 'Transfer', 'EXTERNALSYNCFIRSTNAME', 'EXTERNALSYNCMIDDLENAME', 
	    'EXTERNALSYNCLASTNAME', 'N', 'E', 'ENG101-694', 'rjones210');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, "number", formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id)
     VALUES ('EXTERNALSYNC1', 'CST', '101', 'CST101', '541', 'Introduction to Computing I', 'Introduction to the fundamentals of computing',
	    'D', 3, 'SPYEAR3', 'Transfer', 'EXTERNALSYNCFIRSTNAME', 'EXTERNALSYNCMIDDLENAME', 
	    'EXTERNALSYNCLASTNAME', 'N', 'E', 'CST101-541', 'dmartinez340');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('EXTERNALSYNC1', 'CST', '102', 'CST102', '645', 'Programming Fundamentals II', 'Programming Fundamentals II',
            '', 3, 'FAYEAR3', 'Institutional', 'EXTERNALSYNCFIRSTNAME', 'EXTERNALSYNCMIDDLENAME', 
            'EXTERNALSYNCLASTNAME', 'N', 'E', 'CST102-645', 'etaylor310');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('EXTERNALSYNC1', 'ENG', '102', 'ENG102', '203', 'English Composition II', 'English Composition II',
            '', 3, 'FAYEAR3', 'Institutional', 'EXTERNALSYNCFIRSTNAME', 'EXTERNALSYNCMIDDLENAME', 
            'EXTERNALSYNCLASTNAME', 'N', 'E', 'ENG102-203', 'dwilson220');



INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('EXTERNALSYNC1', 'HST', '133', 'HST133', '106', 'General History', 'General History',
            '', 3, 'FAYEAR3', 'Institutional', 'EXTERNALSYNCFIRSTNAME', 'EXTERNALSYNCMIDDLENAME', 
            'EXTERNALSYNCLASTNAME', 'N', 'E', 'HST133-106', 'jwilliams510');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('EXTERNALSYNC1', 'PHY', '131', 'PHY131', '932', 'General Physics', 'Introduction to physics',
            '', 3, 'FAYEAR3', 'Institutional', 'EXTERNALSYNCFIRSTNAME', 'EXTERNALSYNCMIDDLENAME', 
            'EXTERNALSYNCLASTNAME', 'N', 'E', 'PHY131-932', 'dmartinez340');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('EXTERNALSYNC1', 'MAT', '183', 'MAT183', '200', 'Advanced Mathematics', 'Advanced Mathematics',
            '', 3, 'FAYEAR3', 'Institutional', 'EXTERNALSYNCFIRSTNAME', 'EXTERNALSYNCMIDDLENAME', 
            'EXTERNALSYNCLASTNAME', 'N', 'E', 'MAT183-200', 'jmartinez110');






--External Course Data 
/*
INSERT INTO external_faculty_course(faculty_school_id, term_code, formatted_course, title, section_code,
		section_number)
VALUES ('COACHASSIGNED', (SELECT code FROM external_term WHERE name = 'Fall YEAR3' LIMIT 1), (SELECT formatted_course FROM
	 external_course ORDER BY random() LIMIT 1), 'x', (SELECT generateUUID()), (SELECT trunc(random() * 999 + 1)));

INSERT INTO external_faculty_course_roster(faculty_school_id, school_id, first_name, middle_name, last_name, 
            primary_email_address, term_code, formatted_course, status_code, section_code, section_number)
    VALUES ('COACHASSIGNED', 'EXTERNALSYNC1', 'EXTERNALSYNCFIRSTNAME', 'EXTERNALSYNCMIDDLENAME', 'EXTERNALSYNCLASTNAME', 
            (SELECT primary_email_address FROM external_person WHERE school_id = 'EXTERNALSYNC1'), (SELECT code FROM external_term WHERE name = 'Fall YEAR3' LIMIT 1), (SELECT formatted_course FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED' LIMIT 1), 'E', (SELECT section_code FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED' LIMIT 1), (SELECT section_number FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED' LIMIT 1));

*/


--***END OF SQL SCRIPT***

