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
 * *** SSP TRAINING SET INDIVIDUAL USER EXTERNAL DATA FOR 3 USE CASE STUDENTS MSSQL Version***
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
 *	$(NEWSTUDENT1) = usernname of the New Student Use Case
 *	$(NEWSTUDENTFIRSTNAME) = first name of New Student Use Case
 *	$(NEWSTUDENTMIDDLENAME) = middle name of New Student Use Case
 *	$(NEWSTUDENTLASTNAME) = last name of New Student Use Case
 *
 *	$(PROGRESSINGSTUDENT2) = usernname of the Progressing Student Use Case
 *	$(PROGRESSINGSTUDENTFIRSTNAME) = first name of Progressing Student Use Case
 *	$(PROGRESSINGSTUDENTMIDDLENAME) = middle name of Progressing Student Use Case
 *	$(PROGRESSINGSTUDENTLASTNAME) = last name of Progressing Student Use Case
 *	
 *	$(STRUGGLINGSTUDENT3) = username of the Struggling Student Use Case3
 *	$(STRUGGLINGSTUDENTFIRSTNAME) = first name of Struggling Student Use Case
 *	$(STRUGGLINGSTUDENTMIDDLENAME) = middle name of Struggling Student Use Case
 *	$(STRUGGLINGSTUDENTLASTNAME) = last name of Struggling Student Use Case *
 *	
 *	$(COACHASSIGNED) = username for assigned coach
 *
 *	TASKID# = id (primary key) for task (There are 3 so $(TASKID1) ...) Needs to be random and unique.      
 *	YEAR# = the year(s) to use in the script (There are 3 and $(YEAR3) usually is equal to the current year).
 *
 * Note: Requires MSSQL 2008 or higher 
 *
 */


--Delete Operations Can be Commented Out for Fresh Database
/*
DELETE FROM external_faculty_course WHERE faculty_school_id = '$(COACHASSIGNED)';

DELETE FROM external_faculty_course_roster WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_person WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_person_note WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_person_planning_status WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_registration_status_by_term WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_student_academic_program WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_student_financial_aid WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_student_test WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_student_transcript WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_student_transcript_course WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_student_transcript_term  WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_student_risk_indicator where school_id = '$(NEWSTUDENT1)';
DELETE FROM external_student_special_service_group where school_id = '$(NEWSTUDENT1)';

DELETE FROM external_faculty_course_roster WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_person WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_person_note WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_person_planning_status WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_registration_status_by_term WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_academic_program WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_financial_aid WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_test WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_transcript WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_transcript_course WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_transcript_term  WHERE school_id = '$(PROGRESSINGSTUDENT2)';

DELETE FROM external_faculty_course_roster WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_person WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_person_note WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_person_planning_status WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_registration_status_by_term WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_academic_program WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_financial_aid WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_test WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_transcript WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_transcript_course WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_transcript_term  WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_risk_indicator where school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_special_service_group where school_id = '$(PROGRESSINGSTUDENT2)';

DELETE FROM external_faculty_course_roster WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_person WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_person_note WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_person_planning_status WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_registration_status_by_term WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_academic_program WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_financial_aid WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_test WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_transcript WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_transcript_course WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_transcript_term  WHERE school_id = '$(STRUGGLINGSTUDENT3)';

DELETE FROM external_faculty_course_roster WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_person WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_person_note WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_person_planning_status WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_registration_status_by_term WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_academic_program WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_financial_aid WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_test WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_transcript WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_transcript_course WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_transcript_term  WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_financial_aid_file WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_student_financial_aid_file WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_financial_aid_file WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_financial_aid_award_term WHERE school_id = '$(NEWSTUDENT1)';
DELETE FROM external_student_financial_aid_award_term WHERE school_id = '$(PROGRESSINGSTUDENT2)';
DELETE FROM external_student_financial_aid_award_term WHERE school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_risk_indicator where school_id = '$(STRUGGLINGSTUDENT3)';
DELETE FROM external_student_special_service_group where school_id = '$(STRUGGLINGSTUDENT3)';
*/
--End of Deletes



--$(NEWSTUDENT1)

INSERT INTO external_person(school_id, username, first_name, middle_name, last_name, birth_date, primary_email_address, address_line_1, address_line_2, city, state, zip_code, home_phone, work_phone, office_location, office_hours, department_name, actual_start_term, actual_start_year, marital_status, ethnicity, gender, is_local, balance_owed, coach_school_id, cell_phone, photo_url, residency_county, f1_status, non_local_address, student_type_code, race_code, campus_code)
VALUES ('$(NEWSTUDENT1)', '$(NEWSTUDENT1)', '$(NEWSTUDENTFIRSTNAME)', '$(NEWSTUDENTMIDDLENAME)', '$(NEWSTUDENTLASTNAME)', '1983-08-20','demo@trainingssp.com', '123 N. Demo St.', 'Apt. 555', 'Phoenix', 'AZ', '55555', '(555) 555-5555', '', '', '', '', 'SP$(YEAR3)', '$(YEAR3)', 'Single', 'Caucasian/White', 'M', 1, 0.00, '$(COACHASSIGNED)', '', NULL, 'DemoCounty', 'Y', 'N', 'FTIC', '', '');         


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name,
            test_date, score, status, discriminator, outcome)
VALUES ('$(NEWSTUDENT1)', 'Scholastic Assessment Test','SAT', 'COMP', 'COMP', '$(YEAR2)-04-11', '1698.00', 'Accepted', '1', '');


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status, discriminator, outcome)
VALUES ('$(NEWSTUDENT1)', 'American College Testing','ACT', 'COMP', 'COMP', '$(YEAR2)-04-15', '22', 'Accepted', '1', 'Take science courses or try ACT again for better science score');

INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status, discriminator, outcome)
VALUES ('$(NEWSTUDENT1)', 'American College Testing','ACT', 'COMP', 'COMP', '$(YEAR2)-04-15', '25', 'Accepted', '2', 'Test completed, ready for college');


INSERT INTO external_student_academic_program(school_id, degree_code, degree_name, program_code, program_name, 
            intended_program_at_admit)
VALUES ('$(NEWSTUDENT1)', 'ASC', '', '', '', '');


INSERT INTO external_student_financial_aid(school_id, financial_aid_gpa, gpa_20_b_hrs_needed, gpa_20_a_hrs_needed, needed_for_67ptc_completion, current_year_financial_aid_award, 
            sap_status, fafsa_date, financial_aid_remaining, original_loan_amount, remaining_loan_amount, sap_status_code, institutional_loan_amount, eligible_federal_aid, financial_aid_file_status, terms_left)
VALUES ('$(NEWSTUDENT1)', 2.44, 6.00, 6.00, 12.00, 'Y', 'Y', '$(YEAR3)-08-24', 53.00, 3850.00, 3797.00, 'SAP_PROB', 6000.00, 'Y', 'PENDING', 7);


INSERT INTO external_student_financial_aid_file (school_id, file_status, financial_file_code) VALUES ('$(NEWSTUDENT1)','PENDING','SAP_PROB');

INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(NEWSTUDENT1)','Y','FA$(YEAR3)');
INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(NEWSTUDENT1)','Y','SP$(YEAR3)');


INSERT INTO external_student_transcript(school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            total_quality_points, grade_point_average, academic_standing, credit_hours_not_completed, credit_completion_rate, 		    gpa_trend_indicator, current_restrictions, local_gpa, program_gpa)
VALUES ('$(NEWSTUDENT1)', 9.00, 9.00, 9.00, 70.00, 2.10, 'Good', 1.00, 100.00, 'New', 'New Unknown', 3.20, 3.00);


INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('$(NEWSTUDENT1)', 'FA$(YEAR3)', 5, 'Y');


INSERT INTO external_person_planning_status(
            school_id, status, status_reason)
    VALUES ('$(NEWSTUDENT1)', 'ON', 'On plan.');


INSERT INTO external_student_transcript_term(
	    school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
	    credit_hours_not_completed, credit_completion_rate, total_quality_points, 
	    grade_point_average, term_code)
    VALUES ('$(NEWSTUDENT1)',9.00,9.00,0.00,9.00,9.00,2.00,2.10,'SP$(YEAR3)');


INSERT INTO external_student_transcript_non_course(school_id, target_formatted_course, term_code, non_course_code, title, description, grade, credit_earned, credit_type, status_code)
VALUES ('$(NEWSTUDENT1)', 'HST234', 'SP$(YEAR3)', 'HIST_TEST', 'History Test Override', 'History Test Placement/Override', 'P', 0.00, 'Institutional', 'E');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(NEWSTUDENT1)', 'MAT', '085', 'MAT085', '801', 'Introductory Algebra', 'Preparation for college algebra',
	    'B', 3, 'SP$(YEAR3)', 'Transfer', '$(NEWSTUDENTFIRSTNAME)', '$(NEWSTUDENTMIDDLENAME)', 
	    '$(NEWSTUDENTLASTNAME)', 'N', 'E', 'MAT085-801', 'rjones210', 'MAT085801', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(NEWSTUDENT1)', 'ENG', '101', 'ENG101', '694', 'English Composition I', 'Introduction to college english',
	    'C+', 3, 'SP$(YEAR3)', 'Transfer', '$(NEWSTUDENTFIRSTNAME)', '$(NEWSTUDENTMIDDLENAME)', 
	    '$(NEWSTUDENTLASTNAME)', 'N', 'E', 'ENG101-694', 'jmartinez110', 'ENG101694', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(NEWSTUDENT1)', 'CST', '101', 'CST101', '541', 'Introduction to Computing I', 'Introduction to the fundamentals of computing',
	    'D', 3, 'SP$(YEAR3)', 'Transfer', '$(NEWSTUDENTFIRSTNAME)', '$(NEWSTUDENTMIDDLENAME)', 
	    '$(NEWSTUDENTLASTNAME)', 'N', 'E', 'CST101-541', 'dwilson220', 'CST101541', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(NEWSTUDENT1)', 'CST', '102', 'CST102', '645', 'Programming Fundamentals II', 'Programming Fundamentals II',
            'C', 3, 'FA$(YEAR3)', 'Institutional', '$(NEWSTUDENTFIRSTNAME)', '$(NEWSTUDENTMIDDLENAME)', 
            '$(NEWSTUDENTLASTNAME)', 'N', 'E', 'CST102-645', 'etaylor310', 'CST102645', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(NEWSTUDENT1)', 'ENG', '102', 'ENG102', '203', 'English Composition II', 'English Composition II',
            'C', 3, 'FA$(YEAR3)', 'Institutional', '$(NEWSTUDENTFIRSTNAME)', '$(NEWSTUDENTMIDDLENAME)', 
            '$(NEWSTUDENTLASTNAME)', 'N', 'E', 'ENG102-203', 'dmartinez340', 'ENG102203', '82');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(NEWSTUDENT1)', 'HST', '163', 'HST163', '106', 'Survey History', 'Survey History',
            'C', 3, 'FA$(YEAR3)', 'Institutional', '$(NEWSTUDENTFIRSTNAME)', '$(NEWSTUDENTMIDDLENAME)', 
            '$(NEWSTUDENTLASTNAME)', 'N', 'E', 'HST163-106', 'jwilliams510', 'HST163106', '100');


INSERT INTO external_student_transcript_course(
            school_id, subject_abbreviation, number, formatted_course, 
            section_number, title, description, grade, credit_earned, term_code, 
            credit_type, first_name, middle_name, last_name, audited, status_code, 
            section_code, faculty_school_id, course_code, participation)
     VALUES ('$(NEWSTUDENT1)', 'PHY', '131', 'PHY131', '932', 'Introduction to Physics', 'Introduction to Physics',
            'C', 3, 'FAYEAR3', 'Institutional', 'NEWSTUDENTFIRSTNAME', 'NEWSTUDENTMIDDLENAME', 
            'NEWSTUDENTLASTNAME', 'N', 'E', 'PHY131-932', 'dmartinez340', 'PHY-131', '100');

INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(NEWSTUDENT1)', 'MAT', '183', 'MAT183', '200', 'Advanced Mathematics', 'Advanced Mathematics',
            'C', 3, 'FA$(YEAR3)', 'Institutional', '$(NEWSTUDENTFIRSTNAME)', '$(NEWSTUDENTMIDDLENAME)', 
            '$(NEWSTUDENTLASTNAME)', 'N', 'E', 'MAT183-200', 'jmartinez110', 'MAT183200', '100');


INSERT INTO external_student_risk_indicator (
            school_id, model_code, model_name, indicator_code, indicator_name, indicator_value,
            indicator_value_description)
    VALUES ('$(NEWSTUDENT1)', 'apereo.lai.course', 'Apereo LAI', 'apereo.lai.course.CST102-645', 'Course: CST102-645',
            'LOW RISK', 'Current profile and activity levels indicate a LOW RISK of failure in course: CST102-645');

INSERT INTO external_student_risk_indicator (
            school_id, model_code, model_name, indicator_code, indicator_name, indicator_value,
            indicator_value_description)
    VALUES ('$(NEWSTUDENT1)', 'apereo.lai.course', 'Apereo LAI', 'apereo.lai.course.ENG102-203', 'Course: ENG102-203',
            'LOW RISK', 'Current profile and activity levels indicate a LOW RISK of failure in course: ENG102-203');

INSERT INTO external_student_risk_indicator (
            school_id, model_code, model_name, indicator_code, indicator_name, indicator_value,
            indicator_value_description)
    VALUES ('$(NEWSTUDENT1)', 'apereo.lai.course', 'Apereo LAI', 'apereo.lai.course.HST163-106', 'Course: HST163-106',
            'LOW RISK', 'Current profile and activity levels indicate a LOW RISK of failure in course: HST163-106');

INSERT INTO external_student_risk_indicator (
            school_id, model_code, model_name, indicator_code, indicator_name, indicator_value,
            indicator_value_description)
    VALUES ('$(NEWSTUDENT1)', 'apereo.lai.course', 'Apereo LAI', 'apereo.lai.course.PHY131-932', 'Course: PHY131-932',
            'HIGH RISK', 'Current profile and activity levels indicate a HIGH RISK of failure in course: PHY131-932');

INSERT INTO external_student_risk_indicator (
            school_id, model_code, model_name, indicator_code, indicator_name, indicator_value,
            indicator_value_description)
    VALUES ('$(NEWSTUDENT1)', 'apereo.lai.course', 'Apereo LAI', 'apereo.lai.course.MAT183-200', 'Course: MAT183-200',
            'LOW RISK', 'Current profile and activity levels indicate a LOW RISK of failure in course: MAT183-200');
            
INSERT INTO external_career_decision_status(school_id, code)
VALUES ('$(NEWSTUDENT1)', 'U'); 


INSERT INTO external_student_risk_indicator(school_id, model_code, model_name, indicator_code, indicator_name, indicator_value, indicator_value_description)  
VALUES ('$(NEWSTUDENT1)', 'LMS_PARTICIPATION', 'LMS Participation', 'LMS_PARTICIPATION', 'LMS Participation', '49', 'LMS Participation 49');

INSERT INTO external_student_risk_indicator(school_id, model_code, model_name, indicator_code, indicator_name, indicator_value, indicator_value_description)  
VALUES ('$(NEWSTUDENT1)', 'ATTENDANCE', 'Average Class Attendance', 'ATTENDANCE', 'Average Class Attendance', '40', 'ATTENDANCE 40');

INSERT INTO external_student_risk_indicator(school_id, model_code, model_name, indicator_code, indicator_name, indicator_value, indicator_value_description)  
VALUES ('$(NEWSTUDENT1)', 'FIN_AID_GPA', 'Financial Aid GPA', 'FIN_AID_GPA', 'Financial Aid GPA', 2.44, 'The GPA that is considered when awarding Financial Aid');

INSERT INTO external_student_risk_indicator(school_id, model_code, model_name, indicator_code, indicator_name, indicator_value, indicator_value_description)  
VALUES ('$(NEWSTUDENT1)', 'LIBRARY', 'Library/Learning Resource Access', 'LIBRARY', 'Library/Learning Resource Access', '1', 'LIBRARY 1');

INSERT INTO external_student_special_service_group(school_id, code)
    VALUES ('$(NEWSTUDENT1)', 'PATH'); 
          


--$(PROGRESSINGSTUDENT2)


INSERT INTO external_person( school_id, username, first_name, middle_name, last_name, birth_date, 
            primary_email_address, address_line_1, address_line_2, city, 
            state, zip_code, home_phone, work_phone, office_location, office_hours, 
            department_name, actual_start_term, actual_start_year, marital_status, 
            ethnicity, gender, is_local, balance_owed, coach_school_id, cell_phone, 
            photo_url, residency_county, f1_status, non_local_address, student_type_code, race_code, campus_code)
VALUES ('$(PROGRESSINGSTUDENT2)', '$(PROGRESSINGSTUDENT2)', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', '$(PROGRESSINGSTUDENTLASTNAME)', '1988-01-04', 'demo@trainingssp.com', '312 N. Demo St.', 'Apt. 012', 'Phoenix', 'AZ', '55555', '(555) 555-5423', '', '', '', '', 'FA$(YEAR1)', '$(YEAR1)', 'Separated', 'Caucasian/White', 'F', 1, 0.00, '$(COACHASSIGNED)', '', NULL,'DemoCounty','Y','N','RET','', 'WEST');


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status, discriminator, outcome)
VALUES ('$(PROGRESSINGSTUDENT2)', 'Scholastic Assessment Test','SAT', 'COMP', 'COMP', '$(YEAR1)-01-01', '1948.00', 'Accepted', '1', 'Ready for college, try taking placement tests for earlier completion');


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status, discriminator, outcome)
VALUES ('$(PROGRESSINGSTUDENT2)', 'American College Testing','ACT', 'COMP', 'COMP', '$(YEAR1)-01-28', '27', 'Accepted', '1', 'Ready for college, try taking placement tests for earlier completion');


INSERT INTO external_student_academic_program(school_id, degree_code, degree_name, program_code, program_name, 
            intended_program_at_admit)
VALUES ('$(PROGRESSINGSTUDENT2)', 'ASC', 'Applied Computing', 'CST-AS', 'Associates of Science in Computing', 'Associates of Science in Computing');


INSERT INTO external_student_financial_aid(school_id, financial_aid_gpa, gpa_20_b_hrs_needed, gpa_20_a_hrs_needed, needed_for_67ptc_completion, current_year_financial_aid_award, sap_status, fafsa_date, financial_aid_remaining, original_loan_amount, remaining_loan_amount, sap_status_code, institutional_loan_amount, eligible_federal_aid, financial_aid_file_status, terms_left)
VALUES ('$(PROGRESSINGSTUDENT2)', 3.20, 9.00, 6.00, 3.00, 'Y', 'Y', '$(YEAR3)-08-24', 118.00, 5150.00, 5032.00, 'SAP_SAT', 10000.00, 'Y', 'COMPLETE', 4);


INSERT INTO external_student_financial_aid_file (school_id, file_status, financial_file_code) VALUES ('$(PROGRESSINGSTUDENT2)','COMPLETE','SAP_SAT');


INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(PROGRESSINGSTUDENT2)','Y','FA$(YEAR1)');
INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(PROGRESSINGSTUDENT2)','Y','SP$(YEAR1)');
INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(PROGRESSINGSTUDENT2)','Y','FA$(YEAR2)');
INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(PROGRESSINGSTUDENT2)','Y','SP$(YEAR2)');
INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(PROGRESSINGSTUDENT2)','Y','FA$(YEAR3)');
INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(PROGRESSINGSTUDENT2)','Y','SP$(YEAR3)');



INSERT INTO external_student_transcript(school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            total_quality_points, grade_point_average, academic_standing, credit_hours_not_completed, credit_completion_rate, 		    gpa_trend_indicator, current_restrictions, local_gpa, program_gpa)
VALUES ('$(PROGRESSINGSTUDENT2)', 63.00, 63.00, 63.00, 131.00, 3.64, 'Good', 1.00, 100.00, 'Progressing', 'None', 3.94, 3.82);


INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('$(PROGRESSINGSTUDENT2)', 'FA$(YEAR1)', 6, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('$(PROGRESSINGSTUDENT2)', 'SP$(YEAR2)', 5, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('$(PROGRESSINGSTUDENT2)', 'FA$(YEAR2)', 5, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('$(PROGRESSINGSTUDENT2)', 'SP$(YEAR3)', 5, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('$(PROGRESSINGSTUDENT2)', 'FA$(YEAR3)', 5, 'Y');



INSERT INTO external_person_planning_status(
            school_id, status, status_reason)
    VALUES ('$(PROGRESSINGSTUDENT2)', 'ON', 'Is doing well and on plan.');


INSERT INTO external_person_note(
            code, school_id, note_type, author, department, date_note_taken, 
            note)
    VALUES ('$(TASKID1)', '$(PROGRESSINGSTUDENT2)', 'Legacy', 'Previous Advisor','Advising', '$(YEAR2)-05-03', 
            '$(PROGRESSINGSTUDENTFIRSTNAME) is doing really well. Applying for Pell and OCOG grants.');

INSERT INTO external_person_note(
            code, school_id, note_type, author, department, date_note_taken, 
            note)
    VALUES ('$(TASKID2)', '$(PROGRESSINGSTUDENT2)', 'Legacy', 'Previous Advisor','Advising', '$(YEAR2)-09-13', 
            '$(PROGRESSINGSTUDENTFIRSTNAME) wishes to change her major to Computer Science Associates degree.');



INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('$(PROGRESSINGSTUDENT2)',18.00,18.00,18.00,0.00,18.00,40.00,3.50,'FA$(YEAR1)');

INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('$(PROGRESSINGSTUDENT2)',15.00,15.00,15.00,0.00,15.00,90.00,3.60,'SP$(YEAR2)');


INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('$(PROGRESSINGSTUDENT2)',15.00,15.00,15.00,0.00,15.00,90.00,3.67,'FA$(YEAR2)');



INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('$(PROGRESSINGSTUDENT2)',15.00,15.00,15.00,0.00,15.00,90.00,3.74,'SP$(YEAR3)');


INSERT INTO external_student_transcript_non_course(school_id, target_formatted_course, term_code, non_course_code, title, description, grade, credit_earned, credit_type, status_code)
VALUES ('$(PROGRESSINGSTUDENT2)', 'MAT183', 'SP$(YEAR3)', 'MATH_TEST', 'Math Test Override', 'College Math Test Placement/Override', 'P', 0.00, 'Institutional', 'E');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'PSY', '101', 'PSY101', '213', 'Introduction to Psychology', 'Introduction to Psychology',
            'B', 3, 'FA$(YEAR1)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'PSY101-213', 'dmartinez340', 'PSY101213', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'MAT', '106', 'MAT106', '145', 'Applied Mathematics', 'Applied Mathematics',
            'A-', 3, 'FA$(YEAR1)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'CST102-645', 'etaylor310', 'MAT106145', '100');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'SCL', '101', 'SCL101', '123', 'Introduction to Sociology', 'Introduction to Sociology',
            'A', 3, 'FA$(YEAR1)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'SCL101-123', 'rjones330', 'SCL101123', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'CRIJ', '130', 'CRIJ130', '211', 'Introduction to Criminal Justice', 'Introduction to Criminal Justice',
            'A', 4.00, 'FA$(YEAR1)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'CRIJ130-211', 'jmartinez110', 'CRIJ13211', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'ENG', '101', 'ENG101', '325', 'English Composition I', 'Introduction to college english',
            'B+', 3.00, 'FA$(YEAR1)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'ENG101-325', 'rjones210', 'ENG101325', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'CRIJ', '131', 'CRIJ131', '390', 'Fundamentals of Criminal Law', 'Introduction to the fundamentals of Criminal Law',
            'B', 3.00, 'FA$(YEAR1)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'CRIJ131-390', 'dwilson220', 'CRIJ131390', '100');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'ENG', '102', 'ENG102', '119', 'English Composition II', 'English Composition II',
            'A-', 3, 'SP$(YEAR2)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'ENG102-119', 'dmartinez340', 'ENG102119', '100');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'LIT', '111', 'LIT111', '304', 'Basics of Literature', 'Basics of Literature',
            'B', 3, 'SP$(YEAR2)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'LIT111-304', 'rjones330', 'LIT111304', '100');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'CRIJ', '133', 'CRIJ133', '120', 'Juvenile Justice System', 'Study of the Juvenile Justice System',
            'B+', 3, 'SP$(YEAR2)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'CRIJ133-120', 'jwilliams510', 'CRIJ133120', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'CRIJ', '134', 'CRIJ134', '130', 'Ethics in Criminal Justice', 'Introduction to ethics in the criminal justice system',
            'A-', 3, 'SP$(YEAR2)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'CRIJ134-130', 'dmartinez340', 'CRIJ134130', '100');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'MAT', '183', 'MAT183', '206', 'Advanced Mathematics', 'Advanced Mathematics',
            'A', 3, 'SP$(YEAR2)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'MAT183-206', 'jmartinez110', 'MAT183206', '100');






INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'CST', '101', 'CST101', '120', 'Programming Fundamentals I', 'Programming Fundamentals I',
            'A+', 3, 'FA$(YEAR2)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'CST101-120', 'etaylor310', 'CST101120', '100');




INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'CST', '105', 'CST105', '304', 'Introduction to Computing I', 'Computers Intro',
            'A-', 3, 'FA$(YEAR2)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'CST105-304', 'rjones330', 'CST105304', '100');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'MIC', '134', 'MIC134', '430', 'Foundational Microbiology', 'Introduction to microbiology',
            'B+', 3, 'FA$(YEAR2)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'MIC134-430', 'dmartinez340', 'MIC134430', '100');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'PHL', '106', 'PHL106', '420', 'Advanced Philosophy', 'Study of Philosophy',
            'B', 3, 'FA$(YEAR2)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'PHL106-420', 'jwilliams510', 'PHL106420', '100');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'MAT', '219', 'MAT219', '960', 'Applied Mathematics', 'Applied Mathematics',
            'A', 3, 'FA$(YEAR2)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'MAT219-960', 'dmartinez340', 'MAT219960', '100');






INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'CST', '102', 'CST102', '012', 'Programming Fundamentals II', 'Programming Fundamentals II',
            'A-', 3, 'SP$(YEAR3)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'CST102-012', 'dmartinez340', 'CST102012', '100');




INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'CST', '135', 'CST135', '005', 'Fundamentals of Networking', 'Fundamentals of Networking',
            'A', 3, 'SP$(YEAR3)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'CST135-005', 'rjones330', 'CST135005', '100');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'LIT', '155', 'LIT155', '090', 'Advanced Literature', 'Study of Short Stories and Literature',
            'B+', 3, 'SP$(YEAR3)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'LIT155-090', 'jwilliams510', 'LIT155090', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'MAT', '251', 'MAT251', '116', 'Creative Mathematics', 'Creative Mathematics',
            'A', 3, 'SP$(YEAR3)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'MAT251-116', 'jmartinez110', 'MAT251116', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'CST', '262', 'CST262', '240', 'UNIX Operating System', 'Introduction to the UNIX/LINUX operating system',
            'A-', 3, 'SP$(YEAR3)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'CST262-240', 'dmartinez340', 'CST262240', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'CST', '230', 'CST230', '320', 'Object Orientated Programming', 'OO Programming with GUI design',
            'A', 3, 'FA$(YEAR3)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'CST230-230', 'dmartinez340', 'CST230320', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'CST', '245', 'CST245', '189', 'System Analysis and Design', 'System Analysis and Design',
            'A', 3, 'FA$(YEAR3)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'CST245-189', 'rjones330', 'CST245189', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'PHY', '215', 'PHY215', '485', 'College level Physics', 'College Physics',
            'A', 3, 'FA$(YEAR3)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'PHY215-485', 'etaylor310', 'PHY215485', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'HST', '210', 'HST210', '287', 'Survey History', 'Survey of History',
            'A', 3, 'FA$(YEAR3)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'HST210-287', 'jwilliams510', 'HST210287', '100');



INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(PROGRESSINGSTUDENT2)', 'MAT', '324', 'MAT324', '112', 'Quantitative Mathematics', 'Quantitative Mathematics',
            'A', 3, 'FA$(YEAR3)', 'Institutional', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', 
            '$(PROGRESSINGSTUDENTLASTNAME)', 'N', 'E', 'MAT324-112', 'jmartinez110', 'MAT324112', '100');



INSERT INTO external_student_risk_indicator (
            school_id, model_code, model_name, indicator_code, indicator_name, indicator_value,
            indicator_value_description)
    VALUES ('$(PROGRESSINGSTUDENT2)', 'apereo.lai.course', 'Apereo LAI', 'apereo.lai.course.CST230-230', 'Course: CST230-230',
            'NO RISK', 'Current profile and activity levels indicate NO RISK of failure in course: CST230-230');

INSERT INTO external_student_risk_indicator (
            school_id, model_code, model_name, indicator_code, indicator_name, indicator_value,
            indicator_value_description)
    VALUES ('$(PROGRESSINGSTUDENT2)', 'apereo.lai.course', 'Apereo LAI', 'apereo.lai.course.CST245-189', 'Course: CST245-189',
            'NO RISK', 'Current profile and activity levels indicate NO RISK of failure in course: CST245-189');

INSERT INTO external_student_risk_indicator (
            school_id, model_code, model_name, indicator_code, indicator_name, indicator_value,
            indicator_value_description)
    VALUES ('$(PROGRESSINGSTUDENT2)', 'apereo.lai.course', 'Apereo LAI', 'apereo.lai.course.PHY215-485', 'Course: PHY215-485',
            'NO RISK', 'Current profile and activity levels indicate NO RISK of failure in course: PHY215-485');

INSERT INTO external_student_risk_indicator (
            school_id, model_code, model_name, indicator_code, indicator_name, indicator_value,
            indicator_value_description)
    VALUES ('$(PROGRESSINGSTUDENT2)', 'apereo.lai.course', 'Apereo LAI', 'apereo.lai.course.HST210-287', 'Course: HST210-287',
            'NO RISK', 'Current profile and activity levels indicate NO RISK of failure in course: HST210-287');

INSERT INTO external_student_risk_indicator (
            school_id, model_code, model_name, indicator_code, indicator_name, indicator_value,
            indicator_value_description)
    VALUES ('$(PROGRESSINGSTUDENT2)', 'apereo.lai.course', 'Apereo LAI', 'apereo.lai.course.MAT324-112', 'Course: MAT324-112',
            'NO RISK', 'Current profile and activity levels indicate NO RISK of failure in course: MAT324-112');
            
INSERT INTO external_career_decision_status(school_id, code)
VALUES ('$(PROGRESSINGSTUDENT2)', 'D');  


INSERT INTO external_student_risk_indicator(school_id, model_code, model_name, indicator_code, indicator_name, indicator_value, indicator_value_description)  
VALUES ('$(PROGRESSINGSTUDENT2)', 'LMS_PARTICIPATION', 'LMS Participation', 'LMS_PARTICIPATION', 'LMS Participation', '99', 'LMS Participation 49');

INSERT INTO external_student_risk_indicator(school_id, model_code, model_name, indicator_code, indicator_name, indicator_value, indicator_value_description)  
VALUES ('$(PROGRESSINGSTUDENT2)', 'ATTENDANCE', 'Average Class Attendance', 'ATTENDANCE', 'Average Class Attendance', '98', 'ATTENDANCE 40');

INSERT INTO external_student_risk_indicator(school_id, model_code, model_name, indicator_code, indicator_name, indicator_value, indicator_value_description)  
VALUES ('$(PROGRESSINGSTUDENT2)', 'FIN_AID_GPA', 'Financial Aid GPA', 'FIN_AID_GPA', 'Financial Aid GPA', 3.20, 'The GPA that is considered when awarding Financial Aid');

INSERT INTO external_student_risk_indicator(school_id, model_code, model_name, indicator_code, indicator_name, indicator_value, indicator_value_description)  
VALUES ('$(PROGRESSINGSTUDENT2)', 'LIBRARY', 'Library/Learning Resource Access', 'LIBRARY', 'Library/Learning Resource Access', '40', 'LIBRARY 40');

INSERT INTO external_student_special_service_group(school_id, code)
    VALUES ('$(PROGRESSINGSTUDENT2)', 'ATD'); 


--$(STRUGGLINGSTUDENT3)

INSERT INTO external_person( school_id, username, first_name, middle_name, last_name, birth_date, 
            primary_email_address, address_line_1, address_line_2, city, 
            state, zip_code, home_phone, work_phone, office_location, office_hours, 
            department_name, actual_start_term, actual_start_year, marital_status, 
            ethnicity, gender, is_local, balance_owed, coach_school_id, cell_phone, 
            photo_url, residency_county, f1_status, non_local_address, student_type_code, race_code, campus_code)
VALUES ('$(STRUGGLINGSTUDENT3)', '$(STRUGGLINGSTUDENT3)', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', '$(STRUGGLINGSTUDENTLASTNAME)', '1986-10-24', 'demo@trainingssp.com', '321 W. Demo St.', 'Apt. 214', 'Phoenix', 'AZ', '55555', '(555) 555-5412', '', '', '', '', 'FA$(YEAR1)', '$(YEAR1)', 'Separated', 'Caucasian/White', 'M', 1, 0.00, '$(COACHASSIGNED)', '', NULL,'DemoCounty','Y','N','EAL','', 'NORTH');

INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status, discriminator, outcome)
VALUES ('$(STRUGGLINGSTUDENT3)', 'Scholastic Assessment Test','SAT', 'COMP', 'COMP', '$(YEAR1)-01-01', '1000.00', 'Accepted', '1', 'Try again was sick');

INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status, discriminator, outcome)
VALUES ('$(STRUGGLINGSTUDENT3)', 'Scholastic Assessment Test','SAT', 'COMP', 'COMP', '$(YEAR1)-02-11', '1300.00', 'Accepted', '2', 'Take math and english courses');


INSERT INTO external_student_test(school_id, test_name, test_code, sub_test_code, sub_test_name, test_date, score, status, discriminator, outcome)
VALUES ('$(STRUGGLINGSTUDENT3)', 'American College Testing','ACT', 'COMP', 'COMP', '$(YEAR1)-01-28', '18', 'Accepted', '1', 'Take math and science courses');


INSERT INTO external_student_academic_program(school_id, degree_code, degree_name, program_code, program_name, 
            intended_program_at_admit)
VALUES ('$(STRUGGLINGSTUDENT3)', 'AUMT', 'Automotive Technology', 'AUMT-AS', 'Associates of Science in Automotive Technology', 'Associates of Science in Automotive Technology');


INSERT INTO external_student_financial_aid(school_id, financial_aid_gpa, gpa_20_b_hrs_needed, gpa_20_a_hrs_needed, needed_for_67ptc_completion, current_year_financial_aid_award, sap_status, fafsa_date, financial_aid_remaining, original_loan_amount, remaining_loan_amount, sap_status_code, institutional_loan_amount, eligible_federal_aid, financial_aid_file_status, terms_left)
VALUES ('$(STRUGGLINGSTUDENT3)', 1.82, 9.00, 9.00, 9.00, 'Y', 'N', '$(YEAR3)-08-24', 809.00, 6600.00, 5791.00, 'SAP_DIS', 9000.00, 'N', 'INCOMPLETE', 0);


INSERT INTO external_student_financial_aid_file (school_id, file_status, financial_file_code) VALUES ('$(STRUGGLINGSTUDENT3)','INCOMPLETE','SAP_DIS');

INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(STRUGGLINGSTUDENT3)','Y','FA$(YEAR1)');
INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(STRUGGLINGSTUDENT3)','Y','SP$(YEAR1)');
INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(STRUGGLINGSTUDENT3)','Y','FA$(YEAR2)');
INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(STRUGGLINGSTUDENT3)','Y','SP$(YEAR2)');
INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(STRUGGLINGSTUDENT3)','N','FA$(YEAR3)');
INSERT INTO external_student_financial_aid_award_term (school_id, accepted, term_code) VALUES ('$(STRUGGLINGSTUDENT3)','N','SP$(YEAR3)');


INSERT INTO external_student_transcript(school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            total_quality_points, grade_point_average, academic_standing, credit_hours_not_completed, credit_completion_rate, 		    gpa_trend_indicator, current_restrictions, local_gpa, program_gpa)
VALUES ('$(STRUGGLINGSTUDENT3)', 35.00, 31.00, 36.00, 85.00, 1.82, 'Probation', 5.00, 86.00, 'Down', 'On Academic Probation', 1.50, 2.00);


INSERT INTO external_person_planning_status(
            school_id, status, status_reason)
    VALUES ('$(STRUGGLINGSTUDENT3)', 'OFF', 'Is not doing well, needs help.');


INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('$(STRUGGLINGSTUDENT3)', 'FA$(YEAR1)', 5, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('$(STRUGGLINGSTUDENT3)', 'SP$(YEAR2)', 5, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('$(STRUGGLINGSTUDENT3)', 'FA$(YEAR2)', 4, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('$(STRUGGLINGSTUDENT3)', 'SP$(YEAR3)', 3, 'Y');

INSERT INTO external_registration_status_by_term(
            school_id, term_code, registered_course_count, tuition_paid)
    VALUES ('$(STRUGGLINGSTUDENT3)', 'FA$(YEAR3)', 1, 'N');



INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('$(STRUGGLINGSTUDENT3)',15.00,15.00,15.00,0.00,15.00,18.00,2.58,'FA$(YEAR1)');

INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('$(STRUGGLINGSTUDENT3)',12.00,12.00,15.00,3.00,12.00,10.00,2.15,'SP$(YEAR2)');


INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('$(STRUGGLINGSTUDENT3)',12.00,12.00,12.00,0.00,11.75,8.00,1.85,'FA$(YEAR2)');



INSERT INTO external_student_transcript_term(
            school_id, credit_hours_for_gpa, credit_hours_earned, credit_hours_attempted, 
            credit_hours_not_completed, credit_completion_rate, total_quality_points, 
            grade_point_average, term_code)
    VALUES ('$(STRUGGLINGSTUDENT3)',6.00,6.00,9.00,3.00,0.80,0.00,0.77,'SP$(YEAR3)');


INSERT INTO external_student_transcript_non_course(school_id, target_formatted_course, term_code, non_course_code, title, description, grade, credit_earned, credit_type, status_code)
VALUES ('$(STRUGGLINGSTUDENT3)', 'ENG100', 'SP$(YEAR3)', 'ENG_TEST', 'English Test Override', 'College English Test Placement/Override', 'P', 0.00, 'Institutional', 'E');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'AUMT', '101', 'AUMT101', '056', 'Introduction to Speed Communication', 'Introduction to Speed Communication',
            'B', 2.00, 'FA$(YEAR1)', 'Institutional', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'AUMT101-056', 'rjones210', 'AUMT101056', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'ENG', '055', 'ENG055', '112', 'English Composition I', 'Preparation for College Composition',
            'C+', 2.00, 'FA$(YEAR1)', 'Developmental', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'ENG055-112', 'dwilson220', 'ENG055122', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'MAT', '085', 'MAT085', '500', 'Introductory Algebra', 'Introduction to the fundamentals of Algebra',
            'B+', 1.00, 'FA$(YEAR1)', 'Developmental', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'MAT085-500', 'jmartinez110', 'MAT085500', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'AUMT', '140', 'AUMT140', '139', 'Introduction to Automotive Technology', 'Introduction to Automotive Technology ',
            'C', 3, 'FA$(YEAR1)', 'Institutional', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'AUMT140-113', 'rjones330', 'AUMT140139', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'ENG', '075', 'ENG075', '125', 'College Writing I', 'College Writing I',
            'C+', 3, 'FA$(YEAR1)', 'Developmental', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'ENG075-125', 'etaylor310', 'ENG075125', '100');





INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'AUMT', '142', 'AUMT142', '133', 'Automotive Engine Repair', 'Introduction to Automotive Engine Repair',
            'C+', 3, 'SP$(YEAR2)', 'Institutional', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'AUMT142-133', 'etaylor310', 'AUMT142133', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'ENG', '076', 'ENG076', '100', 'College Writing II', 'College Writing II',
            'C', 3, 'SP$(YEAR2)', 'Developmental', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'ENG076-100', 'dmartinez340', 'ENG076100', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'GEO', '104', 'GEO104', '143', 'Introduction to Geography', 'Study of Geography',
            'C', 3, 'SP$(YEAR2)', 'Institutional', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'GEO104-143', 'jwilliams510', 'GEO104143', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'MAT', '086', 'MAT086', '168', 'Intermediate Algebra', 'Intermediate Algebra',
            'C', 3, 'SP$(YEAR2)', 'Developmental', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'MAT086-168', 'jmartinez110', 'MAT086168', '100');





INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'AUMT', '241', 'AUMT241', '450', 'Automotive Engine Performance Analysis',
	    'Introduction to Auto Performance',
            'C', 3, 'FA$(YEAR2)', 'Institutional', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'AUMT241-450', 'dmartinez340', 'AUMT241450', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'ENG', '055', 'ENG055', '095', 'College Reading I', 'College Reading I',
            'C-', 3, 'FA$(YEAR2)', 'Developmental', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'ENG055-095', 'etaylor310', 'ENG055095', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'AUMT', '146', 'AUMT146', '133', 'Automotive Suspension and Steering', 
	    'Automotive Suspension and Steering',
            'C', 3, 'FA$(YEAR2)', 'Institutional', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'AUMT146-133', 'rjones330', 'AUMT146133', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'AUMT', '142', 'AUMT142', '133', 'Automotive Engine Repair', 
	    'Introduction to Automotive Engine Repair', 'C-', 3, 'FA$(YEAR2)', 'Institutional', '$(STRUGGLINGSTUDENTFIRSTNAME)', 			'$(STRUGGLINGSTUDENTMIDDLENAME)', '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'AUMT142-133', 'etaylor310', 'AUMT142133', '100');




INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'AUMT', '244', 'AUMT244', '148', 'Engine Performance Analysis II', 'Study of engine performance part II',
            'F', 3, 'SP$(YEAR3)', 'Institutional', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'AUMT244-148', 'jwilliams510', 'AUMT244148', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'AUMT', '245', 'AUMT245', '140', 'Automotive Alternative Fuels', 'Introduction to Automotive Alternative Fuels',
            'D', 3, 'SP$(YEAR3)', 'Institutional', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'AUMT245-140', 'rjones330', 'AUMT245140', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'ENG', '076', 'ENG076', '225', 'College Writing II', 'College Writing II',
            'D+', 3, 'SP$(YEAR3)', 'Developmental', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'ENG076-225', 'etaylor310', 'ENG076225', '100');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'ENG', '076', 'ENG076', '100', 'College Writing II', 'College Writing II',
            'D', 3, 'FA$(YEAR3)', 'Developmental', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'ENG076-100', 'dmartinez340', 'ENG076100', '24');


INSERT INTO external_student_transcript_course(
	    school_id, subject_abbreviation, number, formatted_course, 
	    section_number, title, description, grade, credit_earned, term_code, 
	    credit_type, first_name, middle_name, last_name, audited, status_code, 
	    section_code, faculty_school_id, course_code, participation)
     VALUES ('$(STRUGGLINGSTUDENT3)', 'AUMT', '246', 'AUMT246', '190', 'Automotive Drive Train and Axles', 'Introduction to Automotive Drive Train and Axles',
            'D', 3, 'FA$(YEAR3)', 'Institutional', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', 
            '$(STRUGGLINGSTUDENTLASTNAME)', 'N', 'E', 'AUMT246-190', 'etaylor310', 'AUMT246190', '78');


INSERT INTO external_student_risk_indicator (
            school_id, model_code, model_name, indicator_code, indicator_name, indicator_value,
            indicator_value_description)
    VALUES ('$(STRUGGLINGSTUDENT3)', 'apereo.lai.course', 'Apereo LAI', 'apereo.lai.course.ENG076-100', 'Course: ENG076-100',
            'HIGH RISK', 'Current profile and activity levels indicate a HIGH RISK of failure in course: ENG076-100');

INSERT INTO external_student_risk_indicator (
            school_id, model_code, model_name, indicator_code, indicator_name, indicator_value,
            indicator_value_description)
    VALUES ('$(STRUGGLINGSTUDENT3)', 'apereo.lai.course', 'Apereo LAI', 'apereo.lai.course.AUMT246-190', 'Course: AUMT246-190',
            'HIGH RISK', 'Current profile and activity levels indicate a HIGH RISK of failure in course: AUMT246-190');

INSERT INTO external_career_decision_status(school_id, code)
VALUES ('$(STRUGGLINGSTUDENT3)', 'I'); 

INSERT INTO external_student_risk_indicator(school_id, model_code, model_name, indicator_code, indicator_name, indicator_value, indicator_value_description)  
VALUES ('$(STRUGGLINGSTUDENT3)', 'LMS_PARTICIPATION', 'LMS Participation', 'LMS_PARTICIPATION', 'LMS Participation', '99', 'LMS Participation 49');

INSERT INTO external_student_risk_indicator(school_id, model_code, model_name, indicator_code, indicator_name, indicator_value, indicator_value_description)  
VALUES ('$(STRUGGLINGSTUDENT3)', 'ATTENDANCE', 'Average Class Attendance', 'ATTENDANCE', 'Average Class Attendance', '98', 'ATTENDANCE 40');

INSERT INTO external_student_risk_indicator(school_id, model_code, model_name, indicator_code, indicator_name, indicator_value, indicator_value_description)  
VALUES ('$(STRUGGLINGSTUDENT3)', 'FIN_AID_GPA', 'Financial Aid GPA', 'FIN_AID_GPA', 'Financial Aid GPA', 1.82, 'The GPA that is considered when awarding Financial Aid');

INSERT INTO external_student_risk_indicator(school_id, model_code, model_name, indicator_code, indicator_name, indicator_value, indicator_value_description)  
VALUES ('$(STRUGGLINGSTUDENT3)', 'LIBRARY', 'Library/Learning Resource Access', 'LIBRARY', 'Library/Learning Resource Access', '40', 'LIBRARY 40');
             
INSERT INTO external_student_special_service_group(school_id, code)
    VALUES ('$(STRUGGLINGSTUDENT3)', 'LEARN');             

--External Course Data 

/*
INSERT INTO external_faculty_course(faculty_school_id, term_code, formatted_course, title, section_code,
		section_number)
VALUES ('$(COACHASSIGNED)', (SELECT code FROM external_term WHERE name = 'Fall $(YEAR3)' LIMIT 1), (SELECT formatted_course FROM
	 external_course ORDER BY random() LIMIT 1), 'x', (SELECT NEWID()), (SELECT trunc(random() * 999 + 1)));

INSERT INTO external_faculty_course_roster(faculty_school_id, school_id, first_name, middle_name, last_name, 
            primary_email_address, term_code, formatted_course, status_code, section_code, section_number)
    VALUES ('$(COACHASSIGNED)', '$(NEWSTUDENT1)', '$(NEWSTUDENTFIRSTNAME)', '$(NEWSTUDENTMIDDLENAME)', '$(NEWSTUDENTLASTNAME)', 
            (SELECT primary_email_address FROM external_person WHERE school_id = '$(NEWSTUDENT1)'), (SELECT code FROM external_term WHERE name = 'Fall $(YEAR3)' LIMIT 1), (SELECT formatted_course FROM external_faculty_course WHERE faculty_school_id = '$(COACHASSIGNED)' LIMIT 1), 'E', (SELECT section_code FROM external_faculty_course WHERE faculty_school_id = '$(COACHASSIGNED)' LIMIT 1), (SELECT section_number FROM external_faculty_course WHERE faculty_school_id = '$(COACHASSIGNED)' LIMIT 1));


INSERT INTO external_faculty_course_roster(faculty_school_id, school_id, first_name, middle_name, last_name, 
            primary_email_address, term_code, formatted_course, status_code, section_code, section_number)
    VALUES ('$(COACHASSIGNED)', '$(PROGRESSINGSTUDENT2)', '$(PROGRESSINGSTUDENTFIRSTNAME)', '$(PROGRESSINGSTUDENTMIDDLENAME)', '$(PROGRESSINGSTUDENTLASTNAME)', 
            (SELECT primary_email_address FROM external_person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), (SELECT code FROM external_term WHERE name = 'Fall $(YEAR3)' LIMIT 1), (SELECT formatted_course FROM external_faculty_course WHERE faculty_school_id = '$(COACHASSIGNED)' LIMIT 1), 'E', (SELECT section_code FROM external_faculty_course WHERE faculty_school_id = '$(COACHASSIGNED)' LIMIT 1), (SELECT section_number FROM external_faculty_course WHERE faculty_school_id = '$(COACHASSIGNED)'LIMIT 1));


INSERT INTO external_faculty_course_roster(faculty_school_id, school_id, first_name, middle_name, last_name, 
            primary_email_address, term_code, formatted_course, status_code, section_code, section_number)
    VALUES ('$(COACHASSIGNED)', '$(STRUGGLINGSTUDENT3)', '$(STRUGGLINGSTUDENTFIRSTNAME)', '$(STRUGGLINGSTUDENTMIDDLENAME)', '$(NEWSTUDENTLASTNAME)', 
            (SELECT primary_email_address FROM external_person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), (SELECT code FROM external_term WHERE name = 'Fall $(YEAR3)' LIMIT 1), (SELECT formatted_course FROM external_faculty_course WHERE faculty_school_id = '$(COACHASSIGNED)' LIMIT 1), 'E', (SELECT section_code FROM external_faculty_course WHERE faculty_school_id = '$(COACHASSIGNED)' LIMIT 1), (SELECT section_number FROM external_faculty_course WHERE faculty_school_id = '$(COACHASSIGNED)'LIMIT 1));
*/


--***END OF SQL SCRIPT***

