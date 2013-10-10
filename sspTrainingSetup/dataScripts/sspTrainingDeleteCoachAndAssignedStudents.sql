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
 * *** SSP TRAINING REMOVE COACH/USER DATA FROM PLATFORM ***
 *
 * This SQL File removes user data from ssp-platform and student/user data from ssp.
 *
 * To use this file substitute the placeholders below via some other script
 *  or manually with the required data for each user adding a select statement each time. 
    There is a function so you would create a select statment for each new user. 
 *
 *  SELECT addUsersToPlatform('COACHUSERNAME','PASSWORD', 'FIRSTNAME', 'LASTNAME', 'UUID');
 *
 * Substitute: 
 *	COACHUSERNAME = usernname of the coach/user to delete in ssp-platform  
 *	NEWSTUDENT1 = string username of the new student use case
 *	PROGRESSINGSTUDENT2 = string username of the progressing student use case 
 *	STRUGGLINGSTUDENT3 = string username of the struggling student use case
 *
 * Note: Requires Postgres 8.4 or higher
 *
 */

--Function to Delete Users in SSP-Platform 

CREATE OR REPLACE FUNCTION deleteUsersFromPlatform(text) RETURNS void AS $$

DECLARE
  attrRecord RECORD; 

BEGIN	   
	FOR attrRecord IN (SELECT id FROM up_person_attr WHERE user_dir_id = 
						(SELECT user_dir_id FROM up_person_dir WHERE user_name = $1)) LOOP
 		DELETE FROM up_person_attr_values WHERE attr_id = attrRecord.id;		
	END LOOP;
    	DELETE FROM up_person_attr WHERE user_dir_id = (SELECT user_dir_id FROM up_person_dir WHERE user_name = $1);
        DELETE FROM up_person_dir WHERE user_name = $1;
	DELETE FROM up_user WHERE user_name = $1;
        DELETE FROM person WHERE username = $1;  
END;

$$ LANGUAGE plpgsql;

-- End Function

--Function to Delete Individual Early Alerts 

CREATE OR REPLACE FUNCTION deleteEarlyAlerts(text) RETURNS void AS $$

DECLARE
   x RECORD;
   y RECORD;   

BEGIN
 FOR x IN (SELECT id FROM early_alert WHERE person_id = (SELECT id FROM person WHERE school_id = $1)) LOOP

	FOR y IN (SELECT id FROM early_alert_response WHERE early_alert_id = x.id) LOOP
		DELETE FROM early_alert_response_early_alert_referral WHERE early_alert_response_id = y.id;
		DELETE FROM early_alert_response_early_alert_outreach WHERE early_alert_response_id = y.id;
	END LOOP;	
	DELETE FROM early_alert_response WHERE early_alert_id = x.id;
	DELETE FROM early_alert_early_alert_reason WHERE early_alert_id = x.id;
	DELETE FROM early_alert_early_alert_suggestion WHERE early_alert_id = x.id;	
 END LOOP;
END;

$$ LANGUAGE plpgsql;

--Function to Delete Individual Journal Entries

CREATE OR REPLACE FUNCTION deleteJournalEntries(text) RETURNS void AS $$

DECLARE
  w RECORD;    

BEGIN
 FOR w IN (SELECT id FROM journal_entry WHERE person_id = (SELECT id FROM person WHERE school_id = $1)) LOOP

     DELETE FROM journal_entry_detail WHERE journal_entry_id = w.id;
	
 END LOOP;
END;

$$ LANGUAGE plpgsql;

--Function to Delete Individual Map Plans

CREATE OR REPLACE FUNCTION deleteMapPlans(text) RETURNS void AS $$

DECLARE
  z RECORD;    

BEGIN
 FOR z IN (SELECT id FROM map_plan WHERE person_id = (SELECT id FROM person WHERE school_id = $1)) LOOP

     DELETE FROM map_plan_course WHERE plan_id = z.id;
     DELETE FROM map_term_note WHERE plan_id = z.id;	
 END LOOP;
END;

$$ LANGUAGE plpgsql;



--Delete Students Internal

DELETE FROM person_challenge WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM person_confidentiality_disclosure_agreement WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM person_disability_accommodation WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM person_disability_agency WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM person_disability_type WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM person_education_level WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM person_funding_source WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM person_program_status WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM person_referral_source WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM person_service_reason WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM person_special_service_group WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM person_tool WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM task WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
DELETE FROM goal WHERE person_id = (SELECT id FROM person where school_id = 'NEWSTUDENT1');
SELECT deleteJournalEntries('NEWSTUDENT1');
DELETE FROM journal_entry WHERE person_id = (SELECT id FROM person where school_id = 'NEWSTUDENT1');
SELECT deleteEarlyAlerts('NEWSTUDENT1');
DELETE FROM early_alert WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');
SELECT deleteMapPlans('NEWSTUDENT1');
DELETE FROM map_plan WHERE person_id = (SELECT id FROM person WHERE school_id = 'NEWSTUDENT1');

DELETE FROM person WHERE school_id = 'NEWSTUDENT1';

DELETE FROM person_challenge WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM person_confidentiality_disclosure_agreement WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM person_disability_accommodation WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM person_disability_agency WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM person_disability_type WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM person_education_level WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM person_funding_source WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM person_program_status WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM person_referral_source WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM person_service_reason WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM person_special_service_group WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM person_tool WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM task WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
DELETE FROM goal WHERE person_id = (SELECT id FROM person where school_id = 'PROGRESSINGSTUDENT2');
SELECT deleteJournalEntries('PROGRESSINGSTUDENT2');
DELETE FROM journal_entry WHERE person_id = (SELECT id FROM person where school_id = 'PROGRESSINGSTUDENT2');
SELECT deleteEarlyAlerts('PROGRESSINGSTUDENT2');
DELETE FROM early_alert WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');
SELECT deleteMapPlans('PROGRESSINGSTUDENT2');
DELETE FROM map_plan WHERE person_id = (SELECT id FROM person WHERE school_id = 'PROGRESSINGSTUDENT2');

DELETE FROM person WHERE school_id = 'PROGRESSINGSTUDENT2';

DELETE FROM person_challenge WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM person_confidentiality_disclosure_agreement WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM person_disability_accommodation WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM person_disability_agency WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM person_disability_type WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM person_education_level WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM person_funding_source WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM person_program_status WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM person_referral_source WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM person_service_reason WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM person_special_service_group WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM person_tool WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM task WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
DELETE FROM goal WHERE person_id = (SELECT id FROM person where school_id = 'STRUGGLINGSTUDENT3');
SELECT deleteJournalEntries('STRUGGLINGSTUDENT3');
DELETE FROM journal_entry WHERE person_id = (SELECT id FROM person where school_id = 'STRUGGLINGSTUDENT3');
SELECT deleteEarlyAlerts('STRUGGLINGSTUDENT3');
DELETE FROM early_alert WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');
SELECT deleteMapPlans('STRUGGLINGSTUDENT3');
DELETE FROM map_plan WHERE person_id = (SELECT id FROM person WHERE school_id = 'STRUGGLINGSTUDENT3');

DELETE FROM person WHERE school_id = 'STRUGGLINGSTUDENT3';

--Take care of impending conflicts 

DELETE FROM person_demographics WHERE id = (SELECT person_demographics_id FROM person WHERE username = 'NEWSTUDENT1');
DELETE FROM person_demographics WHERE id = (SELECT person_demographics_id FROM person WHERE username = 'PROGRESSINGSTUDENT2');
DELETE FROM person_demographics WHERE id = (SELECT person_demographics_id FROM person WHERE username = 'STRUGGLINGSTUDENT3');

DELETE FROM person_education_goal WHERE id = (SELECT person_education_goal_id FROM person WHERE username = 'NEWSTUDENT1');
DELETE FROM person_education_goal WHERE id = (SELECT person_education_goal_id FROM person WHERE username = 'PROGRESSINGSTUDENT2');
DELETE FROM person_education_goal WHERE id = (SELECT person_education_goal_id FROM person WHERE username = 'STRUGGLINGSTUDENT3');

DELETE FROM person_staff_details WHERE id = (SELECT person_staff_details_id FROM person WHERE username = 'NEWSTUDENT1');
DELETE FROM person_staff_details WHERE id = (SELECT person_staff_details_id FROM person WHERE username = 'PROGRESSINGSTUDENT2');
DELETE FROM person_staff_details WHERE id = (SELECT person_staff_details_id FROM person WHERE username = 'STRUGGLINGSTUDENT3');

DELETE FROM person_education_plan WHERE id = (SELECT person_education_plan_id FROM person WHERE username = 'NEWSTUDENT1');
DELETE FROM person_education_plan WHERE id = (SELECT person_education_plan_id FROM person WHERE username = 'PROGRESSINGSTUDENT2');
DELETE FROM person_education_plan WHERE id = (SELECT person_education_plan_id FROM person WHERE username = 'STRUGGLINGSTUDENT3');

DELETE FROM person_disability WHERE id = (SELECT person_disability_id FROM person WHERE username = 'NEWSTUDENT1');
DELETE FROM person_disability WHERE id = (SELECT person_disability_id FROM person WHERE username = 'PROGRESSINGSTUDENT2');
DELETE FROM person_disability WHERE id = (SELECT person_disability_id FROM person WHERE username = 'STRUGGLINGSTUDENT3');

DELETE FROM person_demographics WHERE id NOT IN (SELECT person_demographics_id FROM person);
DELETE FROM person_education_goal WHERE id NOT IN (SELECT person_education_goal_id FROM person);
DELETE FROM person_staff_details WHERE id NOT IN (SELECT person_staff_details_id FROM person);
DELETE FROM person_education_plan WHERE id NOT IN (SELECT person_education_plan_id FROM person);
DELETE FROM person_disability WHERE id NOT IN (SELECT person_disability_id FROM person);

DELETE FROM person_demographics WHERE created_by = (SELECT id FROM person WHERE username = 'COACHUSERNAME') ;
DELETE FROM person_education_goal WHERE created_by = (SELECT id FROM person WHERE username = 'COACHUSERNAME') ;
DELETE FROM person_staff_details WHERE created_by = (SELECT id FROM person WHERE username = 'COACHUSERNAME') ;
DELETE FROM person_education_plan WHERE created_by = (SELECT id FROM person WHERE username = 'COACHUSERNAME') ;
DELETE FROM person_disability WHERE created_by = (SELECT id FROM person WHERE username = 'COACHUSERNAME') ;


--Delete External Data

DELETE FROM external_faculty_course WHERE faculty_school_id = 'USERNAME';
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


--Delete Student Users From Platform

SELECT deleteUsersFromPlatform('NEWSTUDENT1');
SELECT deleteUsersFromPlatform('PROGRESSINGSTUDENT2');
SELECT deleteUsersFromPlatform('STRUGGLINGSTUDENT3');


--Delete User/Coach From Platform

SELECT deleteUsersFromPlatform('COACHUSERNAME');

  
--End Delete Users And Students From SSP Training Script
