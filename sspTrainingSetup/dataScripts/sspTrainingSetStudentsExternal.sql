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
 *	NEWSTUDENT1 = usernname of the New Student Use Case
 *	NEWSTUDENTFIRSTNAME = first name of New Student Use Case
 *	NEWSTUDENTMIDDLENAME = middle name of New Student Use Case
 *	NEWSTUDENTLASTNAME = last name of New Student Use Case
 *
 *	PROGRESSINGSTUDENT2 = usernname of the Progressing Student Use Case
 *	PROGRESSINGSTUDENTFIRSTNAME = first name of Progressing Student Use Case
 *	PROGRESSINGSTUDENTMIDDLENAME = middle name of Progressing Student Use Case
 *	PROGRESSINGSTUDENTLASTNAME = last name of Progressing Student Use Case
 *	
 *	STRUGGLINGSTUDENT3 = username of the Struggling Student Use Case3
 *	STRUGGLINGSTUDENTFIRSTNAME = first name of Struggling Student Use Case
 *	STRUGGLINGSTUDENTMIDDLENAME = middle name of Struggling Student Use Case
 *	STRUGGLINGSTUDENTLASTNAME = last name of Struggling Student Use Case *
 *	
 *	COACHASSIGNED = username for assigned coach
 *
 *	TASKID# = id (primary key) for task (There are 3 so TASKID1 ...) Needs to be random and unique.      
 *	YEAR# = the year(s) to use in the script (There are 3 and YEAR3 usually is equal to the current year).
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

DELETE FROM external_faculty_course_roster WHERE school_id = 'NEWSTUDENT1';
DELETE FROM external_person WHERE school_id = 'NEWSTUDENT1';
DELETE FROM external_person_note WHERE school_id = 'NEWSTUDENT1';
DELETE FROM external_person_planning_status WHERE school_id = 'NEWSTUDENT1';
DELETE FROM external_registration_status_by_term WHERE school_id = 'NEWSTUDENT1';
DELETE FROM external_student_academic_program WHERE school_id = 'NEWSTUDENT1';
DELETE FROM external_student_financial_aid WHERE school_id = 'NEWSTUDENT1';
DELETE FROM external_student_test WHERE school_id = 'NEWSTUDENT1';
DELETE FROM external_student_transcript WHERE school_id = 'NEWSTUDENT1';
DELETE FROM external_student_transcript_course WHERE school_id = 'NEWSTUDENT1';
DELETE FROM external_student_transcript_term  WHERE school_id = 'NEWSTUDENT1';

DELETE FROM external_faculty_course_roster WHERE school_id = 'PROGRESSINGSTUDENT2';
DELETE FROM external_person WHERE school_id = 'PROGRESSINGSTUDENT2';
DELETE FROM external_person_note WHERE school_id = 'PROGRESSINGSTUDENT2';
DELETE FROM external_person_planning_status WHERE school_id = 'PROGRESSINGSTUDENT2';
DELETE FROM external_registration_status_by_term WHERE school_id = 'PROGRESSINGSTUDENT2';
DELETE FROM external_student_academic_program WHERE school_id = 'PROGRESSINGSTUDENT2';
DELETE FROM external_student_financial_aid WHERE school_id = 'PROGRESSINGSTUDENT2';
DELETE FROM external_student_test WHERE school_id = 'PROGRESSINGSTUDENT2';
DELETE FROM external_student_transcript WHERE school_id = 'PROGRESSINGSTUDENT2';
DELETE FROM external_student_transcript_course WHERE school_id = 'PROGRESSINGSTUDENT2';
DELETE FROM external_student_transcript_term  WHERE school_id = 'PROGRESSINGSTUDENT2';


DELETE FROM external_faculty_course_roster WHERE school_id = 'STRUGGLINGSTUDENT3';
DELETE FROM external_person WHERE school_id = 'STRUGGLINGSTUDENT3';
DELETE FROM external_person_note WHERE school_id = 'STRUGGLINGSTUDENT3';
DELETE FROM external_person_planning_status WHERE school_id = 'STRUGGLINGSTUDENT3';
DELETE FROM external_registration_status_by_term WHERE school_id = 'STRUGGLINGSTUDENT3';
DELETE FROM external_student_academic_program WHERE school_id = 'STRUGGLINGSTUDENT3';
DELETE FROM external_student_financial_aid WHERE school_id = 'STRUGGLINGSTUDENT3';
DELETE FROM external_student_test WHERE school_id = 'STRUGGLINGSTUDENT3';
DELETE FROM external_student_transcript WHERE school_id = 'STRUGGLINGSTUDENT3';
DELETE FROM external_student_transcript_course WHERE school_id = 'STRUGGLINGSTUDENT3';
DELETE FROM external_student_transcript_term  WHERE school_id = 'STRUGGLINGSTUDENT3';
*/
--End of Deletes



--NEWSTUDENT1

INSERT INTO external_person(school_id, username, first_name, middle_name, last_name, birth_date, primary_email_address, address_line_1, address_line_2, city, state, zip_code, home_phone, work_phone, office_location, office_hours, department_name, actual_start_term, actual_start_year, marital_status, ethnicity, gender, is_local, balance_owed, coach_school_id, cell_phone, photo_url, residency_county, f1_status, non_local_address, student_type_code, race_code)
VALUES ('NEWSTUDENT1', 'NEWSTUDENT1', 'NEWSTUDENTFIRSTNAME', 'NEWSTUDENTMIDDLENAME', 'NEWSTUDENTLASTNAME', '1983-08-20','demo@trainingssp.com', '123 N. Demo St.', 'Apt. 555', 'Phoenix', 'AZ', '55555', '(555) 555-5555', '', '', '', '', 'SPYEAR3', 'YEAR3', 'Single', 'Caucasian/White', 'M', 't', 0.00, 'COACHASSIGNED', '', NULL, 'DemoCounty', 'Y', 'N', 'FTIC', '');         


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name,
            test_date, score, status)
VALUES ('NEWSTUDENT1', 'Scholastic Assessment Test','SAT', 'COMP', 'COMP', 'YEAR2-04-11', '1698.00', 'Accepted');


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status)
VALUES ('NEWSTUDENT1', 'American College Testing','ACT', 'COMP', 'COMP', 'YEAR2-04-15', '25', 'Accepted');


INSERT INTO external_student_academic_program(school_id, degree_code, degree_name, program_code, program_name, 
            intended_program_at_admit)
VALUES ('NEWSTUDENT1', 'ASC', '', '', '', '');


INSERT INTO external_student_financial_aid(school_id, financial_aid_gpa, gpa_20_b_hrs_needed, gpa_20_a_hrs_needed, 
            needed_for_67ptc_completion, current_year_financial_aid_award, 
            sap_status, fafsa_date, financial_aid_remaining, original_loan_amount, remaining_loan_amount)
VALUES ('NEWSTUDENT1', 2.44, 6.00, 6.00, 12.00, 'Y', 'Y', 'YEAR3-08-24', 53.00, 3850.00, 3797.00);


INSERT INTO external_student_transcript(school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            total_quality_points, grade_point_average, academic_standing, credit_hours_not_completed, credit_completion_rate, 		    gpa_trend_indicator, current_restrictions)
VALUES ('NEWSTUDENT1', 9.00, 9.00, 9.00, 70.00, 2.10, 'Good', 1.00, 100.00, 'New', '');


INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('NEWSTUDENT1', 'FAYEAR3', 5, 'Y');


INSERT INTO external_person_planning_status(
            school_id, status, status_reason)
    VALUES ('NEWSTUDENT1', 'ON', 'On plan.');


INSERT INTO external_student_transcript_term(
	    school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
	    credit_hours_not_completed, credit_completion_rate, total_quality_points, 
	    grade_point_average, term_code)
    VALUES ('NEWSTUDENT1',9.00,9.00,0.00,9.00,9.00,2.00,2.10,'SPYEAR3');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, "number", formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id)
     VALUES ('NEWSTUDENT1', 'MAT', '085', 'MAT085', '801', 'Introductory Algebra', 'Preparation for college algebra',
	    'B', 3, 'SPYEAR3', 'Transfer', 'NEWSTUDENTFIRSTNAME', 'NEWSTUDENTMIDDLENAME', 
	    'NEWSTUDENTLASTNAME', 'N', 'E', 'MAT085-801', 'rjones210');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, "number", formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id)
     VALUES ('NEWSTUDENT1', 'ENG', '101', 'ENG101', '694', 'English Composition I', 'Introduction to college english',
	    'C+', 3, 'SPYEAR3', 'Transfer', 'NEWSTUDENTFIRSTNAME', 'NEWSTUDENTMIDDLENAME', 
	    'NEWSTUDENTLASTNAME', 'N', 'E', 'ENG101-694', 'jmartinez110');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, "number", formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id)
     VALUES ('NEWSTUDENT1', 'CST', '101', 'CST101', '541', 'Introduction to Computing I', 'Introduction to the fundamentals of computing',
	    'D', 3, 'SPYEAR3', 'Transfer', 'NEWSTUDENTFIRSTNAME', 'NEWSTUDENTMIDDLENAME', 
	    'NEWSTUDENTLASTNAME', 'N', 'E', 'CST101-541', 'dwilson220');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('NEWSTUDENT1', 'CST', '102', 'CST102', '645', 'Programming Fundamentals II', 'Programming Fundamentals II',
            '', 3, 'FAYEAR3', 'Institutional', 'NEWSTUDENTFIRSTNAME', 'NEWSTUDENTMIDDLENAME', 
            'NEWSTUDENTLASTNAME', 'N', 'E', 'CST102-645', 'etaylor310');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('NEWSTUDENT1', 'ENG', '102', 'ENG102', '203', 'English Composition II', 'English Composition II',
            '', 3, 'FAYEAR3', 'Institutional', 'NEWSTUDENTFIRSTNAME', 'NEWSTUDENTMIDDLENAME', 
            'NEWSTUDENTLASTNAME', 'N', 'E', 'ENG102-203', 'dmartinez340');



INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('NEWSTUDENT1', 'HST', '133', 'HST133', '106', 'General History', 'General History',
            '', 3, 'FAYEAR3', 'Institutional', 'NEWSTUDENTFIRSTNAME', 'NEWSTUDENTMIDDLENAME', 
            'NEWSTUDENTLASTNAME', 'N', 'E', 'HST133-106', 'jwilliams510');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('NEWSTUDENT1', 'PHY', '131', 'PHY131', '932', 'General Physics', 'Introduction to physics',
            '', 3, 'FAYEAR3', 'Institutional', 'NEWSTUDENTFIRSTNAME', 'NEWSTUDENTMIDDLENAME', 
            'NEWSTUDENTLASTNAME', 'N', 'E', 'PHY131-932', 'dmartinez340');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('NEWSTUDENT1', 'MAT', '183', 'MAT183', '200', 'Advanced Mathematics', 'Advanced Mathematics',
            '', 3, 'FAYEAR3', 'Institutional', 'NEWSTUDENTFIRSTNAME', 'NEWSTUDENTMIDDLENAME', 
            'NEWSTUDENTLASTNAME', 'N', 'E', 'MAT183-200', 'jmartinez110');








--PROGRESSINGSTUDENT2


INSERT INTO external_person( school_id, username, first_name, middle_name, last_name, birth_date, 
            primary_email_address, address_line_1, address_line_2, city, 
            state, zip_code, home_phone, work_phone, office_location, office_hours, 
            department_name, actual_start_term, actual_start_year, marital_status, 
            ethnicity, gender, is_local, balance_owed, coach_school_id, cell_phone, 
            photo_url, residency_county, f1_status, non_local_address, student_type_code, race_code)
VALUES ('PROGRESSINGSTUDENT2', 'PROGRESSINGSTUDENT2', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 'PROGRESSINGSTUDENTLASTNAME', '1988-01-04', 'demo@trainingssp.com', '312 N. Demo St.', 'Apt. 012', 'Phoenix', 'AZ', '55555', '(555) 555-5423', '', '', '', '', 'FAYEAR1', 'YEAR1', 'Separated', 'Caucasian/White', 'F', 't', 0.00, 'COACHASSIGNED', '', NULL,'DemoCounty','Y','N','RET','');


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status)
VALUES ('PROGRESSINGSTUDENT2', 'Scholastic Assessment Test','SAT', 'COMP', 'COMP', 'YEAR1-01-01', '1948.00', 'Accepted');


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status)
VALUES ('PROGRESSINGSTUDENT2', 'American College Testing','ACT', 'COMP', 'COMP', 'YEAR1-01-28', '27', 'Accepted');


INSERT INTO external_student_academic_program(school_id, degree_code, degree_name, program_code, program_name, 
            intended_program_at_admit)
VALUES ('PROGRESSINGSTUDENT2', 'ASC', 'Applied Computing', 'CST-AS', 'Associates of Science in Computing', 'Associates of Science in Computing');


INSERT INTO external_student_financial_aid(school_id, financial_aid_gpa, gpa_20_b_hrs_needed, gpa_20_a_hrs_needed, 
            needed_for_67ptc_completion, current_year_financial_aid_award, 
            sap_status, fafsa_date, financial_aid_remaining, original_loan_amount, remaining_loan_amount)
VALUES ('PROGRESSINGSTUDENT2', 3.20, 9.00, 6.00, 3.00, 'Y', 'Y', 'YEAR3-08-24', 118.00, 5150.00, 5032.00);


INSERT INTO external_student_transcript(school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            total_quality_points, grade_point_average, academic_standing, credit_hours_not_completed, credit_completion_rate, 		    gpa_trend_indicator, current_restrictions)
VALUES ('PROGRESSINGSTUDENT2', 63.00, 63.00, 63.00, 131.00, 3.64, 'Good', 1.00, 100.00, 'Progressing', '');


INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('PROGRESSINGSTUDENT2', 'FAYEAR1', 6, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('PROGRESSINGSTUDENT2', 'SPYEAR2', 5, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('PROGRESSINGSTUDENT2', 'FAYEAR2', 5, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('PROGRESSINGSTUDENT2', 'SPYEAR3', 5, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('PROGRESSINGSTUDENT2', 'FAYEAR3', 5, 'Y');



INSERT INTO external_person_planning_status(
            school_id, status, status_reason)
    VALUES ('PROGRESSINGSTUDENT2', 'ON', 'Is doing well and on plan.');


INSERT INTO external_person_note(
            code, school_id, note_type, author, department, date_note_taken, 
            note)
    VALUES ('TASKID1', 'PROGRESSINGSTUDENT2', 'Legacy', 'Previous Advisor','Advising', 'YEAR2-05-03', 
            'PROGRESSINGSTUDENTFIRSTNAME is doing really well. Applying for Pell and OCOG grants.');

INSERT INTO external_person_note(
            code, school_id, note_type, author, department, date_note_taken, 
            note)
    VALUES ('TASKID2', 'PROGRESSINGSTUDENT2', 'Legacy', 'Previous Advisor','Advising', 'YEAR2-09-13', 
            'PROGRESSINGSTUDENTFIRSTNAME wishes to change her major to Computer Science Associates degree.');



INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('PROGRESSINGSTUDENT2',18.00,18.00,18.00,0.00,18.00,40.00,3.50,'FAYEAR1');

INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('PROGRESSINGSTUDENT2',15.00,15.00,15.00,0.00,15.00,90.00,3.60,'SPYEAR2');


INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('PROGRESSINGSTUDENT2',15.00,15.00,15.00,0.00,15.00,90.00,3.67,'FAYEAR2');



INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('PROGRESSINGSTUDENT2',15.00,15.00,15.00,0.00,15.00,90.00,3.74,'SPYEAR3');




INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'PSY', '101', 'PSY101', '213', 'Introduction to Psychology', 'Introduction to Psychology',
            'B', 3, 'FAYEAR1', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'PSY101-213', 'dmartinez340');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'MAT', '106', 'MAT106', '145', 'Applied Mathematics', 'Applied Mathematics',
            'A-', 3, 'FAYEAR1', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'CST102-645', 'etaylor310');



INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'SCL', '101', 'SCL101', '123', 'Introduction to Sociology', 'Introduction to Sociology',
            'A', 3, 'FAYEAR1', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'SCL101-123', 'rjones330');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'CRIJ', '130', 'CRIJ130', '211', 'Introduction to Criminal Justice', 'Introduction to Criminal Justice',
            'A', 4.00, 'FAYEAR1', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'CRIJ130-211', 'jmartinez110');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'ENG', '101', 'ENG101', '325', 'English Composition I', 'Introduction to college english',
            'B+', 3.00, 'FAYEAR1', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'ENG101-325', 'rjones210');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'CRIJ', '131', 'CRIJ131', '390', 'Fundamentals of Criminal Law', 'Introduction to the fundamentals of Criminal Law',
            'B', 3.00, 'FAYEAR1', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'CRIJ131-390', 'dwilson220');



INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'ENG', '102', 'ENG102', '119', 'English Composition II', 'English Composition II',
            'A-', 3, 'SPYEAR2', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'ENG102-119', 'dmartinez340');



INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'LIT', '111', 'LIT111', '304', 'Basics of Literature', 'Basics of Literature',
            'B', 3, 'SPYEAR2', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'LIT111-304', 'rjones330');



INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'CRIJ', '133', 'CRIJ133', '120', 'Juvenile Justice System', 'Study of the Juvenile Justice System',
            'B+', 3, 'SPYEAR2', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'CRIJ133-120', 'jwilliams510');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'CRIJ', '134', 'CRIJ134', '130', 'Ethics in Criminal Justice', 'Introduction to ethics in the criminal justice system',
            'A-', 3, 'SPYEAR2', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'CRIJ134-130', 'dmartinez340');



INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'MAT', '183', 'MAT183', '206', 'Advanced Mathematics', 'Advanced Mathematics',
            'A', 3, 'SPYEAR2', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'MAT183-206', 'jmartinez110');






INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'CST', '101', 'CST101', '120', 'Programming Fundamentals I', 'Programming Fundamentals I',
            'A+', 3, 'FAYEAR2', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'CST101-120', 'etaylor310');




INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'CST', '105', 'CST105', '304', 'Introduction to Computing I', 'Computers Intro',
            'A-', 3, 'FAYEAR2', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'CST105-304', 'rjones330');



INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'MIC', '134', 'MIC134', '430', 'Foundational Microbiology', 'Introduction to microbiology',
            'B+', 3, 'FAYEAR2', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'MIC134-430', 'dmartinez340');



INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'PHL', '106', 'PHL106', '420', 'Advanced Philosophy', 'Study of Philosophy',
            'B', 3, 'FAYEAR2', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'PHL106-420', 'jwilliams510');



INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'MAT', '219', 'MAT219', '960', 'Applied Mathematics', 'Applied Mathematics',
            'A', 3, 'FAYEAR2', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'MAT219-960', 'dmartinez340');






INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'CST', '102', 'CST102', '012', 'Programming Fundamentals II', 'Programming Fundamentals II',
            'A-', 3, 'SPYEAR3', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'CST102-012', 'dmartinez340');




INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'CST', '135', 'CST135', '005', 'Fundamentals of Networking', 'Fundamentals of Networking',
            'A', 3, 'SPYEAR3', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'CST135-005', 'rjones330');



INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'LIT', '155', 'LIT155', '090', 'Advanced Literature', 'Study of Short Stories and Literature',
            'B+', 3, 'SPYEAR3', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'LIT155-090', 'jwilliams510');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'MAT', '251', 'MAT251', '116', 'Creative Mathematics', 'Creative Mathematics',
            'A', 3, 'SPYEAR3', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'MAT251-116', 'jmartinez110');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'CST', '262', 'CST262', '240', 'UNIX Operating System', 'Introduction to the UNIX/LINUX operating system',
            'A-', 3, 'SPYEAR3', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'CST262-240', 'dmartinez340');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'CST', '230', 'CST230', '320', 'Object Orientated Programming', 'OO Programming with GUI design',
            '', 3, 'FAYEAR3', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'CST230-230', 'dmartinez340');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'CST', '245', 'CST245', '189', 'System Analysis and Design', 'System Analysis and Design',
            '', 3, 'FAYEAR3', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'CST245-189', 'rjones330');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'PHY', '215', 'PHY215', '485', 'College level Physics', 'College Physics',
            '', 3, 'FAYEAR3', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'PHY215-485', 'etaylor310');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'HST', '210', 'HST210', '287', 'Survey History', 'Survey of History',
            '', 3, 'FAYEAR3', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'HST210-287', 'jwilliams510');



INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('PROGRESSINGSTUDENT2', 'MAT', '324', 'MAT324', '112', 'Quantitative Mathematics', 'Quantitative Mathematics',
            '', 3, 'FAYEAR3', 'Institutional', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 
            'PROGRESSINGSTUDENTLASTNAME', 'N', 'E', 'MAT324-112', 'jmartinez110');









--STRUGGLINGSTUDENT3

INSERT INTO external_person( school_id, username, first_name, middle_name, last_name, birth_date, 
            primary_email_address, address_line_1, address_line_2, city, 
            state, zip_code, home_phone, work_phone, office_location, office_hours, 
            department_name, actual_start_term, actual_start_year, marital_status, 
            ethnicity, gender, is_local, balance_owed, coach_school_id, cell_phone, 
            photo_url, residency_county, f1_status, non_local_address, student_type_code, race_code)
VALUES ('STRUGGLINGSTUDENT3', 'STRUGGLINGSTUDENT3', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 'STRUGGLINGSTUDENTLASTNAME', '1986-10-24', 'demo@trainingssp.com', '321 W. Demo St.', 'Apt. 214', 'Phoenix', 'AZ', '55555', '(555) 555-5412', '', '', '', '', 'FAYEAR1', 'YEAR1', 'Separated', 'Caucasian/White', 'M', 't', 0.00, 'COACHASSIGNED', '', NULL,'DemoCounty','Y','N','EAL','');


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status)
VALUES ('STRUGGLINGSTUDENT3', 'Scholastic Assessment Test','SAT', 'COMP', 'COMP', 'YEAR1-01-01', '1300.00', 'Accepted');


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status)
VALUES ('STRUGGLINGSTUDENT3', 'American College Testing','ACT', 'COMP', 'COMP', 'YEAR1-01-28', '18', 'Accepted');


INSERT INTO external_student_academic_program(school_id, degree_code, degree_name, program_code, program_name, 
            intended_program_at_admit)
VALUES ('STRUGGLINGSTUDENT3', 'AUMT', 'Automotive Technology', 'AUMT-AS', 'Associates of Science in Automotive Technology', 'Associates of Science in Automotive Technology');


INSERT INTO external_student_financial_aid(school_id, financial_aid_gpa, gpa_20_b_hrs_needed, gpa_20_a_hrs_needed, 
            needed_for_67ptc_completion, current_year_financial_aid_award, 
            sap_status, fafsa_date, financial_aid_remaining, original_loan_amount, remaining_loan_amount)
VALUES ('STRUGGLINGSTUDENT3', 1.82, 9.00, 9.00, 9.00, 'Y', 'N', 'YEAR3-08-24', 809.00, 6600.00, 5791.00);


INSERT INTO external_student_transcript(school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            total_quality_points, grade_point_average, academic_standing, credit_hours_not_completed, credit_completion_rate, 		    gpa_trend_indicator, current_restrictions)
VALUES ('STRUGGLINGSTUDENT3', 35.00, 31.00, 36.00, 85.00, 1.82, 'Probation', 5.00, 86.00, 'Down', '');


INSERT INTO external_person_planning_status(
            school_id, status, status_reason)
    VALUES ('STRUGGLINGSTUDENT3', 'OFF', 'Is not doing well, needs help.');


INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('STRUGGLINGSTUDENT3', 'FAYEAR1', 5, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('STRUGGLINGSTUDENT3', 'SPYEAR2', 5, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('STRUGGLINGSTUDENT3', 'FAYEAR2', 4, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('STRUGGLINGSTUDENT3', 'SPYEAR3', 3, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('STRUGGLINGSTUDENT3', 'FAYEAR3', 1, 'N');



INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('STRUGGLINGSTUDENT3',15.00,15.00,15.00,0.00,15.00,18.00,2.58,'FAYEAR1');

INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('STRUGGLINGSTUDENT3',12.00,12.00,15.00,3.00,12.00,10.00,2.15,'SPYEAR2');


INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('STRUGGLINGSTUDENT3',12.00,12.00,12.00,0.00,11.75,8.00,1.85,'FAYEAR2');



INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('STRUGGLINGSTUDENT3',6.00,6.00,9.00,3.00,0.80,0.00,0.77,'SPYEAR3');




INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'AUMT', '101', 'AUMT101', '056', 'Introduction to Speed Communication', 'Introduction to Speed Communication',
            'B', 2.00, 'FAYEAR1', 'Institutional', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'AUMT101-056', 'rjones210');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'ENG', '055', 'ENG055', '112', 'English Composition I', 'Preparation for College Composition',
            'C+', 2.00, 'FAYEAR1', 'Developmental', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'ENG055-112', 'dwilson220');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'MAT', '085', 'MAT085', '500', 'Introductory Algebra', 'Introduction to the fundamentals of Algebra',
            'B+', 1.00, 'FAYEAR1', 'Developmental', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'MAT085-500', 'jmartinez110');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'AUMT', '140', 'AUMT140', '139', 'Introduction to Automotive Technology', 'Introduction to Automotive Technology ',
            'C', 3, 'FAYEAR1', 'Institutional', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'AUMT140-113', 'rjones330');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'ENG', '075', 'ENG075', '125', 'College Writing I', 'College Writing I',
            'C+', 3, 'FAYEAR1', 'Developmental', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'ENG075-125', 'etaylor310');





INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'AUMT', '142', 'AUMT142', '133', 'Automotive Engine Repair', 'Introduction to Automotive Engine Repair',
            'C+', 3, 'SPYEAR2', 'Institutional', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'AUMT142-133', 'etaylor310');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'ENG', '076', 'ENG076', '100', 'College Writing II', 'College Writing II',
            'C', 3, 'SPYEAR2', 'Developmental', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'ENG076-100', 'dmartinez340');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'GEO', '104', 'GEO104', '143', 'Introduction to Geography', 'Study of Geography',
            'C', 3, 'SPYEAR2', 'Institutional', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'GEO104-143', 'jwilliams510');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'MAT', '086', 'MAT086', '168', 'Intermediate Algebra', 'Intermediate Algebra',
            'C', 3, 'SPYEAR2', 'Developmental', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'MAT086-168', 'jmartinez110');





INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'AUMT', '241', 'AUMT241', '450', 'Automotive Engine Performance Analysis',
	    'Introduction to Auto Performance',
            'C', 3, 'FAYEAR2', 'Institutional', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'AUMT241-450', 'dmartinez340');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'ENG', '055', 'ENG055', '095', 'College Reading I', 'College Reading I',
            'C-', 3, 'FAYEAR2', 'Developmental', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'ENG055-095', 'etaylor310');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'AUMT', '146', 'AUMT146', '133', 'Automotive Suspension and Steering', 
	    'Automotive Suspension and Steering',
            'C', 3, 'FAYEAR2', 'Institutional', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'AUMT146-133', 'rjones330');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'AUMT', '142', 'AUMT142', '133', 'Automotive Engine Repair', 
	    'Introduction to Automotive Engine Repair', 'C-', 3, 'FAYEAR2', 'Institutional', 'STRUGGLINGSTUDENTFIRSTNAME', 			'STRUGGLINGSTUDENTMIDDLENAME', 'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'AUMT142-133', 'etaylor310');




INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'AUMT', '244', 'AUMT244', '148', 'Engine Performance Analysis II', 'Study of engine performance part II',
            'F', 3, 'SPYEAR3', 'Institutional', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'AUMT244-148', 'jwilliams510');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'AUMT', '245', 'AUMT245', '140', 'Automotive Alternative Fuels', 'Introduction to Automotive Alternative Fuels',
            'D', 3, 'SPYEAR3', 'Institutional', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'AUMT245-140', 'rjones330');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'ENG', '076', 'ENG076', '225', 'College Writing II', 'College Writing II',
            'D+', 3, 'SPYEAR3', 'Developmental', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'ENG076-225', 'etaylor310');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'ENG', '076', 'ENG076', '100', 'College Writing II', 'College Writing II',
            '', 3, 'FAYEAR3', 'Developmental', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'ENG076-100', 'dmartinez340');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, "number", formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id)
     VALUES ('STRUGGLINGSTUDENT3', 'AUMT', '246', 'AUMT246', '190', 'Automotive Drive Train and Axles', 'Introduction to Automotive Drive Train and Axles',
            '', 3, 'FAYEAR3', 'Institutional', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 
            'STRUGGLINGSTUDENTLASTNAME', 'N', 'E', 'AUMT246-190', 'etaylor310');





--External Course Data 
/*
INSERT INTO external_faculty_course(faculty_school_id, term_code, formatted_course, title, section_code,
		section_number)
VALUES ('COACHASSIGNED', (SELECT code FROM external_term WHERE name = 'Fall YEAR3' LIMIT 1), (SELECT formatted_course FROM
	 external_course ORDER BY random() LIMIT 1), 'x', (SELECT generateUUID()), (SELECT trunc(random() * 999 + 1)));

INSERT INTO external_faculty_course_roster(faculty_school_id, school_id, first_name, middle_name, last_name, 
            primary_email_address, term_code, formatted_course, status_code, section_code, section_number)
    VALUES ('COACHASSIGNED', 'NEWSTUDENT1', 'NEWSTUDENTFIRSTNAME', 'NEWSTUDENTMIDDLENAME', 'NEWSTUDENTLASTNAME', 
            (SELECT primary_email_address FROM external_person WHERE school_id = 'NEWSTUDENT1'), (SELECT code FROM external_term WHERE name = 'Fall YEAR3' LIMIT 1), (SELECT formatted_course FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED' LIMIT 1), 'E', (SELECT section_code FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED' LIMIT 1), (SELECT section_number FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED' LIMIT 1));


INSERT INTO external_faculty_course_roster(faculty_school_id, school_id, first_name, middle_name, last_name, 
            primary_email_address, term_code, formatted_course, status_code, section_code, section_number)
    VALUES ('COACHASSIGNED', 'PROGRESSINGSTUDENT2', 'PROGRESSINGSTUDENTFIRSTNAME', 'PROGRESSINGSTUDENTMIDDLENAME', 'PROGRESSINGSTUDENTLASTNAME', 
            (SELECT primary_email_address FROM external_person WHERE school_id = 'PROGRESSINGSTUDENT2'), (SELECT code FROM external_term WHERE name = 'Fall YEAR3' LIMIT 1), (SELECT formatted_course FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED' LIMIT 1), 'E', (SELECT section_code FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED' LIMIT 1), (SELECT section_number FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED'LIMIT 1));


INSERT INTO external_faculty_course_roster(faculty_school_id, school_id, first_name, middle_name, last_name, 
            primary_email_address, term_code, formatted_course, status_code, section_code, section_number)
    VALUES ('COACHASSIGNED', 'STRUGGLINGSTUDENT3', 'STRUGGLINGSTUDENTFIRSTNAME', 'STRUGGLINGSTUDENTMIDDLENAME', 'NEWSTUDENTLASTNAME', 
            (SELECT primary_email_address FROM external_person WHERE school_id = 'STRUGGLINGSTUDENT3'), (SELECT code FROM external_term WHERE name = 'Fall YEAR3' LIMIT 1), (SELECT formatted_course FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED' LIMIT 1), 'E', (SELECT section_code FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED' LIMIT 1), (SELECT section_number FROM external_faculty_course WHERE faculty_school_id = 'COACHASSIGNED'LIMIT 1));
*/


--***END OF SQL SCRIPT***

