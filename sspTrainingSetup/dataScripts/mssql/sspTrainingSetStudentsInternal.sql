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
 * *** SSP TRAINING SET INTERNAL STUDENT DATA FOR 3 USE CASE STUDENTS MSSQL Version***
 *
 * This SQL File sets 3 high quality use case students for an assigned coach. 
 *
 * To use this file substitute the placeholders below via some other script
 *  or manually with the 3 names of the students you wish to reset. 
 *
 * Substitute: 
 *	$(NEWSTUDENT1) = usernname of the New Student Use Case
 *	$(PROGRESSINGSTUDENT2) = school_id of the Progressing Student Use Case
 *	$(STRUGGLINGSTUDENT3) = school_id of the Struggling Student Use Case
 *	TASKID# = id (primary key) for task (There are 5 so $(TASKID1) ...) Needs to be random and unique. *     
 *	YEAR# = the year(s) to use in the script (There are 3 and $(YEAR3) usually is equal to the current year).
 *          Note: Added YEAR4, YEAR5, YEAR6 for map future terms!  
 *      $(COACHID) = id for coach (foreign key to person table)
 *
 * Note: Requires MSSQL 2008 or higher 
 *
 */

--Function to Delete Individual Early Alerts 
/*
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

     DELETE FROM map_plan_elective_course_electives WHERE map_plan_elective_course_id = (SELECT id FROM map_plan_elective_course WHERE plan_id = z.id);
     DELETE FROM map_plan_elective_course WHERE plan_id = z.id;
     DELETE FROM map_plan_course WHERE plan_id = z.id;
     DELETE FROM map_term_note WHERE plan_id = z.id;	
 END LOOP;
END;

$$ LANGUAGE plpgsql;
*/


--*** DELETES CAN BE COMMENTED OUT FOR FRESH DB ***
/*
DELETE FROM person_challenge WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM person_confidentiality_disclosure_agreement WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM person_disability_accommodation WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM person_disability_agency WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM person_disability_type WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM person_education_level WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM person_funding_source WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM person_program_status WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM person_referral_source WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM person_service_reason WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM person_special_service_group WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM person_tool WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM strength WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM appointment WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM task WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
DELETE FROM goal WHERE person_id = (SELECT id FROM person where school_id = '$(NEWSTUDENT1)');
SELECT deleteJournalEntries('$(NEWSTUDENT1)');
DELETE FROM journal_entry WHERE person_id = (SELECT id FROM person where school_id = '$(NEWSTUDENT1)');
SELECT deleteEarlyAlerts('$(NEWSTUDENT1)');
DELETE FROM early_alert WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');
SELECT deleteMapPlans('$(NEWSTUDENT1)');
DELETE FROM map_plan WHERE person_id = (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)');

DELETE FROM person WHERE school_id = '$(NEWSTUDENT1)';


DELETE FROM person_challenge WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM person_confidentiality_disclosure_agreement WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM person_disability_accommodation WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM person_disability_agency WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM person_disability_type WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM person_education_level WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM person_funding_source WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM person_program_status WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM person_referral_source WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM person_service_reason WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM person_special_service_group WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM person_tool WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM appointment WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM strength WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM task WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
DELETE FROM goal WHERE person_id = (SELECT id FROM person where school_id = '$(PROGRESSINGSTUDENT2)');
SELECT deleteJournalEntries('$(PROGRESSINGSTUDENT2)');
DELETE FROM journal_entry WHERE person_id = (SELECT id FROM person where school_id = '$(PROGRESSINGSTUDENT2)');
SELECT deleteEarlyAlerts('$(PROGRESSINGSTUDENT2)');
DELETE FROM early_alert WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');
SELECT deleteMapPlans('$(PROGRESSINGSTUDENT2)');
DELETE FROM map_plan WHERE person_id = (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)');

DELETE FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)';


DELETE FROM person_challenge WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM person_confidentiality_disclosure_agreement WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM person_disability_accommodation WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM person_disability_agency WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM person_disability_type WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM person_education_level WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM person_funding_source WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM person_program_status WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM person_referral_source WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM person_service_reason WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM person_special_service_group WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM person_tool WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM strength WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM appointment WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM task WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
DELETE FROM goal WHERE person_id = (SELECT id FROM person where school_id = '$(STRUGGLINGSTUDENT3)');
SELECT deleteJournalEntries('$(STRUGGLINGSTUDENT3)');
DELETE FROM journal_entry WHERE person_id = (SELECT id FROM person where school_id = '$(STRUGGLINGSTUDENT3)');
SELECT deleteEarlyAlerts('$(STRUGGLINGSTUDENT3)');
DELETE FROM early_alert WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');
SELECT deleteMapPlans('$(STRUGGLINGSTUDENT3)');
DELETE FROM map_plan WHERE person_id = (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)');

DELETE FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)';


  --Take care of impending conflicts otherwise leave until db refresh
DELETE FROM person_demographics WHERE id NOT IN (SELECT person_demographics_id FROM person);
DELETE FROM person_education_goal WHERE id NOT IN (SELECT person_education_goal_id FROM person);
DELETE FROM person_staff_details WHERE id NOT IN (SELECT person_staff_details_id FROM person);
DELETE FROM person_education_plan WHERE id NOT IN (SELECT person_education_plan_id FROM person);
DELETE FROM person_disability WHERE id NOT IN (SELECT person_disability_id FROM person);
*/
--*** END DELETES ***







--Individual Student Use Case Refresh




--$(NEWSTUDENT1)

INSERT INTO person_demographics(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            local, primary_caregiver, child_care_needed, employed, country_of_residence, 
            payment_status, country_of_citizenship, number_of_children, child_ages, 
            place_of_employment, wage, total_hours_worked_per_week, shift, 
            gender, marital_status_id, ethnicity_id, citizenship_id, veteran_status_id, 
            child_care_arrangement_id, balance_owed, military_affiliation_id, race_id)
    VALUES ('$(TASKID1)', '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1','0', '0', '0', '0', 'US', 'Good', 'US', 0, null, null, null, null, null, 'M', 'c1d6598e-622d-428c-b7c2-1c4283d73126', 'ff149156-a02f-4e9d-bfb2-ef9dfb32eef2', '53c5efe6-c149-45d3-a719-6c8f1ac2e056', '8d1bb38c-5670-469d-96a5-b8a79ae7856f', null, null, '7c7df05a-92c2-4806-93c7-5b8d99d42657', null);


INSERT INTO person_disability(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            disability_status_id, intake_counselor, referred_by, contact_name, 
            release_signed, records_requested, records_requested_contact, 
            refer_for_screening, documents_requested_contact, rights_and_duties, 
            eligible_letter_sent, eligible_letter_date, ineligible_letter_sent, 
            ineligible_letter_date, no_documentation, inadequate_documentation, 
            no_disability, no_special_ed, temp_eligibility_description, on_medication, 
            medication_list, functional_limitations)
    VALUES ('$(TASKID1)', '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
	    'c2609cdf-6aa2-4948-b0e3-3779f2541783', null, null, null, '0', '0', null, '0', null, null, 
            '0', null, '0', null, '0', '0', '0', '0', null, '0', null, null);


INSERT INTO person_education_goal(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            description, planned_occupation, how_sure_about_major, education_goal_id, 
            military_branch_description, planned_major, career_decided, how_sure_about_occupation, 
            confident_in_abilities, additional_academic_program_information_needed, 
            course_work_weekly_hours_name, registration_load_name, anticipated_graduation_date_term_code)
    VALUES ('$(TASKID1)', '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            null, null, 0, null, 'Marines', null, '0', 0, '0', '0', null, null, null);

INSERT INTO person_education_plan(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            new_orientation_complete, registered_for_classes, college_degree_for_parents, 
            special_needs, grade_typically_earned, student_status_id)
    VALUES ('$(TASKID1)', '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            '0', '0', '0', '1', '3', '0b150cea-c3de-40ef-8564-fc2f53847a43');

 
INSERT INTO person(id, first_name, middle_name, last_name, birth_date, primary_email_address,            secondary_email_address, username, home_phone, work_phone, cell_phone, address_line_1, address_line_2, city, state, zip_code, photo_url, school_id, enabled, created_date, modified_date, created_by,modified_by, object_status, person_demographics_id, person_education_goal_id, person_education_plan_id, coach_id, ability_to_benefit, 
            anticipated_start_term, anticipated_start_year, student_intake_request_date,student_type_id, student_intake_complete_date, person_staff_details_id,actual_start_year, actual_start_term, non_local_address, alternate_address_in_use,alternate_address_line_1, alternate_address_line_2, alternate_address_city,alternate_address_state, alternate_address_zip_code, alternate_address_country,person_disability_id, f1_status, residency_county, person_class,secret,oauth2_client_access_token_validity_seconds, campus_id)
VALUES ((SELECT NEWID()), (SELECT first_name FROM external_person WHERE school_id = '$(NEWSTUDENT1)'), 
	    (SELECT middle_name FROM external_person WHERE school_id = '$(NEWSTUDENT1)'), 
	    (SELECT last_name FROM external_person WHERE school_id = '$(NEWSTUDENT1)'), 
	    (SELECT birth_date FROM external_person WHERE school_id = '$(NEWSTUDENT1)'), 
	    'demostudent@testdrivessp.com', 'seconddemostudent@testdrivessp.com', '$(NEWSTUDENT1)','(555) 555-7891', '(555) 555-3214', '(555) 555-3214','357 W. Demo St.', 'Apt. 2315', 'Phoenix', 'AZ','55555', '/ssp/images/demoAvatars/male_30.jpg','$(NEWSTUDENT1)', '1', '$(YEAR2)-08-20', '$(YEAR2)-08-20','$(COACHID)','$(COACHID)', '1', '$(TASKID1)', '$(TASKID1)', '$(TASKID1)', '$(COACHID)', '1', 'SP$(YEAR3)', '$(YEAR3)', null, '0a640a2a-409d-1271-8140-d0afceae00f1', '$(YEAR3)-09-13 09:22:00.091', null,'$(YEAR3)', 'SP$(YEAR3)', 1 , 1, '157 N. Demo2 St.', 'Apt. 392', 'Tucson', 'AZ', '55555', 'United States', '$(TASKID1)', 'Y', 'DemoCounty','user', null, null, (SELECT TOP 1 id FROM campus ORDER BY NEWID()));
	    

INSERT INTO appointment(id, created_date, modified_date, created_by, modified_by, object_status, person_id, start_time, end_time, attended) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(YEAR3)-09-23 09:00:00.092', '$(YEAR3)-09-23 012:00:00.092', 'false');


INSERT INTO strength(id, name, description, created_date, modified_date, created_by, modified_by, confidentiality_level_id, object_status, person_id)
VALUES ((SELECT NEWID()), 'Primary Strength', 'Student is good at x, y, and z.', '$(YEAR3)-08-20', '$(YEAR3)-08-20', '$(COACHID)','$(COACHID)', 'b3d077a7-4055-0510-7967-4a09f93a0357', '1', (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'));


INSERT INTO person_challenge(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, challenge_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'Child of Adult Care', '07b5c3ac-3bdf-4d12-b65d-94cb55167998');

INSERT INTO person_challenge(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, challenge_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'Personal Finance Help', '70693703-b2c1-4d3c-b79f-e43e93393b8c');

INSERT INTO person_challenge(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, challenge_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'Grief and Loss Counseling', '22d23035-74f0-40f1-ac41-47a22c798af7');

INSERT INTO person_challenge(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, challenge_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'Computer and Email Assistance', 'f067c6ca-50ad-447a-ad12-f47dffdce42e');


INSERT INTO person_disability_accommodation(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, disability_accommodation_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'Tbd', '3761d6a4-6f71-4c88-a1d7-f9bea7079346');

INSERT INTO person_disability_agency(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, disability_agency_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'MH', '02aa9557-c8f1-4716-bbae-2b3401e386f6');

INSERT INTO person_disability_agency(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, disability_agency_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'Other', '224b03d9-90da-4f9c-8959-ea2e97661f40');

INSERT INTO person_disability_type(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, disability_type_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'OR', '960e507a-2c82-4d6e-bf55-b12e4f0a3a86');
            
INSERT INTO person_funding_source(id, created_date, modified_date, created_by, modified_by, object_status, person_id, description, funding_source_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'Financial Aid', '41358be9-c202-4dda-b8ab-99cba9a9432f');

INSERT INTO person_funding_source(id, created_date, modified_date, created_by, modified_by, object_status, person_id, description, funding_source_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'GI Bill', 'db26cf97-02af-493a-a0e4-d3f7fa08629f');

INSERT INTO person_funding_source(id, created_date, modified_date, created_by, modified_by, object_status, person_id, description, funding_source_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'Military Aid', '80372221-b00b-4977-8c22-f908697b2762');

INSERT INTO person_education_level(id, created_date, modified_date, created_by, modified_by, object_status, person_id, description, education_level_id, last_year_attended, highest_grade_completed, graduated_year, school_name)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'NewStudent/Transfer/Pre-College', 'c5111182-9e2f-4252-bb61-d2cfa9700af7', '$(YEAR2)', '12', '$(YEAR2)', 'Former School');

INSERT INTO person_program_status(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            program_status_id, program_status_change_reason_id, person_id, 
            effective_date, expiration_date)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',  
            'b2d12527-5056-a51a-8054-113116baab88', null, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 
            '$(YEAR2)-09-13 09:22:00.092', null);

INSERT INTO person_referral_source(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, referral_source_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'ccadd634-bd7a-11e1-8d28-3368721922dc');


INSERT INTO person_service_reason(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, service_reason_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '8576ff78-1326-11e2-940d-406c8f22c3ce');

INSERT INTO person_service_reason(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, service_reason_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '205df6c0-fea0-11e1-9678-406c8f22c3ce');

INSERT INTO person_service_reason(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, service_reason_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '0a640a2a-409d-1271-8140-d0b5037600f9');

INSERT INTO person_special_service_group(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, special_service_group_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '0a640a2a-409d-1271-8140-d0c138a100fd');

INSERT INTO person_special_service_group(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, special_service_group_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 'f6201a04-bb31-4ca5-b606-609f3ad09f87');


INSERT INTO goal(id, name, description, created_date, modified_date, created_by,modified_by, 
confidentiality_level_id, object_status, person_id)
VALUES ('$(TASKID1)', 'Get an Associates Degree', 'Graduate with an Associates Degree.', 
'$(YEAR2)-08-21 13:30:41.066', '$(YEAR2)-08-21 13:30:41.066', '$(COACHID)','$(COACHID)', 'b3d077a7-4055-0510-7967-4a09f93a0357', 
'1', (SELECT id FROM person WHERE school_id ='$(NEWSTUDENT1)'));

INSERT INTO journal_entry(id, created_date, modified_date, created_by, modified_by, object_status, 
entry_date, comment, confidentiality_level_id, journal_source_id, journal_track_id, person_id)
VALUES ('$(TASKID2)', '$(YEAR3)-02-15 08:45:36.504', '$(YEAR3)-02-28 13:32:36.504', '$(COACHID)', '$(COACHID)', '1', '$(YEAR3)-02-09 07:05:49.566',' Summary:
Early Alert Course: MAT085
Early Alert Created Date: Feb 09 12:01:43 MST YEAR3

Response Created by: Coach
Response Details:
Outcome: Waiting for Response
Outreach: Phone Call
Comment: Talked with student.', 'b3d077a7-4055-0510-7967-4a09f93a0357', 
'b2d07a00-5056-a51a-80b5-f725f1c5c3e2', 'b2d07b38-5056-a51a-809d-81ea2f3b27bf', (SELECT id FROM person WHERE school_id ='$(NEWSTUDENT1)'));


INSERT INTO early_alert(id, created_date, modified_date, created_by, modified_by, 
object_status,course_name, course_title, email_cc, person_id, early_alert_reason_other_description, comment, campus_id, early_alert_suggestion_other_description, course_term_code, faculty_school_id, enrollment_status)
VALUES ('$(TASKID1)','$(YEAR3)-02-12 12:45:29.044','$(YEAR3)-02-15 10:45:29.044',
(SELECT id FROM person WHERE id = '$(COACHID)'),
(SELECT id FROM person WHERE id = '$(COACHID)'),1,'MAT085','Introductory Algebra', 'demo1@sspTraining.edu',
(SELECT id FROM person WHERE school_id='$(NEWSTUDENT1)'), 'Student has continuing abscences',
'Concerned about excessive absences.','901e104b-4dc7-43f5-a38e-581015e204e1', 'Suggest student attends class more or withdraws', 'SP$(YEAR2)', 'faculty1', 'E');


INSERT INTO map_plan(id, created_date, modified_date, created_by, modified_by, object_status,person_id, owner_id, name, contact_title, contact_phone, contact_email, contact_name, contact_notes, student_notes, based_on_template_id, is_financial_aid, is_important, is_f1_visa, academic_goals, career_link,academic_link, program_code, catalog_year_code)
VALUES ('$(TASKID1)', '$(YEAR3)-05-21 04:42:39.901', '$(YEAR3)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '1', 
	(SELECT id FROM person WHERE school_id ='$(NEWSTUDENT1)'), '$(COACHID)', 'Associates in Computer Science', 
'Academic Advisor', '555-555-1234', 'sample@sample.com', 'Coach', '', '', NULL, 1 , 0 , 0,'Graduate', 'http://www.unicon.net/opensource/student-success-plan', 'http://www.unicon.net/opensource/student-success-plan', 'CST-AS', (SELECT code FROM external_catalog_year WHERE name = '$(YEAR4)-$(YEAR5)'));

INSERT INTO map_term_note(id, created_date, modified_date, created_by, modified_by, plan_id, template_id, term_code, contact_notes, student_notes, is_important, object_status)
VALUES ((SELECT NEWID()), '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '$(TASKID1)', NULL, 'SP$(YEAR3)', 'This semester is important!', 'This semester is important, we want you to succeed in college!', 1 , 1);

INSERT INTO person_completed_item(id, person_id, completed_item_id, created_date, modified_date, created_by, modified_by, object_status)
VALUES ((SELECT NEWID()), (SELECT id FROM person WHERE school_id ='$(NEWSTUDENT1)'), (SELECT TOP 1 id FROM completed_item ORDER BY NEWID()), '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '1');

INSERT INTO person_confidentiality_disclosure_agreement(id, created_date, modified_date, created_by, modified_by, object_status, person_id, confidentiality_disclosure_agreement_id) 
VALUES ((SELECT NEWID()), '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id ='$(NEWSTUDENT1)'), '0a640a2a-409d-1271-8140-a23f925500dc');

INSERT INTO person_tool(id, created_date, modified_date, created_by, modified_by, object_status, person_id, tool)
VALUES ((SELECT NEWID()), '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id ='$(NEWSTUDENT1)'), 'INTAKE');






--PROGRESSINGSTUDENT2

INSERT INTO person_demographics(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            local, primary_caregiver, child_care_needed, employed, country_of_residence, 
            payment_status, country_of_citizenship, number_of_children, child_ages, 
            place_of_employment, wage, total_hours_worked_per_week, shift, 
            gender, marital_status_id, ethnicity_id, citizenship_id, veteran_status_id, 
            child_care_arrangement_id, balance_owed, military_affiliation_id, race_id)
    VALUES ('$(TASKID2)', '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            '1', '1', '1', '1', 'US', 
            'Good', 'US', 2, '1,2', 
            'Widget Company', '9.00/hr', '24', 'SECOND', 
            'F', 'f415d6c7-9723-42ea-8bb6-9417ca8fec6f', 'ff149156-a02f-4e9d-bfb2-ef9dfb32eef2', '53c5efe6-c149-45d3-a719-6c8f1ac2e056', 
	    '8d1bb38c-5670-469d-96a5-b8a79ae7856f', '3ee60d0a-4ba3-48a7-ac4b-89595bd10636', '0.00', null, 'dec0364a-d576-424d-94ce-79544c21e8c8');


INSERT INTO person_disability(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            disability_status_id, intake_counselor, referred_by, contact_name, 
            release_signed, records_requested, records_requested_contact, 
            refer_for_screening, documents_requested_contact, rights_and_duties, 
            eligible_letter_sent, eligible_letter_date, ineligible_letter_sent, 
            ineligible_letter_date, no_documentation, inadequate_documentation, 
            no_disability, no_special_ed, temp_eligibility_description, on_medication, 
            medication_list, functional_limitations)
    VALUES ('$(TASKID2)', '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
	    'e0208429-aeb2-4854-ab7c-3c9281c96002', null, null, null, '0', '0', null, '0', null, null, 
            '0', null, '0', null, '0', '0', '0', '0', null, '0', null, null);


INSERT INTO person_education_goal(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            description, planned_occupation, how_sure_about_major, education_goal_id, 
            military_branch_description, planned_major, career_decided, how_sure_about_occupation, 
            confident_in_abilities, additional_academic_program_information_needed, 
            course_work_weekly_hours_name, registration_load_name, anticipated_graduation_date_term_code, coursework_hours_id, registration_load_id)
    VALUES ('$(TASKID2)', '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            'Having Fun and Enjoying School', 'Software Developer', 4, '78b54da7-fb19-4092-bb44-f60485678d6b', null, 'Computer Science', '1', 3, '1', '1', 
		'16-20', '13 or Above', 'SP$(YEAR6)', '24efd91a-0a06-4f8c-a910-de2f4225e618', 'ac85ac8e-90e6-4425-b74e-7e8b0c7bee7a');


INSERT INTO person_education_plan(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            new_orientation_complete, registered_for_classes, college_degree_for_parents, 
            special_needs, grade_typically_earned, student_status_id)
    VALUES ('$(TASKID2)', '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            '1', '1', '1', '0', '1', 'eac2ecfc-6c32-45ed-b70d-0b23b06cfa74');

INSERT INTO person(   
	    id, first_name, middle_name, last_name, birth_date, primary_email_address, 
            secondary_email_address, username, home_phone, work_phone, cell_phone, 
            address_line_1, address_line_2, city, state, zip_code, photo_url, 
            school_id, enabled, created_date, modified_date, created_by, 
            modified_by, object_status, person_demographics_id, person_education_goal_id, 
            person_education_plan_id, coach_id, ability_to_benefit, 
            anticipated_start_term, anticipated_start_year, student_intake_request_date, 
            student_type_id, student_intake_complete_date, person_staff_details_id, 
            actual_start_year, actual_start_term, non_local_address, alternate_address_in_use, 
            alternate_address_line_1, alternate_address_line_2, alternate_address_city, 
            alternate_address_state, alternate_address_zip_code, alternate_address_country, 
            person_disability_id, f1_status, residency_county, person_class, 
            secret, oauth2_client_access_token_validity_seconds, campus_id)
VALUES ( (SELECT NEWID()), (SELECT first_name FROM external_person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
    (SELECT middle_name FROM external_person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
    (SELECT last_name FROM external_person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
    (SELECT birth_date FROM external_person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
    'demo2@testdrivessp.com', 'seconddemo2@testdrivessp.com', '$(PROGRESSINGSTUDENT2)','(555) 555-5412', '(555) 555-5555', '(555) 555-5555','321 W. Demo St.', 'Apt. 222', 'Phoenix', 'AZ', 
'55555', '/ssp/images/demoAvatars/female_33.jpg','$(PROGRESSINGSTUDENT2)', '1', '$(YEAR1)-08-20', '$(YEAR1)-08-20', '$(COACHID)', 
    '$(COACHID)', '1', '$(TASKID2)', '$(TASKID2)', '$(TASKID2)', '$(COACHID)', '1', 
    'FA$(YEAR1)', '$(YEAR1)', null, 
    'b2d05919-5056-a51a-80bd-03e5288de771', '$(YEAR1)-09-13 09:22:00.091', null, 
    '$(YEAR1)', 'FA$(YEAR1)', '0', '0', '', '', '', '', '', '', '$(TASKID2)', 'Y', 'DemoCounty','user', null, null, (SELECT TOP 1 id FROM campus ORDER BY NEWID()));


INSERT INTO appointment(id, created_date, modified_date, created_by, modified_by, object_status, person_id, start_time, end_time, attended) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(YEAR3)-09-23 09:00:00.092', '$(YEAR3)-09-23 012:00:00.092', 'false');


INSERT INTO strength(id, name, description, created_date, modified_date, created_by, modified_by, confidentiality_level_id, object_status, person_id)
VALUES ((SELECT NEWID()), 'Primary Strength', 'She has strengths in writing, math, and work ethic.', '$(YEAR2)-08-20', '$(YEAR2)-08-20', '$(COACHID)','$(COACHID)', 'b3d077a7-4055-0510-7967-4a09f93a0357', '1', (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'));


INSERT INTO person_challenge(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, challenge_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 'Child and Adult Care', '07b5c3ac-3bdf-4d12-b65d-94cb55167998');

INSERT INTO person_disability_accommodation(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, disability_accommodation_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',  
            (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), null, '1f18e705-187a-447d-8f03-8814fc854fc6');

INSERT INTO person_disability_agency(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, disability_agency_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',   
            (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), null, '7845fdea-9da7-49be-a3cf-c9da03c38d56');

INSERT INTO person_disability_agency(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, disability_agency_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',   
            (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), null, '7f92b5bb-8e9c-44c7-88fd-2ffdce68ef98');

INSERT INTO person_disability_type(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, disability_type_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',  
            (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 'Other', '4afd60bf-a5ea-4215-abb9-8276a6b68827');
            
INSERT INTO person_funding_source(id, created_date, modified_date, created_by, modified_by, object_status, person_id, description, funding_source_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 'Financial Aid', '41358be9-c202-4dda-b8ab-99cba9a9432f');

INSERT INTO person_education_level(id, created_date, modified_date, created_by, modified_by, object_status, person_id, description, education_level_id, last_year_attended, highest_grade_completed, graduated_year, school_name)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 'Current Student - Changed Majors', 'c5111182-9e2f-4252-bb61-d2cfa9700af7', '$(YEAR1)', '14', '$(YEAR1)', 'Former School');
            

INSERT INTO person_program_status(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            program_status_id, program_status_change_reason_id, person_id, 
            effective_date, expiration_date)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',  
            'b2d12527-5056-a51a-8054-113116baab88', null, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
            '$(YEAR2)-09-13 09:22:00.092', null);

INSERT INTO person_service_reason(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, service_reason_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',  
            (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '205df6c0-fea0-11e1-9678-406c8f22c3ce');

INSERT INTO person_service_reason(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, service_reason_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',  
            (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '0a640a2a-409d-1271-8140-d0b5037600f9');

INSERT INTO person_service_reason(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, service_reason_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',  
            (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '0a640a2a-409d-1271-8140-d0b3878000f6');

INSERT INTO person_special_service_group(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, special_service_group_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',  
            (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '0a640a2a-409d-1271-8140-d0c1cdf500ff');

INSERT INTO person_special_service_group(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, special_service_group_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',  
            (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '40b6b8aa-bca1-11e1-9344-037cb4088c72');


INSERT INTO journal_entry(id, created_date, modified_date, created_by, modified_by, object_status, entry_date, 
comment, confidentiality_level_id, journal_source_id, journal_track_id, person_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-04-25 14:55:30.682', '$(YEAR3)-04-26 13:55:30.682', '$(COACHID)', '$(COACHID)', '1', 
'$(YEAR3)-04-19 15:05:49.566', 'Discussed Career Coaching.', 'b3d077a7-4055-0510-7967-4a09f93a0357', 'b2d07973-5056-a51a-8073-1d3641ce507f', 
'0a640a2a-409d-1271-8140-d10d65990119', (SELECT id FROM person WHERE school_id ='$(PROGRESSINGSTUDENT2)'));


INSERT INTO goal(id, name, description, created_date, modified_date, created_by,modified_by, confidentiality_level_id, object_status, person_id)
VALUES ((SELECT NEWID()), 'Graduate College', 
'Student wishes to graduate college with a Bachelors degree after completing her associates degree in Computing and work as a Software Developer.', 
'$(YEAR2)-08-21 13:30:41.066', '$(YEAR2)-08-21 13:30:41.066', '$(COACHID)','$(COACHID)', 'b3d077a7-4055-0510-7967-4a09f93a0357', '1', 
(SELECT id FROM person WHERE school_id ='$(PROGRESSINGSTUDENT2)'));


INSERT INTO task(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            description, due_date, completed_date, reminder_sent_date, session_id, 
            person_id, challenge_id, challenge_referral_id, name, confidentiality_level_id, 
            deletable, link)
    VALUES ('$(TASKID3)','$(YEAR2)-12-05 12:26:59.929','$(YEAR2)-12-05 13:17:21.943',
	'$(COACHID)','$(COACHID)',1,
	'If you have Pell Grant visit the Bookstore within the first 2 weeks to transfer up to $100 per quarter of your financial aid award to your College ID card to purchase bus pass(es) academic expenses and daily expenses at College.',
	'$(YEAR2)-12-05','$(YEAR2)-12-05 13:17:21.833','$(YEAR2)-12-05 01:00:00.296','',
	(SELECT id FROM person WHERE school_id ='$(PROGRESSINGSTUDENT2)'),'7c0e5b76-9933-484a-b265-58cb280305a5',
	'db9229fe-2511-4939-8f9a-18d17e674e0c','Pell Transfer to Student Card','b3d077a7-4055-0510-7967-4a09f93a0357', 0, '');

INSERT INTO task(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            description, due_date, completed_date, reminder_sent_date, session_id, 
            person_id, challenge_id, challenge_referral_id, name, confidentiality_level_id, 
            deletable, link)
    VALUES ('$(TASKID4)','$(YEAR2)-12-05 12:27:33.466','$(YEAR3)-12-05 13:17:38.274',
	'$(COACHID)','$(COACHID)',1,
	'If financial aid file is complete and attend part-time apply in person (if student prior to 2006-2007) by taking fee bill to the Financial Aid Office in 10324 or call 512-3000. See Sarah.',
	'$(YEAR2)-12-05','$(YEAR2)-12-05 13:17:38.166','$(YEAR2)-12-05 01:00:00.331','',
	(SELECT id FROM person WHERE school_id ='$(PROGRESSINGSTUDENT2)'),'7c0e5b76-9933-484a-b265-58cb280305a5',
	'c72ef7ef-ea06-4282-92ad-17153e136bb5',
	'Part-time College Opportunity Grant (OCOG)','b3d077a7-4055-0510-7967-4a09f93a0357', 0, '');


INSERT INTO task(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            description, due_date, session_id, 
            person_id, challenge_id, challenge_referral_id, name, confidentiality_level_id, 
            deletable, link)
    VALUES ('$(TASKID2)','$(YEAR3)-09-09 14:10:21.732','$(YEAR3)-09-09 14:10:21.732',
	'$(COACHID)','$(COACHID)',1,
	'Follow up with career coach and discuss how your new path is going. ','$(YEAR3)-10-23','',
	(SELECT id FROM person WHERE school_id ='$(PROGRESSINGSTUDENT2)'),'1f5b63a9-9b50-412b-9971-23602f87444c',
	'eba6b6c1-7d62-4b3d-8f61-1722ce93418b','Career Coach','b3d077a7-4055-0510-7967-4a09f93a0357', 0, '');


INSERT INTO map_plan(id, created_date, modified_date, created_by, modified_by, object_status,person_id, owner_id, name, contact_title, contact_phone, contact_email, contact_name, contact_notes, student_notes, based_on_template_id, is_financial_aid, is_important, is_f1_visa, academic_goals, career_link,academic_link, program_code, catalog_year_code)
VALUES ('$(TASKID2)', '$(YEAR3)-05-21 04:42:39.901', '$(YEAR3)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '1', 
(SELECT id FROM person WHERE school_id ='$(PROGRESSINGSTUDENT2)'), '$(COACHID)', 'Associates in Computer Science', 'Academic Advisor', '555-555-1234', 'sample@sample.com', 'Coach', '', 'Keep up the great work!', NULL, 0 , 0, 0 , 'AS then Transfer to State U', 'http://www.unicon.net/opensource/student-success-plan', 'http://www.unicon.net/opensource/student-success-plan', 'CST-BS', (SELECT code FROM external_catalog_year WHERE name = '$(YEAR4)-$(YEAR5)'));

INSERT INTO map_term_note(id, created_date, modified_date, created_by, modified_by, plan_id, template_id, term_code, contact_notes, student_notes, is_important, object_status)
VALUES ((SELECT NEWID()), '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '$(TASKID2)', NULL, 'SP$(YEAR3)', 'This semester is important!', 'This semester is important as you have transitioned majors! Keep up the good work.', 1 , 1);


INSERT INTO person_completed_item(id, person_id, completed_item_id, created_date, modified_date, created_by, modified_by, object_status)
VALUES ((SELECT NEWID()), (SELECT id FROM person WHERE school_id ='$(PROGRESSINGSTUDENT2)'), (SELECT TOP 1 id FROM completed_item ORDER BY NEWID()), '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '1');

INSERT INTO person_confidentiality_disclosure_agreement(id, created_date, modified_date, created_by, modified_by, object_status, person_id, confidentiality_disclosure_agreement_id) 
VALUES ((SELECT NEWID()), '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id ='$(PROGRESSINGSTUDENT2)'), '0a640a2a-409d-1271-8140-a23f925500dc');

INSERT INTO person_tool(id, created_date, modified_date, created_by, modified_by, object_status, person_id, tool)
VALUES ((SELECT NEWID()), '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id ='$(PROGRESSINGSTUDENT2)'), 'INTAKE');



--STRUGGLINGSTUDENT3

INSERT INTO person_demographics(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            local, primary_caregiver, child_care_needed, employed, country_of_residence, 
            payment_status, country_of_citizenship, number_of_children, child_ages, 
            place_of_employment, wage, total_hours_worked_per_week, shift, 
            gender, marital_status_id, ethnicity_id, citizenship_id, veteran_status_id, 
            child_care_arrangement_id, balance_owed, military_affiliation_id, race_id)
    VALUES ('$(TASKID3)', '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
            '0', null, null, null, 'US', 
            'Good', 'US', 0, null, 
            null, null, '0', null, 
            'M', 'f415d6c7-9723-42ea-8bb6-9417ca8fec6f', 'fa80f025-5405-4355-9747-84dd3fa66df6', null, null, null, '0.00', null, null);


INSERT INTO person_disability(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            disability_status_id, intake_counselor, referred_by, contact_name, 
            release_signed, records_requested, records_requested_contact, 
            refer_for_screening, documents_requested_contact, rights_and_duties, 
            eligible_letter_sent, eligible_letter_date, ineligible_letter_sent, 
            ineligible_letter_date, no_documentation, inadequate_documentation, 
            no_disability, no_special_ed, temp_eligibility_description, on_medication, 
            medication_list, functional_limitations)
    VALUES ('$(TASKID3)', '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', 
	    '24d12b6f-1d58-4f13-ac5e-c09cd249ba43', null, null, null, '0', '0', null, '0', null, null, 
            '0', null, '0', null, '0', '0', '0', '0', null, '0', null, null);


INSERT INTO person(
	    id, first_name, middle_name, last_name, birth_date, primary_email_address, 
            secondary_email_address, username, home_phone, work_phone, cell_phone, 
            address_line_1, address_line_2, city, state, zip_code, photo_url, 
            school_id, enabled, created_date, modified_date, created_by, 
            modified_by, object_status, person_demographics_id, person_education_goal_id, 
            person_education_plan_id, coach_id, ability_to_benefit, 
            anticipated_start_term, anticipated_start_year, student_intake_request_date, 
            student_type_id, student_intake_complete_date, person_staff_details_id, 
            actual_start_year, actual_start_term, non_local_address, alternate_address_in_use, 
            alternate_address_line_1, alternate_address_line_2, alternate_address_city, 
            alternate_address_state, alternate_address_zip_code, alternate_address_country, 
            person_disability_id, f1_status, residency_county, person_class, 
            secret, oauth2_client_access_token_validity_seconds, campus_id)
VALUES ( (SELECT NEWID()), (SELECT first_name FROM external_person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
    (SELECT middle_name FROM external_person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
    (SELECT last_name FROM external_person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
    (SELECT birth_date FROM external_person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
    'demo3@testdrivessp.com', 'seconddemo3@testdrivessp.com', '$(STRUGGLINGSTUDENT3)','(555) 555-5122', '(555) 555-5555', '(555) 555-5555',
'312 N. Demo St.', 'Apt. 321', 'Phoenix', 'AZ', '55555', '/ssp/images/demoAvatars/male_20.jpg',
'$(STRUGGLINGSTUDENT3)', '1', '$(YEAR1)-08-20', '$(YEAR1)-08-20', '$(COACHID)', 
    '$(COACHID)', '1', '$(TASKID3)', null, null, '$(COACHID)', '1', 
    'FA$(YEAR1)', '$(YEAR1)', null, 
    'b2d05919-5056-a51a-80bd-03e5288de771', '$(YEAR1)-09-13 09:22:00.091', null, 
    '$(YEAR1)', 'FA$(YEAR1)', '0', '0', '', '', '', '', '', '', '$(TASKID3)', 'Y', 'DemoCounty', 'user', null, null, (SELECT TOP 1 id FROM campus ORDER BY NEWID()));

INSERT INTO appointment(id, created_date, modified_date, created_by, modified_by, object_status, person_id, start_time, end_time, attended) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), '$(YEAR3)-09-23 09:00:00.092', '$(YEAR3)-09-23 012:00:00.092', 'false');


INSERT INTO strength(id, name, description, created_date, modified_date, created_by, modified_by, confidentiality_level_id, object_status, person_id)
VALUES ((SELECT NEWID()), 'Primary Strength', 'None need to meet with student.', '$(YEAR2)-08-20', '$(YEAR2)-08-20', '$(COACHID)','$(COACHID)', 'b3d077a7-4055-0510-7967-4a09f93a0357', '1', (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'));



INSERT INTO person_disability_accommodation(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, disability_accommodation_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',  
            (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), null, '0412e725-05d7-4161-84cd-fd77f494583d');

INSERT INTO person_disability_agency(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, disability_agency_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), null, '02aa9557-c8f1-4716-bbae-2b3401e386f6');

INSERT INTO person_disability_agency(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, disability_agency_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), null, '224b03d9-90da-4f9c-8959-ea2e97661f40');

INSERT INTO person_disability_type(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, description, disability_type_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), null, '00df56f6-f673-42ed-b73d-d4bceda0d24b');
            
INSERT INTO person_funding_source(id, created_date, modified_date, created_by, modified_by, object_status, person_id, description, funding_source_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 'Assistance Needed', 'e2ca9893-c808-47ce-bea5-3b9d97ae6626');
            

INSERT INTO person_program_status(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            program_status_id, program_status_change_reason_id, person_id, 
            effective_date, expiration_date)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',  
            'b2d12527-5056-a51a-8054-113116baab88', 'b2d12844-5056-a51a-80c7-7059b24ccbce', (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
            '$(YEAR2)-09-13 09:22:00.092', null);

INSERT INTO person_referral_source(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, referral_source_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), '859ff107-1326-11e2-8698-406c8f22c3ce');


INSERT INTO person_service_reason(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, service_reason_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'),  'f6201a04-bb31-4ca5-b606-609f3ad09f87');

INSERT INTO person_service_reason(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, service_reason_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'),  '85709794-1326-11e2-8bab-406c8f22c3ce');

INSERT INTO person_service_reason(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, service_reason_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'),  '0a640a2a-409d-1271-8140-d0b3878000f6');

INSERT INTO person_service_reason(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, service_reason_id)  
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'),  '205df6c0-fea0-11e1-9678-406c8f22c3ce');

INSERT INTO person_special_service_group(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, special_service_group_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), '0a640a2a-409d-1271-8140-d0c138a100fd');

INSERT INTO person_special_service_group(
            id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, special_service_group_id)
    VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 09:22:00.092', '$(YEAR3)-09-13 09:22:00.092', '$(COACHID)', '$(COACHID)', '1',
            (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), '856a3600-1326-11e2-9b79-406c8f22c3ce');



INSERT INTO goal(id, name, description, created_date, modified_date, created_by,modified_by, confidentiality_level_id, object_status, person_id)
VALUES ((SELECT NEWID()), 'Get a Technical Degree', 'Graduate with a Technical Automotive Degree.', 
'$(YEAR2)-08-21 13:30:41.066', '$(YEAR2)-08-21 13:30:41.066', '$(COACHID)','$(COACHID)', 'b3d077a7-4055-0510-7967-4a09f93a0357', 
'1', (SELECT id FROM person WHERE school_id ='$(STRUGGLINGSTUDENT3)'));


INSERT INTO journal_entry(id, created_date, modified_date, created_by, modified_by, object_status, entry_date, comment, 
confidentiality_level_id, journal_source_id, journal_track_id, person_id)
VALUES ('$(TASKID5)', '$(YEAR2)-10-04 09:55:30.682', '$(YEAR2)-11-04 08:55:30.682', '$(COACHID)', '$(COACHID)', '1', '$(YEAR3)-09-04', 'Summary:
Early Alert Course: ENG055
Early Alert Created Date: Oct 04 09:41:43 MST YEAR2

Response Created by: Coach
Response Details:
Outcome: Student Responded
Outreach: In person visit
Referral: The Tutoring and Learning Center
Comment: Discussed low test scores.', 'b3d077a7-4055-0510-7967-4a09f93a0357', 'b2d07a00-5056-a51a-80b5-f725f1c5c3e2', 
'b2d07b38-5056-a51a-809d-81ea2f3b27bf', (SELECT id FROM person WHERE school_id ='$(STRUGGLINGSTUDENT3)'));

INSERT INTO journal_entry(id, created_date, modified_date, created_by, modified_by, object_status, entry_date, comment, 
confidentiality_level_id, journal_source_id, journal_track_id, person_id)
VALUES ('$(TASKID4)', '$(YEAR3)-03-03 13:55:30.682', '$(YEAR3)-03-10 12:55:30.682', '$(COACHID)', '$(COACHID)', '1', 
'$(YEAR3)-03-02 14:57:49.566',' Summary:
Early Alert Course: AUMT245
Early Alert Created Date: Mar 01 14:42:28 MST YEAR3

Response Created by: Coach
Response Details:
Outcome: Waiting for Response
Outreach: Email
Referral: Academic Counselors
Referral: Athletic Advisor
Comment: Waiting for response.', 'b3d077a7-4055-0510-7967-4a09f93a0357', 'b2d07a00-5056-a51a-80b5-f725f1c5c3e2', 
'b2d07b38-5056-a51a-809d-81ea2f3b27bf', (SELECT id FROM person WHERE school_id ='$(STRUGGLINGSTUDENT3)'));


INSERT INTO journal_entry(id, created_date, modified_date, created_by, modified_by, object_status, entry_date, 
comment, confidentiality_level_id, journal_source_id, journal_track_id, person_id)
VALUES ('$(TASKID3)', '$(YEAR3)-04-18 10:55:30.682', '$(YEAR3)-04-24 14:07:30.682', '$(COACHID)', '$(COACHID)', '1', 
'$(YEAR3)-04-15 12:05:49.566',' Summary:
Early Alert Course: ENG076
Early Alert Created Date: April 15 11:20:28 MST YEAR3

Response Created by: Coach
Response Details:
Outcome: Student Responded
Outreach: Phone Call
Comment: Student comments.', 'b3d077a7-4055-0510-7967-4a09f93a0357', 'b2d07a00-5056-a51a-80b5-f725f1c5c3e2', 
'b2d07b38-5056-a51a-809d-81ea2f3b27bf', (SELECT id FROM person WHERE school_id ='$(STRUGGLINGSTUDENT3)'));


INSERT INTO early_alert(id, created_date, modified_date, created_by, modified_by, object_status,course_name, 
course_title,person_id, comment, campus_id, course_term_code)
VALUES ('$(TASKID2)','$(YEAR2)-09-18 10:41:43.568','$(YEAR2)-09-21 09:41:43.568',
(SELECT id FROM person WHERE id = '$(COACHID)'),
(SELECT id FROM person WHERE id = '$(COACHID)'),1,'ENG055','College Reading I',
(SELECT id FROM person WHERE school_id ='$(STRUGGLINGSTUDENT3)'),
'Do to lack of attendance and low test scores, he should consider withdrawing from this class.','0a640a2a-409d-1271-8140-d10a51770117','FA$(YEAR1)');


INSERT INTO early_alert(id, created_date, modified_date, created_by, modified_by, object_status,course_name, course_title, person_id, early_alert_reason_other_description, comment, closed_date, closed_by_id, campus_id, early_alert_suggestion_other_description, course_term_code, faculty_school_id, enrollment_status)
VALUES ('$(TASKID3)','$(YEAR3)-03-01 09:41:43.568','$(YEAR3)-01-04 09:41:43.568',
(SELECT id FROM person WHERE id = '$(COACHID)'),
(SELECT id FROM person WHERE id = '$(COACHID)'),1,'AUMT245','Automotive Alternative Fuels',
(SELECT id FROM person WHERE school_id ='$(STRUGGLINGSTUDENT3)'),
'Bad grades and/or Attendance issues adn inability to follow instructions.', 'Please follow-up on other special concerns.','$(YEAR2)-09-04 09:58:27.887','$(COACHID)','901e104b-4dc7-43f5-a38e-581015e204e1', 'Possibly needs tutoring assistance or withdraw from this class.', 'SP$(YEAR2)', 'faculty2', 'E');

INSERT INTO early_alert(id, created_date, modified_date, created_by, modified_by, object_status,course_name, 
course_title,person_id, comment, campus_id, course_term_code)
VALUES ('$(TASKID4)','$(YEAR3)-04-15 09:41:43.568','$(YEAR3)-04-16 09:41:43.568',
(SELECT id FROM person WHERE id = '$(COACHID)'),
(SELECT id FROM person WHERE id = '$(COACHID)'),1,'ENG076','College Writing II',
(SELECT id FROM person WHERE school_id ='$(STRUGGLINGSTUDENT3)'),
'Low test scores from the last two exams.  Recommend offsite tutoring.','901e104b-4dc7-43f5-a38e-581015e204e1','SP$(YEAR2)');


INSERT INTO map_plan(id, created_date, modified_date, created_by, modified_by, object_status,person_id, owner_id, name, contact_title, contact_phone, contact_email, contact_name, contact_notes, student_notes, based_on_template_id, is_financial_aid, is_important, is_f1_visa, academic_goals, career_link,academic_link, program_code, catalog_year_code)
VALUES ('$(TASKID3)', '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', 
'1', (SELECT id FROM person WHERE school_id ='$(STRUGGLINGSTUDENT3)'), '$(COACHID)', 
'Associate in Automotive Technology - Part Time', 'Coach', '555-555-1234', 
'sample@sample.com', 'Coach', 'This is important.', '', NULL, 0 , 1 , 0 ,'Graduate', 'http://www.unicon.net/opensource/student-success-plan', 'http://www.unicon.net/opensource/student-success-plan', 'AUMT-AS', (SELECT code FROM external_catalog_year WHERE name = '$(YEAR4)-$(YEAR5)'));

INSERT INTO map_term_note(id, created_date, modified_date, created_by, modified_by, plan_id, template_id, term_code, contact_notes, student_notes, is_important, object_status)
VALUES ((SELECT NEWID()), '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '$(TASKID3)', NULL, 'SP$(YEAR3)', 'This semester is important!', 'This semester is important, you need to pass more classes! More notes to follow.', 1 , 1);



INSERT INTO task(
    id, created_date, modified_date, created_by, modified_by, object_status, 
    description, due_date, session_id, 
    person_id, challenge_id, challenge_referral_id, name, confidentiality_level_id, 
    deletable, link)
VALUES ('$(TASKID5)','$(YEAR3)-02-09 14:10:21.732','$(YEAR3)-09-09 11:10:21.732',
'$(COACHID)','$(COACHID)',1,
'Register for Student Success Course -Section 101 from all divisions to learn strategies for success.','$(YEAR3)-10-23','',
(SELECT id FROM person WHERE school_id ='$(STRUGGLINGSTUDENT3)'),'fb206a68-78db-489d-9d5d-dce554f54eed',
'1f831a35-8944-4e9a-b459-38364df365ea','Student Success Course','b3d077a7-4055-0510-7967-4a09f93a0357', 0,'');


INSERT INTO person_completed_item(id, person_id, completed_item_id, created_date, modified_date, created_by, modified_by, object_status)
VALUES ((SELECT NEWID()), (SELECT id FROM person WHERE school_id ='$(STRUGGLINGSTUDENT3)'), (SELECT TOP 1 id FROM completed_item ORDER BY NEWID()), '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '1');

INSERT INTO person_confidentiality_disclosure_agreement(id, created_date, modified_date, created_by, modified_by, object_status, person_id, confidentiality_disclosure_agreement_id) 
VALUES ((SELECT NEWID()), '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id ='$(STRUGGLINGSTUDENT3)'), '0a640a2a-409d-1271-8140-a23f925500dc');

INSERT INTO person_tool(id, created_date, modified_date, created_by, modified_by, object_status, person_id, tool)
VALUES ((SELECT NEWID()), '$(YEAR2)-05-21 04:42:39.901', '$(YEAR2)-05-21 04:42:39.901', '$(COACHID)', '$(COACHID)', '1', (SELECT id FROM person WHERE school_id ='$(STRUGGLINGSTUDENT3)'), 'INTAKE');




--Linked Reference/Response/Description Data


INSERT INTO early_alert_early_alert_reason(early_alert_id, early_alert_reason_id) 
VALUES ('$(TASKID1)', 'b2d112d7-5056-a51a-80aa-795e56155af5');

INSERT INTO early_alert_early_alert_reason(early_alert_id, early_alert_reason_id) 
VALUES ('$(TASKID4)', 'b2d112b8-5056-a51a-8067-1fda2849c3e5');

INSERT INTO early_alert_early_alert_reason(early_alert_id, early_alert_reason_id) 
VALUES ('$(TASKID3)', 'b2d11316-5056-a51a-80f9-79421bdf08bf');

INSERT INTO early_alert_early_alert_reason(early_alert_id, early_alert_reason_id) 
VALUES ('$(TASKID3)', 'b2d11335-5056-a51a-80ea-074f8fef94ea');

INSERT INTO early_alert_early_alert_reason(early_alert_id, early_alert_reason_id) 
VALUES ('$(TASKID2)', 'b2d112b8-5056-a51a-8067-1fda2849c3e5');



INSERT INTO early_alert_early_alert_suggestion(early_alert_id, early_alert_suggestion_id) 
VALUES ('$(TASKID4)', 'b2d11170-5056-a51a-8002-b5ce9f25e2bc');

INSERT INTO early_alert_early_alert_suggestion(early_alert_id, early_alert_suggestion_id) 
VALUES ('$(TASKID3)', 'b2d1120c-5056-a51a-80ea-c779a3109f8f');

INSERT INTO early_alert_early_alert_suggestion(early_alert_id, early_alert_suggestion_id) 
VALUES ('$(TASKID2)', 'b2d111ed-5056-a51a-8046-5291453e8720');



INSERT INTO early_alert_response(id, created_date, modified_date, created_by, modified_by, 
object_status, early_alert_id, early_alert_outcome_id, early_alert_outcome_other_description, comment)
VALUES ('$(TASKID1)', '$(YEAR3)-09-04 09:55:30.522', '$(YEAR3)-09-04 09:55:30.522', '$(COACHID)', 
'$(COACHID)', '1', '$(TASKID4)', '12a58804-45dc-40f2-b2f5-d7e4403acee1', '', 'Waiting for response.');

INSERT INTO early_alert_response(id, created_date, modified_date, created_by, modified_by, 
object_status, early_alert_id, early_alert_outcome_id, early_alert_outcome_other_description, comment)
VALUES ('$(TASKID2)', '$(YEAR2)-09-04 09:55:30.522', '$(YEAR2)-09-04 09:55:30.522', '$(COACHID)', 
'$(COACHID)', '1', '$(TASKID3)', '7148606f-9034-4538-8fc2-c852a5c912ee', '', 'Discussed low test scores.');

INSERT INTO early_alert_response(id, created_date, modified_date, created_by, modified_by, 
object_status, early_alert_id, early_alert_outcome_id, early_alert_outcome_other_description, comment)
VALUES ('$(TASKID3)', '$(YEAR2)-09-04 09:55:30.522', '$(YEAR2)-09-04 09:55:30.522', '$(COACHID)', 
'$(COACHID)', '1', '$(TASKID1)', '12a58804-45dc-40f2-b2f5-d7e4403acee1', '', 'Had discussion with student.');

INSERT INTO early_alert_response(id, created_date, modified_date, created_by, modified_by, 
object_status, early_alert_id, early_alert_outcome_id, early_alert_outcome_other_description, comment)
VALUES ('$(TASKID4)', '$(YEAR3)-09-04 09:55:30.522', '$(YEAR3)-09-04 09:55:30.522', '$(COACHID)', 
'$(COACHID)', '1', '$(TASKID2)', '7148606f-9034-4538-8fc2-c852a5c912ee', 'Notified student recieving Early Alert of all Options (An option may or may not have been selected)', 'Notified student of options.');


INSERT INTO early_alert_response_early_alert_outreach(early_alert_response_id, early_alert_outreach_id)
VALUES ('$(TASKID4)', '0a640a2a-40e7-15de-8140-e9e372950024');

INSERT INTO early_alert_response_early_alert_outreach(early_alert_response_id, early_alert_outreach_id)
VALUES ('$(TASKID3)', '3383d46f-8051-4a86-886d-a3efe75b8f3a');

INSERT INTO early_alert_response_early_alert_outreach(early_alert_response_id, early_alert_outreach_id)
VALUES ('$(TASKID1)', '9842eff0-6557-4fb2-81c2-614991d5cbfb');

INSERT INTO early_alert_response_early_alert_outreach(early_alert_response_id, early_alert_outreach_id)
VALUES ('$(TASKID2)', '9842eff0-6557-4fb2-81c2-614991d5cbfb');



INSERT INTO early_alert_response_early_alert_referral(early_alert_response_id, early_alert_referral_id)
VALUES ('$(TASKID1)', '1f5729af-0337-4e58-a001-8a9f80dbf8aa');

INSERT INTO early_alert_response_early_alert_referral(early_alert_response_id, early_alert_referral_id)
VALUES ('$(TASKID2)', 'b2d112a9-5056-a51a-8010-b510525ea3a8');

INSERT INTO early_alert_response_early_alert_referral(early_alert_response_id, early_alert_referral_id)
VALUES ('$(TASKID3)', 'b2d112b8-5056-a51a-8067-1fda2849c3e5');



INSERT INTO journal_entry_detail(id, created_date, modified_date, created_by, modified_by, 
object_status, journal_entry_id, journal_step_journal_step_detail_id)
VALUES ('$(TASKID5)','$(YEAR3)-04-26 13:55:30.682','$(YEAR3)-04-26 13:55:30.682','$(COACHID)',
'$(COACHID)','1','$(TASKID5)','0a640a2a-409d-1271-8140-e5bb9faa0224');


INSERT INTO journal_entry_detail(id, created_date, modified_date, created_by, modified_by, 
object_status, journal_entry_id, journal_step_journal_step_detail_id)
VALUES ('$(TASKID2)','$(YEAR3)-04-26 13:55:30.682','$(YEAR3)-04-26 13:55:30.682', '$(COACHID)',
'$(COACHID)','1', '$(TASKID5)','0a640a2a-409d-1271-8140-e5bbaac30225');


INSERT INTO journal_entry_detail(id, created_date, modified_date, created_by, modified_by, 
object_status, journal_entry_id, journal_step_journal_step_detail_id)
VALUES ('$(TASKID3)','$(YEAR3)-04-26 13:55:30.682','$(YEAR3)-04-26 13:55:30.682', '$(COACHID)',
'$(COACHID)','1','$(TASKID5)','0a640a2a-409d-1271-8140-e5bc054b0228');



--Map_Plan_Courses for the 3 assigned Map_Plans

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR1)-09-05 14:53:22.853', '$(YEAR1)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'MAT085', 'MAT-085', 'Introductory Algebra', 
' ', 'FA$(YEAR1)', 1.00, 1 , 0, '', '', 1 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR1)-09-05 14:53:22.853', '$(YEAR1)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'ENG075', 'ENG-075', 'College Writing I', 
' ', 'FA$(YEAR1)', 3.00, 1 , 0, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR1)-09-05 14:53:22.853', '$(YEAR1)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'ENG055', 'ENG-055', 'English Composition I', 
' ', 'FA$(YEAR1)', 2.00, 1 , 0, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR1)-09-05 14:53:22.853', '$(YEAR1)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT140', 'AUMT-140', 'Introduction to Automotive Technology', 
' ', 'FA$(YEAR1)', 3.00, 0 , 0, 'Advisor Notes Go Here', 'Student Notes Go Here', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR1)-09-05 14:53:22.853', '$(YEAR1)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT101', 'AUMT-101', 'Introduction to Speed Communication', 
' ', 'FA$(YEAR1)', 2.00, 0 , 0, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR2)-09-05 14:53:22.853', '$(YEAR2)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'MAT086', 'MAT-086', 'Intermediate Algebra', 
' ', 'SP$(YEAR2)', 3.00, 0 , 0, '', '', 1 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR2)-09-05 14:53:22.853', '$(YEAR2)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'GEO104', 'GEO-104', 'Introduction to Geography', 
' ', 'SP$(YEAR2)', 3.00, 0 , 0, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR2)-09-05 14:53:22.853', '$(YEAR2)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'ENG076', 'ENG-076', 'College Writing II', 
' ', 'SP$(YEAR2)', 3.00, 0 , 0, '', '', 0 , '9a07ced6-7b3a-4926-8a88-ba23f998fc46');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR2)-09-05 14:53:22.853', '$(YEAR2)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT142', 'AUMT-142', 'Automotive Engine Repair', 
' ', 'SP$(YEAR2)', 3.00, 0 , 0, '', '', 0 , '9a07ced6-7b3a-4926-8a88-ba23f998fc46');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.853', '$(YEAR3)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'ENG055', 'ENG-055', 'College Reading I', 
' ', 'FA$(YEAR2)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.853', '$(YEAR3)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT241', 'AUMT-241', 'Automotive Engine Performance Analysis', 
' ', 'FA$(YEAR2)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.853', '$(YEAR3)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'CRIJ133', 'CRIJ-133', 'Introduction to Criminal Justice', 
' ', 'FA$(YEAR2)', 4.00, 0 , 0, '', '', 0 , NULL);



INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.853', '$(YEAR3)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT142', 'AUMT-142', 'Automotive Engine Repair', 
' ', 'FA$(YEAR2)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.853', '$(YEAR3)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT245', 'AUMT-245', 'Automotive Alternative Fuels', 
' ', 'SP$(YEAR3)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.853', '$(YEAR3)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT244', 'AUMT-244', 'Engine Performance and Analysis II', 
' ', 'SP$(YEAR3)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.853', '$(YEAR3)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'ENG076', 'ENG-076', 'College Writing II', 
' ', 'SP$(YEAR3)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.853', '$(YEAR3)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT246', 'AUMT-246', 'Automotive Drive Train and Axles', 
' ', 'FA$(YEAR3)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.853', '$(YEAR3)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'ENG076', 'ENG-076', 'College Writing II', 
' ', 'FA$(YEAR3)', 4.00, 0 , 0, '', '', 0 , NULL);



INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.853', '$(YEAR3)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT140', 'AUMT-140', 'Introduction to Automotive Technology', 
'Course: AUMT140 is not currently offered in the selected term.', 'WN$(YEAR3)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.853', '$(YEAR3)-09-05 14:53:22.853', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT141', 'AUMT-141', 'Automotive Electrical Systems', 
'Course: AUMT141 is not currently offered in the selected term.', 'WN$(YEAR3)', 4.00, 0 , 1, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'ENG076', 'ENG-076', 'College Writing II', ' ', 'SP$(YEAR4)', 4.00, 0 , 0, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT244', 'AUMT-244', 'Engine Performance Analysis II', ' ', 'SP$(YEAR4)', 4.00, 0 , 1, '', '', 0 , NULL);

 

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT244', 'AUMT-244', 'Automotive Heating and Air Conditioning', ' ', 'SP$(YEAR4)', 4.00, 0 , 1, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT241', 'AUMT-241', 'Automotive Engine Performance Analysis', ' ', 'SU$(YEAR4)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'ENG101', 'ENG-101', 'English Composition I', ' ', 'SU$(YEAR4)', 3.00, 0 , 2, '', '', 0 , NULL, 'ENG101');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'),
 '$(TASKID3)', 'AUMT248', 'AUMT-248', 'Automotive Automatic Transmissions and Transaxle I', ' ', 'FA$(YEAR4)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'HST234', 'HST-234', 'College level History', 
'  Course: HST234 is not currently offered in the selected term.', 'FA$(YEAR4)', 3.00, 0 , 1, '', '', 0 , '9a07ced6-7b3a-4926-8a88-ba23f998fc46', 'HST234');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT243', 'AUMT-243', 'Automotive Electronics', ' ', 'WN$(YEAR4)', 3.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'MAT407', 'MAT-407', 'College level Mathematics', 
'  Course: MAT407 is not currently offered in the selected term.', 'WN$(YEAR4)', 3.00, 0 , 1, '', '', 0 , NULL, 'MAT407');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'ENG102', 'ENG-102', 'English Composition II', ' ', 'WN$(YEAR4)', 3.00, 0 , 2, '', '', 0 , NULL, 'ENG102');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT246', 'AUMT-246', 'Automotive Drive Train and Axles', ' ', 'SP$(YEAR5)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT249', 'AUMT-249', 'Automotive Automatic Transmission and Transaxle II', ' ', 'SP$(YEAR5)', 4.00, 0 , 1, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854',
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'AUMT146', 'AUMT-146', 'Automotive Suspension and Steering Systems', ' ', 'SU$(YEAR5)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854',
 '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'),
 '$(TASKID3)', 'AUMT243', 'AUMT-243', 'Automotive Electronics', ' ', 'SU$(YEAR5)', 3.00, 0 , 1, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'), 
'$(TASKID3)', 'GEO172', 'GEO-172', 'Principles of Geography', 
'  Course: GEO172 is not currently offered in the selected term.', 'FA$(YEAR5)', 3.00, 0 , 1, '', '', 0 , '3122e73b-dd86-4f23-af05-22c2abd93414', 'GEO172');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-05 14:53:22.854', '$(YEAR3)-09-05 14:53:22.854',
 '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(STRUGGLINGSTUDENT3)'),
 '$(TASKID3)', 'AUMT251', 'AUMT-251', 'Automotive Service', ' ', 'WN$(YEAR5)', 4.00, 0 , 0, '', '', 0 , NULL);



INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.237', '$(YEAR3)-09-06 12:35:52.237', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 
'CST101', 'CST-101', 'Programming Fundamentals II', 
' ', 'SP$(YEAR2)', 3.00, 0 , 0, '', '', 0 , NULL);



INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.237', '$(YEAR3)-09-06 12:35:52.237', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 
'ENG101', 'ENG-101', 'English Composition I', 
' ', 'SP$(YEAR2)', 3.00, 0 , 0, '', '', 0 , NULL, 'ENG101');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.237', '$(YEAR3)-09-06 12:35:52.237', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 
'MAT085', 'MAT-085', 'Introductory Algebra', 
' ', 'SP$(YEAR2)', 3.00, 0 , 0, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.237', '$(YEAR3)-09-06 12:35:52.237', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 
'CHM104', 'CHM-104', 'Quantitative Chemistry', 
' ', 'SP$(YEAR2)', 3.00, 0 , 0, '', '', 0 , NULL);



INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.237', '$(YEAR3)-09-06 12:35:52.237', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 
'MAT183', 'MAT-183', 'Advanced Mathematics', 
' ', 'FA$(YEAR3)', 3.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.237', '$(YEAR3)-09-06 12:35:52.237', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 
'$(TASKID1)', 'ENG102', 'ENG-102', 'English Composition II', 
' ', 'FA$(YEAR3)', 3.00, 0 , 1, '', '', 0 , NULL, 'ENG102');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.237', '$(YEAR3)-09-06 12:35:52.237',
 '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 
'$(TASKID1)', 'CST102', 'CST-102', 'Programming Fundamentals II', 
' ', 'FA$(YEAR3)', 3.00, 0 , 2, '', '', 0 , NULL);

 

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 
'$(TASKID1)', 'HST163', 'HST-163', 'Fundamentals of History', ' ', 'FA$(YEAR3)', 3.00, 0 , 3, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 
'PHL177', 'PHL-177', 'Principles of Philosophy', 
' ', 'FA$(YEAR3)', 3.00, 0 , 4, '', '', 0 , NULL, 'PHL177');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 
'$(TASKID1)', 'MAT219', 'MAT-219', 'Applied Mathematics', ' ', 'SP$(YEAR3)', 3.00, 0 , 3, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 
'$(TASKID1)', 'CST125', 'CST-125', 'Creative Computing', ' ', 'SP$(YEAR3)', 3.00, 0 , 3, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 
'$(TASKID1)', 'CST130', 'CST-130', 'Fundamentals of Networking Technologies', ' ', 'SP$(YEAR3)', 3.00, 0 , 3, '', '', 0 , NULL, 'CST130');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 
'$(TASKID1)', 'LIT111', 'LIT-111', 'Basics of Literature', ' ', 'SP$(YEAR3)', 3.00, 0 , 3, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 
'$(TASKID1)', 'PHY151', 'PHY-151', 'Exploratory Physics', ' ', 'SP$(YEAR3)', 3.00, 0 , 3, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), 
'$(TASKID1)', 'SCL106', 'SCL-106', 'Principles of Sociology', ' ', 'SP$(YEAR3)', 3.00, 0 , 3, '', '', 0 , NULL);




INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'),
'$(TASKID1)', 'MAT221', 'MAT-221-1', 'Higher Mathematics', 
' Course: Higher Mathematics.', 
'SP$(YEAR4)', 3.00, 0 , 0, 
'The student is planning to transfer to State U, and the program will only accept Higher Mathematics  MAT221 in the transfer agreement as program credit. ', 
'Or take MAT 211 Individualized Math, which will also apply to your degree.', 1 , '3bdda584-f7a2-4402-8863-4b5bd8273009');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)', 1, 
(SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'PHY215', 'PHY-215', 'College level Physics', 
' ', 'SP$(YEAR4)', 3.00, 0 , 1, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)',
 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'HST202', 'HST-202', 'U.S. History II', 
' ', 'SP$(YEAR4)', 3.00, 0 , 2, '', '', 0 , NULL, 'HST202');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 
'CST245', 'CST-245', 'System Analysis and Design', 
' ', 'SP$(YEAR4)', 3.00, 0 , 3, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'ENG205', 
'ENG-205', 'English - Oral Communication', '    Course: ENG205 is not currently offered in the selected term.
 ', 'SP$(YEAR4)', 3.00, 0 , 4, '', '', 0 , NULL, 'ENG205');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)', 
1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'ENG202', 'ENG-202', 
'Technical and Business Writing', ' ', 'FA$(YEAR4)', 3.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)', 1, 
(SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'BIO146', 'BIO-146', 
'General Biology', ' ', 'FA$(YEAR4)', 3.00, 0 , 1, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)', 
1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'CST230', 'CST-230', 
'Object Oriented Programming', ' Course: CST230 is not currently offered in the selected term.', 'FA$(YEAR4)', 3.00, 0 , 2, '', '', 0 , NULL, 'CST230');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status,
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'CST250', 'CST-250', 
'Introduction to C# Programming', ' Course: CST250 is not currently offered in the selected term.', 'FA$(YEAR4)', 3.00, 0 , 3, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'CST201', 'CST-201', 
'Database Programming - Oracle', ' Course: CST201 is not currently offered in the selected term.', 'FA$(YEAR4)', 3.00, 0 , 4, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'CST178', 'CST-178', 
'Enterprise Computing', ' Course: CST178 is not currently offered in the selected term.', 'FA$(YEAR4)', 
3.00, 0 , 5, '', '', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)', 
1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'CST363', 'CST-363', 
'Special Topic: Computing', ' ', 'SP$(YEAR5)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)', 1, 
(SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'AES118', 'AES-118', 'General Aerospace', 
' ', 
'SP$(YEAR5)', 3.00, 0 , 2, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id)
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 
'CST410', 'CST-410', 'International Computing', ' ', 
'SP$(YEAR5)', 3.00, 0 , 3, '', '', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)', 
1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'CST345', 'CST-345', 
'Foundational Computing', ' ', 
'SP$(YEAR5)', 3.00, 0 , 4, '', '', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)', 
1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'COM127', 'COM-127', 
'Basics of Communications', ' ', 
'SP$(YEAR5)', 3.00, 0 , 4, '', '', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'CST270', 'CST-270',
 'Personal Computer Hardware', 'Study of the individual hardware components and corresponding operation that make-up the ubiquitous PC', 'FA$(YEAR5)', 3.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)', 
1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'CST262', 'CST-262', 
'UNIX Operating System', 
'Builds a thorough understanding of the Linux/UNIX operating system and an overview of multi-user administration',
 'FA$(YEAR5)', 3.00, 0 , 1, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)', 1, 
(SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'GEO196', 'GEO-196', 'Introduction to Geography', 
' Course: GEO196 is not currently offered in the selected term.', 'FA$(YEAR5)', 3.00, 0 , 3, '', '', 0 , '3122e73b-dd86-4f23-af05-22c2abd93414', 'GEO196');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)', 1, 
(SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'MAT328', 'MAT-328', 'Integrative Mathematics', 
' ', 'FA$(YEAR5)', 3.00, 0 , 4, '', '', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-06 12:35:52.238', '$(YEAR3)-09-06 12:35:52.238', '$(COACHID)', '$(COACHID)', 
1, (SELECT id FROM person WHERE school_id = '$(NEWSTUDENT1)'), '$(TASKID1)', 'CST325', 'CST-325', 
'Integrative Computing', ' ', 'FA$(YEAR5)', 3.00, 0 , 5, '', '', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');











INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR1)-09-13 13:27:34.543', '$(YEAR1)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'SCL101', 
'SCL-101', 'Introduction to Sociology', ' ', 'FA$(YEAR1)', 3.00, 0 , 2, '', '', 0 , '3122e73b-dd86-4f23-af05-22c2abd93414');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR1)-09-13 13:27:34.543', '$(YEAR1)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'PSY101', 
'PSY-101', 'Introduction to Psychology', ' ', 'FA$(YEAR1)', 3.00, 0 , 2, 'Advisor Notes Are Here', 'Student Notes Are Here', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR1)-09-13 13:27:34.543', '$(YEAR1)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'MAT106', 
'MAT-106', 'Applied Mathematics', ' ', 'FA$(YEAR1)', 3.00, 0 , 2, '', '', 1 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR1)-09-13 13:27:34.543', '$(YEAR1)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'ENG101', 
'ENG-101', 'English Composition I', ' ', 'FA$(YEAR1)', 3.00, 0 , 2, '', '', 0 , NULL, 'ENG101');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR1)-09-13 13:27:34.543', '$(YEAR1)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CRIJ131', 
'CRIJ-131', 'Fundamentals of Criminal Law', ' ', 'FA$(YEAR1)', 3.00, 0 , 2, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR1)-09-13 13:27:34.543', '$(YEAR1)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CRIJ130', 
'CRIJ-130', 'Introduction to Criminal Justice', ' ', 'FA$(YEAR1)', 4.00, 0 , 2, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR2)-09-13 13:27:34.543', '$(YEAR2)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'MAT183', 
'MAT-183', 'Advanced Mathematics', ' ', 'SP$(YEAR2)', 3.00, 0 , 2, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR2)-09-13 13:27:34.543', '$(YEAR2)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'LIT111', 
'LTT-111', 'Basics of Literature', ' ', 'SP$(YEAR2)', 3.00, 0 , 2, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR2)-09-13 13:27:34.543', '$(YEAR2)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'ENG102', 
'ENG-102', 'English Composition II', ' ', 'SP$(YEAR2)', 3.00, 0 , 2, '', '', 0 , NULL, 'ENG102');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR2)-09-13 13:27:34.543', '$(YEAR2)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CRIJ134', 
'CRIJ-134', 'Ethics in Criminal Justice', ' ', 'SP$(YEAR2)', 3.00, 0 , 2, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR2)-09-13 13:27:34.543', '$(YEAR2)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CRIJ133', 
'CRIJ-133', 'Juvenile Justice System', ' ', 'SP$(YEAR2)', 3.00, 0 , 2, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'PHL106', 
'PHL-106', 'Advanced Philosophy', ' ', 'FA$(YEAR2)', 3.00, 0 , 2, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'MIC134', 
'MIC-134', 'Foundational Microbiology', ' ', 'FA$(YEAR2)', 3.00, 0 , 2, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'MAT219', 
'MAT-219', 'Applied Mathematics', ' ', 'FA$(YEAR2)', 3.00, 0 , 2, '', '', 0 , NULL);

 

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST105', 
'CST-105', 'Introduction to Computing I', ' ', 'FA$(YEAR2)', 3.00, 0 , 2, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST101', 
'CST-101', 'Programming Fundamentals I', ' ', 'FA$(YEAR2)', 3.00, 0 , 2, '', '', 0 , NULL);



INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'MAT251', 
'MAT-251', 'Creative Mathematics', ' ', 'SP$(YEAR3)', 3.00, 0 , 2, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'LIT155', 
'LIT-155', 'Advanced Literature', ' ', 'SP$(YEAR3)', 3.00, 0 , 2, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST262', 
'CST-262', 'UNIX Operating System', ' ', 'SP$(YEAR3)', 3.00, 0 , 2, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST135', 
'CST-135', 'Fundamentals of Networking', ' ', 'SP$(YEAR3)', 3.00, 0 , 2, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST102', 
'CST-102', 'Programming Fundamentals II', ' ', 'SP$(YEAR3)', 3.00, 0 , 2, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'PHY215', 
'PHY-215', 'College Level Physics', ' ', 'FA$(YEAR3)', 3.00, 0 , 2, '', '', 0 , NULL);



INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'MAT324', 
'MAT-324', 'Quantitative Mathematics', ' ', 'FA$(YEAR3)', 3.00, 0 , 2, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'HST210', 
'HST-210', 'Survey History', ' ', 'FA$(YEAR3)', 3.00, 0 , 2, '', '', 0 , NULL);



INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST230', 'CST-230', 'Object Orientated Programming', ' ', 'FA$(YEAR3)', 3.00, 0 , 1, '', '', 0 , NULL, 'CST230');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST245', 
'CST-245', 'System Analysis and Design', ' ', 'FA$(YEAR3)', 3.00, 0 , 2, '', '', 1 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'MAT407', 
'MAT-407', 'College Level Mathematics', ' ', 'SP$(YEAR4)', 3.00, 0 , 0, '', '', 0 , NULL, 'MAT407');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'ECN229', 
'ECN-229', 'Entrepreneurial Economics', ' ', 'SP$(YEAR4)', 3.00, 0 , 3, '', '', 0 , '9a07ced6-7b3a-4926-8a88-ba23f998fc46');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)',
 '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST270',
 'CST-270', 'Personal Computer Hardware', '  Course: PHL177 is not currently offered in the selected term.',
 'SP$(YEAR4)', 3.00, 0 , 4, '', '', 0 , NULL, 'PHL177');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'MAT411', 
'MAT-411', 'Analytical Mathematics', '',
 'SP$(YEAR4)', 3.00, 0 , 0, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'LIT212', 'LIT-212', 'Special Topic: Literature', ' ', 'SP$(YEAR4)', 3.00, 0 , 1, '', '', 0 , 'bb0abe0b-d6f8-4987-8fff-27020dc9fe35');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', '$(COACHID)', 
1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST250', 'CST-250',
'Introduction to C#', ' ', 'SP$(YEAR4)', 3.00, 0 , 3, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'CST272', 'CST-272', 'Principles of Computing', ' ', 'SU$(YEAR4)', 3.00, 0 , 2, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.543', '$(YEAR3)-09-13 13:27:34.543', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'CST262', 'CST-262', 'UNIX Operating System', ' ', 'FA$(YEAR4)', 1.00, 0 , 2, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'CST311', 'CST-311', 'Quantative Computing', ' ', 'FA$(YEAR4)', 3.00, 0 , 2, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'PHY205', 'PHY-205', 'Applied Physics', ' ', 'FA$(YEAR4)', 2.00, 0 , 2, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'SCL128', 'SCL-128', 'Explaratory Sociology', ' ', 'FA$(YEAR4)', 3.00, 0 , 2, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'CHM218', 'CHM-218', 'Applied Chemistry', ' ', 'FA$(YEAR4)', 3.00, 0 , 2, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'BIO266', 'BIO-266', 'Applied Biology', ' ', 'FA$(YEAR4)', 3.00, 0 , 2, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'COM206', 'COM-206', 'Honors Communications', ' ', 'WN$(YEAR4)', 3.00, 0 , 0, '', '', 0 , '3122e73b-dd86-4f23-af05-22c2abd93414');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'ENG202', 'ENG-202', 'Technical and Business Writing', ' ', 'SP$(YEAR5)', 3.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'CST272', 'CST-272', '', ' ', 'SP$(YEAR5)', 3.00, 0 , 1, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'CST325', 'CST-325', 'Integrative Computing', ' ', 'SP$(YEAR5)', 3.00, 0 , 3, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', 
'$(COACHID)', '$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), 
'$(TASKID2)', 'CST334', 'CST-334', 'Elementary Computing', 
'', 'SP$(YEAR5)', 3.00, 0 , 5, '', '', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'AST124', 
'AST-124', 'College Level Astronomy', ' ', 'SP$(YEAR5)', 3.00, 0 , 1, '', '', 0 , NULL);

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'FIN162', 
'FIN-162', 'Elementary Finance', ' ', 'SP$(YEAR5)', 3.00, 0 , 1, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST345', 
'CST-345', 'Foundational Computing', ' ', 'SU$(YEAR5)', 3.00, 0 , 0, '', '', 0 , NULL);



INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST366', 
'CST-366', 'Quantative Computing', ' ', 'FA$(YEAR5)', 4.00, 0 , 0, '', '', 0 , NULL);


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST363', 
'CST-363', 'Special Topic: Computing', ' ', 
'FA$(YEAR5)', 3.00, 0 , 3, '', '', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', '$(COACHID)', 
1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'COM206', 'COM-206', 'Honors Communication',
' ', 'FA$(YEAR5)', 3.00, 0 , 4, 'This is a filler course.', 'Take this to fill your schedule.', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', 
'$(COACHID)', 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'EEE237', 'EEE-237', 
'Introduction to Electrical Engineering', ' ', 'FA$(YEAR5)', 3.00, 0 , 0, '', '', 0 , NULL);




INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', '$(COACHID)', 1, 
(SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'ENG205', 'ENG-205', 
'English - Oral Communication', ' ', 'WN$(YEAR5)', 3.00, 0 , 0, '', '', 0 , NULL, 'ENG205');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', '$(COACHID)', 
1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 
'CST434', 'CST-434', 'Basics of Computing', ' ', 
'SP$(YEAR6)', 3.00, 0 , 2, '', '', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id, original_formatted_course) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', '$(COACHID)', 1, 
(SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'GEO196', 'GEO-196', 
'Introduction to Geography', ' ', 
'SP$(YEAR6)', 3.00, 0 , 3, '', '', 0 , '3122e73b-dd86-4f23-af05-22c2abd93414', 'GEO196');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', '$(COACHID)',
 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST410', 'CST-410', 
'International Computing', '  Course: CST220 is not currently offered in the selected term.', 'SP$(YEAR6)', 2.00, 0 , 4, '', '', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', '$(COACHID)',
 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST410', 'CST-410', 
'College Level Computing', ' ', 'SP$(YEAR6)', 3.00, 0 , 4, '', '', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');

INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', '$(COACHID)',
 1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'IEE225', 'IEE-225', 
'Elementary Industrial Engineering', ' ', 'SP$(YEAR6)', 2.00, 0 , 5, '', '', 0 , '3bdda584-f7a2-4402-8863-4b5bd8273009');


INSERT INTO map_plan_course (id, created_date, modified_date, created_by, modified_by, object_status, 
            person_id, plan_id, formatted_course, course_code, course_title, 
            course_description, term_code, credit_hours, is_dev, order_in_term, 
            contact_notes, student_notes, is_important, elective_id) 
VALUES ((SELECT NEWID()), '$(YEAR3)-09-13 13:27:34.544', '$(YEAR3)-09-13 13:27:34.544', '$(COACHID)', '$(COACHID)', 
1, (SELECT id FROM person WHERE school_id = '$(PROGRESSINGSTUDENT2)'), '$(TASKID2)', 'CST448', 'CST-448', 
'International Computing', ' ', 'SU$(YEAR6)', 3.00, 0 , 0, '', '', 0 , NULL);



INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 20:49:34.236', '$(YEAR1)-05-16 20:49:34.236', '$(COACHID)', '$(COACHID)', 1, '$(TASKID3)', 'ENG102', 'ENG-102', 'English Composition II', ' Course: ENG102 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 20:49:34.236', '$(YEAR1)-05-16 20:49:34.236', '$(COACHID)', '$(COACHID)', 1, '$(TASKID3)', 'HST234', 'HST-234', 'College level History', ' Course: HST234 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 20:49:34.236', '$(YEAR1)-05-16 20:49:34.236', '$(COACHID)', '$(COACHID)', 1, '$(TASKID3)', 'GEO172', 'GEO-172', 'Principles of Geography', ' Course: GEO172 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 20:49:34.236', '$(YEAR1)-05-16 20:49:34.236', '$(COACHID)', '$(COACHID)', 1, '$(TASKID3)', 'MAT407', 'MAT-407', 'College level Mathematics', ' Course: MAT407 is not currently offered in the selected term.', 3.00);


INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 20:49:34.236', '$(YEAR1)-05-16 20:49:34.236', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID3)' AND formatted_course = 'ENG102'), 'COM127', 'COM-127', 'Basics of Communications', 'Basics of Communications', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 20:49:34.236', '$(YEAR1)-05-16 20:49:34.236', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID3)' AND formatted_course = 'ENG102'), 'LIT282', 'LIT-282', 'General Literature', 'General Literature', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 20:49:34.236', '$(YEAR1)-05-16 20:49:34.236', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID3)' AND formatted_course = 'HST234'), 'FIN114', 'FIN-114', 'Elementary Finance', 'Elementary Finance', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 20:49:34.236', '$(YEAR1)-05-16 20:49:34.236', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID3)' AND formatted_course = 'HST234'), 'PHL450', 'PHL-450', 'College level Philosophy', 'College level Philosophy', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 20:49:34.236', '$(YEAR1)-05-16 20:49:34.236', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID3)' AND formatted_course = 'HST234'), 'PSY127', 'PSY-127', 'Applied Psychology', 'Applied Psychology', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 20:49:34.236', '$(YEAR1)-05-16 20:49:34.236', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID3)' AND formatted_course = 'GEO172'), 'AES118', 'AES-118', 'General Aerospace', 'General Aerospace', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 20:49:34.236', '$(YEAR1)-05-16 20:49:34.236', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID3)' AND formatted_course = 'GEO172'), 'PHY131', 'PHY-131', 'General Physics', 'General Physics', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 20:49:34.236', '$(YEAR1)-05-16 20:49:34.236', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID3)' AND formatted_course = 'MAT407'), 'MAT412', 'MAT-412', 'Applied Mathematics', 'Applied Mathematics', 4.00);



INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, '$(TASKID2)', 'HST201', 'HST-201', 'U.S. History I', ' Course: HST201 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, '$(TASKID2)', 'HST202', 'HST-202', 'U.S. History II', ' Course: HST202 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, '$(TASKID2)', 'PHL177', 'PHL-177', 'Principles of Philosophy', ' Course: PHL177 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, '$(TASKID2)', 'GEO196', 'GEO-196', 'Introduction to Geography', 'Introduction to Geography', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.649', '$(YEAR1)-05-16 22:29:08.649', '$(COACHID)', '$(COACHID)', 1, '$(TASKID2)', 'ENG102', 'ENG-102', 'English Composition II', ' Course: ENG102 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.649', '$(YEAR1)-05-16 22:29:08.649', '$(COACHID)', '$(COACHID)', 1, '$(TASKID2)', 'ENG205', 'ENG-205', 'English - Oral Communication', ' Course: ENG205 is not currently offered in the selected term. Course: ENG205 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.649', '$(YEAR1)-05-16 22:29:08.649', '$(COACHID)', '$(COACHID)', 1, '$(TASKID2)', 'ENG202', 'ENG-202', 'Technical and Business Writing', ' Course: ENG202 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.649', '$(YEAR1)-05-16 22:29:08.649', '$(COACHID)', '$(COACHID)', 1, '$(TASKID2)', 'CST130', 'CST-130', 'Fundamentals of Networking Technologies', ' Course: CST130 is not currently offered in the selected term.', 3.00);



INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'HST201'), 'HST210', 'HST-210', 'Survey History', 'Survey History', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'HST201'), 'HST241', 'HST-241', 'Exploratory History', 'Exploratory History', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'HST201'), 'HST260', 'HST-260-1', 'Entrepreneurial History', 'Entrepreneurial History', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'HST202'), 'HST234', 'HST-234', 'College level History', 'College level History', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'HST202'), 'HST240', 'HST-240', 'Fundamentals of History', 'Fundamentals of History', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'HST202'), 'HST299', 'HST-299', 'Elementary History', 'Elementary History', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'PHL177'), 'COM250', 'COM-250', 'Analytical Communications', 'Analytical Communications', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'PHL177'), 'PSY127', 'PSY-127', 'Applied Psychology', 'Applied Psychology', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'PHL177'), 'SCL181', 'SCL-181', 'Individualized Sociology', 'Individualized Sociology', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'GEO196'), 'AST124', 'AST-124', 'College level Astronomy', 'College level Astronomy', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.648', '$(YEAR1)-05-16 22:29:08.648', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'GEO196'), 'BIO191', 'BIO-191', 'Survey Biology', 'Survey Biology', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.649', '$(YEAR1)-05-16 22:29:08.649', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'GEO196'), 'PHY229', 'PHY-229', 'Survey Physics', 'Survey Physics', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.649', '$(YEAR1)-05-16 22:29:08.649', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'ENG102'), 'LIT111', 'LIT-111', 'Basics of Literature', 'Basics of Literature', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.649', '$(YEAR1)-05-16 22:29:08.649', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'ENG205'), 'LIT288', 'LIT-288', 'Integrative Literature', 'Integrative Literature', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.649', '$(YEAR1)-05-16 22:29:08.649', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'ENG202'), 'LIT155', 'LIT-155', 'Advanced Literature', 'Advanced Literature', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR1)-05-16 22:29:08.649', '$(YEAR1)-05-16 22:29:08.649', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID2)' AND formatted_course = 'CST130'), 'EEE106', 'EEE-106', 'Elementary Electrical Engineering', 'Elementary Electrical Engineering', 3.00);



INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.032', '$(YEAR3)-05-16 23:58:56.032', '$(COACHID)', '$(COACHID)', 1, '$(TASKID1)', 'PHL177', 'PHL-177', 'Principles of Philosophy', ' Course: PHL177 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, '$(TASKID1)', 'CST230', 'CST-230', 'Object Oriented Programming', ' Course: CST230 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, '$(TASKID1)', 'GEO196', 'GEO-196', 'Introduction to Geography', ' Course: GEO196 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, '$(TASKID1)', 'ENG202', 'ENG-202', 'Technical and Business Writing', ' Course: ENG202 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, '$(TASKID1)', 'ENG205', 'ENG-205', 'English - Oral Communication', ' Course: ENG205 is not currently offered in the selected term. Course: ENG205 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, '$(TASKID1)', 'ENG102', 'ENG-102', 'English Composition II', ' Course: ENG102 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, '$(TASKID1)', 'HST202', 'HST-202', 'U.S. History II', ' Course: HST202 is not currently offered in the selected term.', 3.00);

INSERT INTO map_plan_elective_course (id, created_date, modified_date, created_by, modified_by, object_status, plan_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, '$(TASKID1)', 'CST103', 'CST-103', 'Integrative Computing', ' Course: CST103 is not currently offered in the selected term.', 3.00);



INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.032', '$(YEAR3)-05-16 23:58:56.032', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'PHL177'), 'COM138', 'COM-138', 'Fundamentals of Communications', 'Fundamentals of Communications', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'PHL177'), 'ECN187', 'ECN-187', 'Fundamentals of Economics', 'Fundamentals of Economics', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'PHL177'), 'POL139', 'POL-139', 'Elementary Political Science', 'Elementary Political Science', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'PHL177'), 'SCL182', 'SCL-182', 'Creative Sociology', 'Creative Sociology', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'CST230'), 'EEE237', 'EEE-237', 'Introduction to Electrical Engineering', 'Introduction to Electrical Engineering', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'GEO196'), 'BIO146', 'BIO-146', 'General Biology', 'General Biology', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'GEO196'), 'PHY149', 'PHY-149', 'Exploratory Physics', 'Exploratory Physics', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'ENG202'), 'FLM172', 'FLM-172', 'Basics of Film', 'Basics of Film', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'ENG202'), 'LIT140', 'LIT-140', 'Enterprise Literature', 'Enterprise Literature', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'ENG205'), 'COM206', 'COM-206', 'Honors Communications', 'Honors Communications', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'ENG205'), 'LIT282', 'LIT-282', 'General Literature', 'General Literature', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'ENG102'), 'COM122', 'COM-122', 'Introduction to Communications', 'Introduction to Communications', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'ENG102'), 'LIT111', 'LIT-111', 'Basics of Literature', 'Basics of Literature', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'HST202'), 'ECN217', 'ECN-217', 'Quantitative Economics', 'Quantitative Economics', 3.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'HST202'), 'FIN329', 'FIN-329', 'General Finance', 'General Finance', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.033', '$(YEAR3)-05-16 23:58:56.033', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'HST202'), 'SCL346', 'SCL-346', 'Survey Sociology', 'Survey Sociology', 4.00);

INSERT INTO map_plan_elective_course_electives (id, created_date, modified_date, created_by, modified_by, object_status, map_plan_elective_course_id, formatted_course, course_code, course_title, course_description, credit_hours) VALUES ((SELECT NEWID()), '$(YEAR3)-05-16 23:58:56.034', '$(YEAR3)-05-16 23:58:56.034', '$(COACHID)', '$(COACHID)', 1, (SELECT id FROM map_plan_elective_course WHERE plan_id = '$(TASKID1)' AND formatted_course = 'CST103'), 'IEE153', 'IEE-153', 'Applied Industrial Engineering', 'Applied Industrial Engineering', 4.00);

GO

-- ***END OF SQL SCRIPT***

