
START TRANSACTION;

Drop table temp_ultimo_login;
create table temp_ultimo_login select USER_ID, MAX(date(SERVER_TIME_ID)) AS MAX_DATE
									FROM `test_santander`.`actividad_session` 
									WHERE EVENT_DESCRIPTION = "LOGIN"
									GROUP BY USER_ID;


                                
	

                                
INSERT INTO `test_santander`.`actividad_session`

SELECT NULL,BQ.USER_ID, BQ.SESSION_ID, BQ.SEGMENT_ID, BQ.SEGMENT_DESCRIPTION, BQ.USER_CITY_ID, BQ.EVENT_ID, BQ.SERVER_TIME_ID, BQ.TIME_SPENT,
BQ.DEVICE_BROWSER, BQ.DEVICE_MOBILE, BQ.DEVICE_OS, CASE WHEN DATEDIFF( BQ.SERVER_TIME_ID , ul.MAX_DATE) > 2 THEN 1 ELSE  0 END DOSD_FL,
BQ.EVENT_DESCRIPTION, 0

FROM BIGQUERY AS BQ
INNER JOIN temp_ultimo_login ul
ON BQ.USER_ID = ul.USER_ID
WHERE DATE(SERVER_TIME_ID) > DATE(ul.MAX_DATE)





