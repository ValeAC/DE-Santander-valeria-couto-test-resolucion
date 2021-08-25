
#Uno de los KPIs mas importantes que tiene la organización es la de retención de clientes. 
#Dicho KPI es el porcentaje de usuarios que realizaron una actividad diferente al login durante 2 dos días consecutivos
#y cuya sesión haya durando al menos 5 minutos.
select USER_ID ,
ROUND((SUM(CASE WHEN  TAS.TIME_SPENT>= 300  AND TAS.EVENT_DESCRIPTION <> "LOGIN" AND TAS.DOSD_FL = 0 THEN 1 ELSE 0 END)/COUNT(1))* 100, 2) aS "PORCENTAJE DE USUARIOS"
from  `test_santander`.`actividad_session` TAS;




 #Escriba la consulta necesaria para obtener el KPI de retención de clientes para los 10 clientes que mas veces se hayan logueado en el último mes.
 
select USER_ID, count(USER_ID)
from  `test_santander`.`actividad_session` TAS INNER JOIN `test_santander`.`tiempo` T ON DATE(TAS.SERVER_TIME_ID) = DATE(T.FECHA_ID)
where   TAS.TIME_SPENT>= 300  AND TAS.EVENT_DESCRIPTION = "LOGIN" AND TAS.DOSD_FL = 0 AND month(T.FECHA_ID)= month(current_date())-1 
AND  YEAR(T.FECHA_ID)= YEAR(current_date()) 
group by TAS.USER_ID
ORDER BY COUNT(USER_ID) DESC LIMIT 10;


