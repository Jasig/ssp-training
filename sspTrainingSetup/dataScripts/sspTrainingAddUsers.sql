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
 * *** SSP TRAINING SET USER DATA INTO PLATFORM ***
 *
 * This SQL File sets user data into ssp-platform such that the user 
 * can login into the platform and have the abilities according to their SSP Role.
 *
 * It adds into tables up_person_dir, up_person_attr, up_person_attr_values, and SSP person among others.
 *
 * To use this file substitute the placeholders below via some other script
 *  or manually with the required data for each user adding a select statement each time. 
    This is a function so you would create a select statment for each new user. 
 *
 *  SELECT addUsersToPlatform('USERNAME','USERPASSWORD', 'USERFIRSTNAME', 'USERLASTNAME', 'USERUUID', 'USERROLE');
 *
 * Substitute: 
 *	USERNAME = username of the new user to add (must be unique)
 *	USERPASSWORD = password of the new user to add 
 *		(must be generated by portalPasswordGenerator or uPortal and be in the SHA or MD5 form)
 *	USERFIRSTNAME = first name of the new user to add 
 *	USERLASTNAME = last name of the new user to add      
 *	USERUUID = the unique UUID that will be used by SSP for the new user (must be unique)
 *		Sample UUID: 7f000101-4159-1de6-8141-5b6b77c70013
                  (The SSP_STUDENT role doesn't use the UUID value)
 *      USERROLE = the SSP Role the user will have. These are shortened strings and valid values are:
 *                 STUDENT, COACH, FACULTY, MANAGER, SUPPORT, and DEVELOPER
 *                   (if it's a value different than the above, the user will be given the SSP_COACH role by default)
 *      IS_MAP_TEMPLATE_ADMIN = true/false boolean if the added user should be a MAP_TEMPLATE_ADMIN
 *                   
 * Note: Requires Postgres 8.4 or higher
 *
 */
 
 --Function to Create Approximately Random Pseudo UUID's 

CREATE OR REPLACE FUNCTION generateUUID() RETURNS uuid AS $BODY$

SELECT CAST( md5(current_database() || user || current_timestamp || random()) as uuid )

$BODY$ LANGUAGE 'sql' VOLATILE;

--End function



--Function to Set Users in SSP-Platform for SSP TRAINING

CREATE OR REPLACE FUNCTION addUsersToPlatform(text, text, text, text, uuid, text, boolean) RETURNS void AS $$

DECLARE
  userDirId bigint;
  userUserId bigint;
  idAttr bigint; 
  ifExists boolean; 
  blank integer; 
  attrRecord RECORD;
  createdUUID uuid; 
  roleTitle varchar(16);
  roleDepartment varchar(22);
  sspRole varchar(19);
  userEmail varchar(32);
  userBirthdate date;
  userStreetAddress varchar(17);
  userAptAddress varchar(12);
  userPhoneNumber varchar(16);
  userBuilding varchar(16);
  userOfficeHours varchar(15);
  userDepartment varchar(18);
  userRelationshipStatus varchar(10);
  userPhotoUrl varchar(38);
  throwAwayInt bigint; 
  

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
	
	 createdUUID = (SELECT generateUUID());	
	 idAttr = (SELECT id FROM up_person_attr ORDER BY id DESC LIMIT 1) + 1;
	 userDirId = (SELECT nextval('up_person_dir_seq'));	
	 userUserId = (SELECT user_id FROM up_user ORDER BY user_id DESC LIMIT 1) + 1;
	
      IF $6 = 'STUDENT' THEN
      
	 INSERT INTO up_person_dir(user_dir_id, entity_version, lst_pswd_cgh_dt, user_name, encrptd_pswd)
	 VALUES (userDirId, '1', '2013-09-10 21:59:16.794', $1, $2);

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_ACADEMIC_RESOURCE_CENTER', userDirId);
 
         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_FALSE', '0'); 

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'SSP_ROLES', userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_SSP_STUDENT', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'sn', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_'||$4, '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_DISPLACED_WORKERS', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_FAST_FORWARD', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_DISABILITY', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'givenName', userDirId);

  	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_'||$3, '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_INDIVIDUALIZED_LEARNING_PLAN', userDirId);

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_EARLY_ALERT', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_ENGLISH_SECOND_LANGUAGE', userDirId);

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_COUNSELING_SERVICES', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_FALSE', '0');
	
	 INSERT INTO up_user(user_id, user_name, user_dflt_usr_id, user_dflt_lay_id, next_struct_id, 
            lst_chan_updt_dt)
    	 VALUES (userUserId, $1, 10, 1, 4, null);
    	 
      ELSE	 
	 
	 IF $6 = 'FACULTY' THEN
 		roleTitle = '_Faculty';
 		roleDepartment = '_Academic Faculty';
 		sspRole = '_SSP_FACULTY';
 		userEmail = 'demofaculty@trainingssp.com';
 		userBirthdate = '1960-07-07';
 		userStreetAddress = '194 W. Demo St.';
 		userAptAddress = 'Apt. 732';
 		userPhoneNumber = '(555) 555-1209';
 		userBuilding = 'South Building';
 		userOfficeHours = 'M-W 1-5pm';
 		userDepartment = 'Academic';
 		userRelationshipStatus = 'Married';
 		userPhotoUrl = '/ssp/images/demoAvatars/male_16.jpg';
	 ELSIF $6 = 'MANAGER' THEN
 		roleTitle = '_Manager';
 		roleDepartment = '_Advising Management';
 		sspRole = '_SSP_MANAGER';
 		userEmail = 'demomanager@trainingssp.com';
 		userBirthdate = '1965-06-11';
 		userStreetAddress = '253 W. Demo St.';
 		userAptAddress = 'Apt. 456';
 		userPhoneNumber = '(555) 555-4567';
 		userBuilding = 'West Building';
 		userOfficeHours = 'M-Th 10-4pm';
 		userDepartment = 'Administration';
 		userRelationshipStatus = 'Married';
 		userPhotoUrl = '/ssp/images/demoAvatars/male_16.jpg';
	 ELSIF $6 = 'SUPPORT' THEN
 		roleTitle = '_Staff';
 		roleDepartment = '_Advising Staff';
 		sspRole = '_SSP_SUPPORT_STAFF';
 		userEmail = 'demosupport@trainingssp.com';
 		userBirthdate = '1990-02-09';
 		userStreetAddress = '834 W. Demo St.';
 		userAptAddress = 'Apt. 123';
 		userPhoneNumber = '(555) 555-1234';
 		userBuilding = 'North Building';
 		userOfficeHours = 'M-F 9-5pm';
 		userDepartment = 'Advising Support';
 		userRelationshipStatus = 'Single';
 		userPhotoUrl = '/ssp/images/demoAvatars/male_16.jpg';
	 ELSIF $6 = 'DEVELOPER' THEN
 		roleTitle = '_Developer';
 		roleDepartment = '_IT Development';
 		sspRole = '_SSP_DEVELOPER';
 		userEmail = 'demodeveloper@trainingssp.com';
 		userBirthdate = '1985-10-08';
 		userStreetAddress = '789 W. Demo St.';
 		userAptAddress = 'Apt. 886';
 		userPhoneNumber = '(555) 555-9875';
 		userBuilding = 'East Building';
 		userOfficeHours = 'M-Sat 12am-12pm';
 		userDepartment = 'IT Development';
 		userRelationshipStatus = 'Single';
 		userPhotoUrl = '/ssp/images/demoAvatars/male_16.jpg';
	 ELSE
 		roleTitle = '_Senior Advisor';
 		roleDepartment = '_Advising';
 		sspRole = '_SSP_COACH';
 		userEmail = 'democoach@trainingssp.com';
 		userBirthdate = '1970-05-05';
 		userStreetAddress = '123 W. Demo St.';
 		userAptAddress = 'Apt. 555';
 		userPhoneNumber = '(555) 555-5555';
 		userBuilding = 'North Building';
 		userOfficeHours = 'M-Th 7-6pm';
 		userDepartment = 'Advising';
 		userRelationshipStatus = 'Married';
 		userPhotoUrl = '/ssp/images/demoAvatars/male_04.jpg';
	 END IF; 
 	 

	 INSERT INTO up_person_dir(user_dir_id, entity_version, lst_pswd_cgh_dt, user_name, encrptd_pswd)
	 VALUES (userDirId, '1', '2013-09-10 21:59:16.794', $1, $2);
	 	 
	 
         INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_ACADEMIC_RESOURCE_CENTER', userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'SSP_ROLES', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), sspRole, '0');
         
         IF $7 IS TRUE THEN  
	      INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
              VALUES ((SELECT currval('up_person_attr_seq')), '_SSP_MAP_TEMPLATE_ADMIN', '0');
         END IF; 

         INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'mail', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_'||userEmail, '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_DISPLACED_WORKERS', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'sn', userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_'||$4, '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'alternateEmailAddress', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_'||userEmail, '0');

         INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'department', userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), roleDepartment, '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_FAST_FORWARD', userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_DISABILITY', userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'givenName', userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_'||$3, '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_INDIVIDUALIZED_LEARNING_PLAN', userDirId);

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_EARLY_ALERT', userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_ENGLISH_SECOND_LANGUAGE', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'title', userDirId);

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), roleTitle, '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'organization', userDirId);

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_SSP Training', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'DATA_COUNSELING_SERVICES', userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((SELECT nextval('up_person_attr_seq')), '0', 'telephoneNumber', userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((SELECT currval('up_person_attr_seq')), '_'||userPhoneNumber, '0');

         
         INSERT INTO up_user(user_id, user_name, user_dflt_usr_id, user_dflt_lay_id, next_struct_id, lst_chan_updt_dt)
    	 VALUES (userUserId, $1, 10, 1, 4, null);    	 
    	 
    	 
    	 INSERT INTO external_person(school_id, username, first_name, middle_name, last_name, birth_date, primary_email_address, address_line_1, address_line_2, city, state, zip_code, home_phone, work_phone, office_location, office_hours, department_name, actual_start_term, actual_start_year, marital_status, ethnicity, gender, is_local, balance_owed, coach_school_id, cell_phone, photo_url, residency_county, f1_status, non_local_address, student_type_code, race_code)
VALUES ($1, $1, $3, 'M', $4, userBirthdate, userEmail, userStreetAddress, userAptAddress, 'Phoenix', 'AZ','55555', userPhoneNumber, userPhoneNumber, userBuilding, userOfficeHours, userDepartment, NULL, NULL, userRelationshipStatus, 'Other', 'M', 't', NULL, NULL, userPhoneNumber, userPhotoUrl, 'DemoCounty', NULL, 'N', NULL, 'Other');

INSERT INTO person_staff_details(id, created_date, modified_date, created_by, modified_by, object_status, office_location, office_hours, department_name)
VALUES (createdUUID, '2013-09-13 09:22:00.092', '2013-09-13 09:22:00.092', '58ba5ee3-734e-4ae9-b9c5-943774b4de41','58ba5ee3-734e-4ae9-b9c5-943774b4de41', '1', userBuilding, userOfficeHours, userDepartment);

	 INSERT INTO person(id, first_name, middle_name, last_name, birth_date, primary_email_address, secondary_email_address, username, home_phone, work_phone, cell_phone, address_line_1, address_line_2, city, state, zip_code, photo_url, school_id, enabled, created_date, modified_date, created_by,modified_by, object_status, person_demographics_id, person_education_goal_id, person_education_plan_id, coach_id, ability_to_benefit, anticipated_start_term, anticipated_start_year, student_intake_request_date,student_type_id, student_intake_complete_date, person_staff_details_id,actual_start_year, actual_start_term, non_local_address, alternate_address_in_use,alternate_address_line_1, alternate_address_line_2, alternate_address_city,alternate_address_state, alternate_address_zip_code, alternate_address_country,person_disability_id, f1_status, residency_county, person_class,secret,oauth2_client_access_token_validity_seconds)
	 VALUES ($5, $3, 'M', $4, userBirthdate, userEmail, userEmail, $1, userPhoneNumber, userPhoneNumber, userPhoneNumber, userStreetAddress, userAptAddress, 'Phoenix', 'AZ','55555', userPhotoUrl, $1, 't', '2010-08-20', '2010-08-20','58ba5ee3-734e-4ae9-b9c5-943774b4de41','58ba5ee3-734e-4ae9-b9c5-943774b4de41', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, createdUUID, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'DemoCounty', 'user', NULL, NULL);
	 
	 IF $6 = 'COACH' THEN
 		INSERT INTO early_alert_routing(id, created_date, modified_date, created_by, modified_by, object_status, campus_id, early_alert_reason_id, person_id, group_name, group_email)
VALUES ((SELECT generateUUID()), '2013-09-13 09:22:00.092', '2013-09-13 09:22:00.092', '58ba5ee3-734e-4ae9-b9c5-943774b4de41','58ba5ee3-734e-4ae9-b9c5-943774b4de41', '1', (SELECT id FROM campus ORDER BY RANDOM() LIMIT 1), (SELECT id FROM early_alert_reason ORDER BY RANDOM() LIMIT 1), $5, 'Early Alert Routing Group ' || $1, 'demo@trainingssp.com');

	 END IF; 
      END IF;          
      
      --Increment the sequences / Fixes error in ssp-platform admin on add/edit a user after data load 
      throwAwayInt = (SELECT nextval('up_person_dir_seq'));
      throwAwayInt = (SELECT nextval('up_person_attr_seq'));
END;  

$$ LANGUAGE plpgsql;

-- End Function


--Begin Add User Section (You can edit below this line)
--   FORM: SELECT addUsersToPlatform('USERNAME','USERPASSWORD', 'USERFIRSTNAME', 'USERLASTNAME', 'USERUUID', 'USERROLE', false);

   SELECT addUsersToPlatform('USERNAME', 'USERPASSWORD', 'USERFIRSTNAME', 'USERLASTNAME', 'USERUUID', 'USERROLE', 'IS_MAP_TEMPLATE_ADMIN');

  
--End Add Users to Platform Script
