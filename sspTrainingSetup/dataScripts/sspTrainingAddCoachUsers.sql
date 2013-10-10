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
 * *** SSP TRAINING SET COACH/USER DATA INTO PLATFORM AND CALL SET STUDENTS SCRIPT ***
 *
 * This SQL File sets user data into ssp-platform such that the entered coaches 
 * can login into the platform and have 3 assigned high quality use-case students.
 *
 * It adds into tables up_person_dir, up_person_attr, up_person_attr_values, and SSP person.
 *
 * To use this file substitute the placeholders below via some other script
 *  or manually with the required data for each user adding a select statement each time. 
    There is a function so you would create a select statment for each new user. 
 *
 *  SELECT addUsersToPlatform('COACHUSERNAME','COACHPASSWORD', 'COACHFIRSTNAME', 'COACHLASTNAME', 'COACHUUID');
 *
 * Substitute: 
 *	COACHUSERNAME = username of the new user to add (must be unique)
 *	COACHPASSWORD = password of the new user to add 
 *		(must be generated by portalPasswordGenerator or uPortal and be in the SHA or MD5 form)
 *	COACHFIRSTNAME = first name of the new user to add 
 *	COACHLASTNAME = last name of the new user to add      
 *	COACHUUID = the unique UUID that will be used by SSP for the new user (must be unique)
 *		Sample UUID: 7f000101-4159-1de6-8141-5b6b77c70013
 *
 * Note: Requires Postgres 8.4 or higher
 *
 */

--Function to Set Users in SSP-Platform for SSP Training

CREATE OR REPLACE FUNCTION addUsersToPlatform(text, text, text, text, uuid) RETURNS void AS $$

DECLARE
  userDirId bigint;
  userUserId bigint;
  idAttr bigint; 
  ifExists boolean; 
  blank integer; 
  attrRecord RECORD; 

BEGIN
	--Delete can comment out for fresh database (NOTE: Need to delete students assigned/referenced first!)
 	/* ifExists = (SELECT EXISTS (SELECT count(*) FROM up_person_dir WHERE user_name = $1));
	
	 IF ifExists IS TRUE THEN	   
	   FOR attrRecord IN (SELECT id FROM up_person_attr WHERE user_dir_id = 
						(SELECT user_dir_id FROM up_person_dir WHERE user_name = $1)) LOOP
 		DELETE FROM up_person_attr_values WHERE attr_id = attrRecord.id;		
	   END LOOP;
    	   DELETE FROM up_person_attr WHERE user_dir_id = (SELECT user_dir_id FROM up_person_dir WHERE user_name = $1);
           DELETE FROM up_person_dir WHERE user_name = $1;
	   DELETE FROM up_user WHERE user_name = $1;
           DELETE FROM person WHERE username = $1;  
	 END IF; */
	--End Delete  

	 userDirId = (SELECT user_dir_id FROM up_person_dir ORDER BY user_dir_id DESC LIMIT 1) + 1;
	 idAttr = (SELECT id FROM up_person_attr ORDER BY id DESC LIMIT 1) + 1;
	 userUserId = (SELECT user_id FROM up_user ORDER BY user_id DESC LIMIT 1) + 1;

	 INSERT INTO up_person_dir(user_dir_id, entity_version, lst_pswd_cgh_dt, user_name, encrptd_pswd)
	 VALUES (userDirId, '1', '2013-09-10 21:59:16.794', $1, $2);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr, '0', 'DATA_ACADEMIC_RESOURCE_CENTER', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+1, '0', 'SSP_ROLES', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+2, '0', 'mail', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+3, '0', 'DATA_DISPLACED_WORKERS', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+4, '0', 'sn', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+5, '0', 'alternateEmailAddress', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+6, '0', 'department', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+7, '0', 'DATA_FAST_FORWARD', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+8, '0', 'DATA_DISABILITY', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+9, '0', 'givenName', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+10, '0', 'DATA_INDIVIDUALIZED_LEARNING_PLAN', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+11, '0', 'DATA_EARLY_ALERT', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+12, '0', 'DATA_ENGLISH_SECOND_LANGUAGE', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+13, '0', 'title', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+14, '0', 'organization', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+15, '0', 'DATA_COUNSELING_SERVICES', userDirId);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (idAttr+16, '0', 'telephoneNumber', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+16, '_(555) 555-5555', '0');

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+15, '_TRUE', '0');

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+14, '_trainingssp', '0');

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+13, '_Senior Advisor', '0');

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+12, '_TRUE', '0');

  	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+11, '_TRUE', '0');

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+10, '_TRUE', '0');

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+9, '_'||$3, '0');

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+8, '_TRUE', '0');

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+7, '_TRUE', '0');

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+6, '_Advising', '0');

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+5, '_demo@trainingssp.com', '0');

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+4, '_'||$4, '0');

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+3, '_TRUE', '0');

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+2, '_demo@trainingssp.com', '0');

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr+1, '_SSP_COACH', '0');

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (idAttr, '_TRUE', '0');

	INSERT INTO up_user(user_id, user_name, user_dflt_usr_id, user_dflt_lay_id, next_struct_id, 
            lst_chan_updt_dt)
    	VALUES (userUserId+1, $1, 10, 1, 4, null);

	INSERT INTO person(id, first_name, middle_name, last_name, birth_date, primary_email_address,            secondary_email_address, username, home_phone, work_phone, cell_phone, address_line_1, address_line_2, city, state, zip_code, photo_url, school_id, enabled, created_date, modified_date, created_by,modified_by, object_status, person_demographics_id, person_education_goal_id, person_education_plan_id, strengths, coach_id, ability_to_benefit, 
            anticipated_start_term, anticipated_start_year, student_intake_request_date,student_type_id, student_intake_complete_date, person_staff_details_id,actual_start_year, actual_start_term, non_local_address, alternate_address_in_use,alternate_address_line_1, alternate_address_line_2, alternate_address_city,alternate_address_state, alternate_address_zip_code, alternate_address_country,person_disability_id, f1_status, residency_county, person_class,secret,oauth2_client_access_token_validity_seconds)
VALUES ($5, $3, '', $4, NULL, 'demo@trainingssp.com', '', $1,'(555) 555-5555', '', '','123 W. Demo St.', 'Apt. 555', 'Phoenix', 'AZ','55555', NULL,$1, 't', '2010-08-20', '2010-08-20','58ba5ee3-734e-4ae9-b9c5-943774b4de41','58ba5ee3-734e-4ae9-b9c5-943774b4de41', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'DemoCounty', 'user', NULL, NULL);
END;  

$$ LANGUAGE plpgsql;

-- End Function


--Begin Add User Section (You can edit below this line)
--   FORM: SELECT addUsersToPlatform('COACHUSERNAME','COACHPASSWORD', 'COACHFIRSTNAME', 'COACHLASTNAME', 'COACHUUID');

   SELECT addUsersToPlatform('COACHUSERNAME','COACHPASSWORD','COACHFIRSTNAME', 'COACHLASTNAME', 'COACHUUID');

  
--End Add Users to Platform Script
