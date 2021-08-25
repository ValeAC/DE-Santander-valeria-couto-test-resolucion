START TRANSACTION;

Drop table temp_primer_login;
create table temp_primer_login select USER_ID, MIN(SERVER_TIME_ID) AS MIN_DATE
									FROM BIGQUERY 
									WHERE EVENT_DESCRIPTION = "LOGIN"
									GROUP BY USER_ID;
                                    
                                    
INSERT INTO `test_santander`.`primer_login`

	SELECT NULL,BQ.USER_ID, BQ.SESSION_ID, BQ.SEGMENT_ID, BQ.SEGMENT_DESCRIPTION, BQ.USER_CITY_ID, BQ.EVENT_ID, BQ.SERVER_TIME_ID, BQ.TIME_SPENT,
	BQ.DEVICE_BROWSER, BQ.DEVICE_MOBILE, BQ.DEVICE_OS

	FROM BIGQUERY AS BQ
	INNER JOIN temp_primer_login ul
	on BQ.USER_ID = ul.USER_ID
	where BQ.USER_ID NOT IN (SELECT USER_ID FROM `test_santander`.`primer_login`)



