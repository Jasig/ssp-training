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
 * *** SSP TRAINING ADD COACH/USER DATA INTO PLATFORM SCRIPT MSSQL Version***
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
 *  SELECT addUsersToPlatform('$(COACHUSERNAME)','$(COACHPASSWORD)', '$(COACHFIRSTNAME)', '$(COACHLASTNAME)', '$(COACHUUID)');
 *
 * Substitute: 
 *	$(COACHUSERNAME) = username of the new user to add (must be unique)
 *	$(COACHPASSWORD) = password of the new user to add 
 *		(must be generated by portalPasswordGenerator or uPortal and be in the SHA or MD5 form)
 *	$(COACHFIRSTNAME) = first name of the new user to add 
 *	$(COACHLASTNAME) = last name of the new user to add      
 *	$(COACHUUID) = the unique UUID that will be used by SSP for the new user (must be unique)
 *		Sample UUID: 7f000101-4159-1de6-8141-5b6b77c70013
 *
 * Note: Requires MSSQL 2008 or higher
 *
 */

--Function to Set Users in SSP-Platform for SSP Training


IF object_id('addUsersToPlatform', 'p') IS NOT NULL
    exec ('DROP PROCEDURE addUsersToPlatform')
GO

CREATE PROCEDURE addUsersToPlatform @USERNAME VARCHAR(25), @PASSWORD VARCHAR(256), @FIRSTNAME VARCHAR(50), @LASTNAME VARCHAR(50), @UUID VARCHAR(36)
AS
  BEGIN

     DECLARE @userDirId bigint;
     DECLARE @userUserId bigint;  
     DECLARE @userAttrId bigint;       

	--Delete can comment out for fresh database (NOTE: Need to delete students assigned/referenced first!)
 	/* IF EXISTS(SELECT * FROM up_person_dir WHERE user_name = @USERNAME)
           DECLARE @temp bigint;
		   
	   BEGIN
               SET @temp = (SELECT TOP 1 id FROM up_person_attr WHERE user_dir_id = (SELECT user_dir_id FROM up_person_dir WHERE user_name = @USERNAME)  ORDER BY user_dir_id DESC);
               
               WHILE @temp IS NOT NULL		
               BEGIN			       
                     DELETE FROM up_person_attr_values WHERE attr_id = @temp;
                     DELETE FROM up_person_attr WHERE id = @temp;
	             SET @temp = (SELECT TOP 1 id FROM up_person_attr WHERE user_dir_id = (SELECT user_dir_id FROM up_person_dir WHERE user_name = @USERNAME)  ORDER BY user_dir_id DESC);
              END 
              DELETE FROM up_person_attr WHERE user_dir_id = (SELECT user_dir_id FROM up_person_dir WHERE user_name = @USERNAME);			   
              DELETE FROM up_person_dir WHERE user_name = @USERNAME;
	      DELETE FROM up_user WHERE user_name = @USERNAME;
              DELETE FROM person WHERE username = @USERNAME;  
	END; */
	--End Delete   
         
         SET @userDirId = (SELECT next_val FROM UP_PERSON_DIR_SEQ) + 5;	
	 SET @userAttrId = (SELECT next_val FROM UP_PERSON_ATTR_SEQ) + 5;
         SET @userUserId = (SELECT TOP 1 user_id FROM up_user ORDER BY user_id DESC) + 1;        

         INSERT INTO up_person_dir(user_dir_id, entity_version, lst_pswd_cgh_dt, user_name, encrptd_pswd)
	 VALUES (@userDirId, '1', '2013-09-10 21:59:16.794', @USERNAME, @PASSWORD);

	 
         INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (@userAttrId, '0', 'DATA_ACADEMIC_RESOURCE_CENTER', @userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (@userAttrId, '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+5), '0', 'SSP_ROLES', @userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+5), '_SSP_COACH', '0');

         INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+10), '0', 'mail', @userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+10), '_demo@trainingssp.com', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+15), '0', 'DATA_DISPLACED_WORKERS', @userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+15), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+20), '0', 'sn', @userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+20), '_'+@LASTNAME, '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+25), '0', 'alternateEmailAddress', @userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+25), '_demo@trainingssp.com', '0');

         INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+30), '0', 'department', @userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+30), '_Advising', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+35), '0', 'DATA_FAST_FORWARD', @userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+35), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+40), '0', 'DATA_DISABILITY', @userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+40), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+45), '0', 'givenName', @userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+45), '_'+@FIRSTNAME, '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+50), '0', 'DATA_INDIVIDUALIZED_LEARNING_PLAN', @userDirId);

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+50), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+55), '0', 'DATA_EARLY_ALERT', @userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+55), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+60), '0', 'DATA_ENGLISH_SECOND_LANGUAGE', @userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+60), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+65), '0', 'title', @userDirId);

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+65), '_Senior Advisor', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+70), '0', 'organization', @userDirId);

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+70), '_trainingssp', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+75), '0', 'DATA_COUNSELING_SERVICES', @userDirId);

         INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+75), '_TRUE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES ((@userAttrId+80), '0', 'telephoneNumber', @userDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES ((@userAttrId+80), '_(555) 555-5555', '0');

         
         INSERT INTO up_user(user_id, user_name, user_dflt_usr_id, user_dflt_lay_id, next_struct_id, 
            lst_chan_updt_dt)
    	 VALUES (@userUserId, @USERNAME, 10, 1, 4, NULL);

	 INSERT INTO person(id, first_name, middle_name, last_name, birth_date, primary_email_address,            secondary_email_address, username, home_phone, work_phone, cell_phone, address_line_1, address_line_2, city, state, zip_code, photo_url, school_id, enabled, created_date, modified_date, created_by,modified_by, object_status, person_demographics_id, person_education_goal_id, person_education_plan_id, strengths, coach_id, ability_to_benefit, 
            anticipated_start_term, anticipated_start_year, student_intake_request_date,student_type_id, student_intake_complete_date, person_staff_details_id,actual_start_year, actual_start_term, non_local_address, alternate_address_in_use,alternate_address_line_1, alternate_address_line_2, alternate_address_city,alternate_address_state, alternate_address_zip_code, alternate_address_country,person_disability_id, f1_status, residency_county, person_class,secret,oauth2_client_access_token_validity_seconds)
         VALUES (@UUID, @FIRSTNAME, '', @LASTNAME, '1968-01-04', 'demo@trainingssp.com', 'demo2@trainingssp.com', @USERNAME,'(555) 555-5555', '(777) 777-7777', '(888) 888-8888','123 W. Demo St.', 'Apt. 555', 'Phoenix', 'AZ','55555', NULL, @USERNAME, 1, '2010-08-20', '2010-08-20','58ba5ee3-734e-4ae9-b9c5-943774b4de41','58ba5ee3-734e-4ae9-b9c5-943774b4de41', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'DemoCounty', 'user', NULL, NULL);
  
         --Increment the sequences / Fixes error in ssp-platform admin on add/edit a user after data load 
         UPDATE UP_PERSON_DIR_SEQ SET next_val = (@userDirId + 12);	
	 UPDATE UP_PERSON_ATTR_SEQ SET next_val = (@userAttrId+92);
    END; 
GO 
-- End Function


--Begin Add User Section (You can edit below this line)
--   FORM: EXEC addUsersToPlatform  @USERNAME="$(COACHUSERNAME)", @PASSWORD="$(COACHPASSWORD)", @FIRSTNAME="$(COACHFIRSTNAME)",  @LASTNAME="$(COACHLASTNAME)", @UUID="$(COACHUUID)";
--   GO

   EXEC addUsersToPlatform  @USERNAME="$(COACHUSERNAME)", @PASSWORD="$(COACHPASSWORD)", @FIRSTNAME="$(COACHFIRSTNAME)",  @LASTNAME="$(COACHLASTNAME)", @UUID="$(COACHUUID)";
   GO
  
--End Add Users to Platform Script
