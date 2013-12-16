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
 * *** SSP TRAINING SET STUDENT LOGIN/USER DATA INTO PLATFORM MSSQL Version***
 *
 * This SQL File sets user data into ssp-platform such that the entered students 
 * can login into the platform and use the MyGPS functionality.
 *
 * It adds into tables up_person_dir, up_person_attr and up_person_attr_values.
 *
 * To use this file substitute the placeholders below via some other script
 *  or manually with the required data for each user adding a select statement each time. 
 *  There is a function so you would create a select statment for each new user. 
 *
 *  SELECT addStudentUsersToPlatform('$(STUDENTUSERNAME)','$(STUDENTPASSWORD)', '$(STUDENTFIRSTNAME)', '$(STUDENTLASTNAME)');
 *
 * Substitute: 
 *	$(STUDENTUSERNAME) = username of the new user to add (must be unique)
 *	$(STUDENTPASSWORD) = password of the new user to add 
 *		(must be generated by portalPasswordGenerator or uPortal and be in the SHA or MD5 form)
 *	$(STUDENTFIRSTNAME) = first name of the new user to add 
 *	$(STUDENTLASTNAME) = last name of the new user to add       
 *
 * Note: Requires MSSQL 2008 or higher
 *
 */

--Function to Set Student Users into SSP-Platform for SSP Training

IF object_id('addStudentUsersToPlatform', 'p') IS NOT NULL
    exec('DROP PROCEDURE addStudentUsersToPlatform');
GO

CREATE PROCEDURE addStudentUsersToPlatform @USERNAME VARCHAR(25), @PASSWORD VARCHAR(256), @FIRSTNAME VARCHAR(50), @LASTNAME VARCHAR(50)
AS
     DECLARE @studentUserDirId bigint;
     DECLARE @studentUserUserId bigint;  
     DECLARE @studentIdAttr bigint;    

	--Delete can comment out for fresh database 
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

	 SET @studentUserDirId = (SELECT next_val FROM UP_PERSON_DIR_SEQ) + 5;
	 SET @studentIdAttr = (SELECT next_val FROM UP_PERSON_ATTR_SEQ) + 5;
	 SET @studentUserUserId = (SELECT TOP 1 user_id FROM up_user ORDER BY user_id DESC) + 1;


	 INSERT INTO up_person_dir(user_dir_id, entity_version, lst_pswd_cgh_dt, user_name, encrptd_pswd)
	 VALUES (@studentUserDirId, '1', '2013-09-10 21:59:16.794', @USERNAME, @PASSWORD);


	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (@studentIdAttr, '0', 'DATA_ACADEMIC_RESOURCE_CENTER', @studentUserDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (@studentIdAttr, '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (@studentIdAttr+5, '0', 'SSP_ROLES', @studentUserDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (@studentIdAttr+5, '_SSP_STUDENT', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (@studentIdAttr+10, '0', 'sn', @studentUserDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (@studentIdAttr+10, '_'+@LASTNAME, '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (@studentIdAttr+15, '0', 'DATA_DISPLACED_WORKERS', @studentUserDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (@studentIdAttr+15, '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (@studentIdAttr+20, '0', 'DATA_FAST_FORWARD', @studentUserDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (@studentIdAttr+20, '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (@studentIdAttr+25, '0', 'DATA_DISABILITY', @studentUserDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (@studentIdAttr+25, '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (@studentIdAttr+30, '0', 'givenName', @studentUserDirId);

  	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (@studentIdAttr+30, '_'+@FIRSTNAME, '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (@studentIdAttr+35, '0', 'DATA_INDIVIDUALIZED_LEARNING_PLAN', @studentUserDirId);

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (@studentIdAttr+35, '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (@studentIdAttr+40, '0', 'DATA_EARLY_ALERT', @studentUserDirId);

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (@studentIdAttr+40, '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (@studentIdAttr+45, '0', 'DATA_ENGLISH_SECOND_LANGUAGE', @studentUserDirId);

 	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (@studentIdAttr+45, '_FALSE', '0');

	 INSERT INTO up_person_attr(id, entity_version, attr_name, user_dir_id)
	 VALUES (@studentIdAttr+50, '0', 'DATA_COUNSELING_SERVICES', @studentUserDirId);

	 INSERT INTO up_person_attr_values(attr_id, attr_value, value_order)
         VALUES (@studentIdAttr+50, '_FALSE', '0');
 

	 INSERT INTO up_user(user_id, user_name, user_dflt_usr_id, user_dflt_lay_id, next_struct_id, 
            lst_chan_updt_dt)
    	 VALUES (@studentUserUserId+1, @USERNAME, 10, 1, 4, null);

         --Increment the sequences / Fixes error in ssp-platform admin on add/edit a user after data load 
         UPDATE UP_PERSON_DIR_SEQ SET next_val = (@studentUserDirId + 12);	
	 UPDATE UP_PERSON_ATTR_SEQ SET next_val = (@studentIdAttr+62);

GO

--End Function

EXEC addStudentUsersToPlatform  @USERNAME="$(STUDENTUSERNAME)", @PASSWORD="$(STUDENTPASSWORD)", @FIRSTNAME="$(STUDENTFIRSTNAME)",  @LASTNAME="$(STUDENTLASTNAME)";
  
--End Add Student Users to Platform Script
