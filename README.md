# DE-Santander-valeria-couto-test-resolucion

# Data Engineer Programming Test

### SQL

Para este test hemos creado un entorno inventado que simula situaciones de nuestra arquitectura actual. El candidato debe suponer que es un empleado del banco Santander y debe resolver una situación planteada por un área de negocio.

En este escenario, los datos de logueo de los usuarios del Santander se encuentran en una única tabla sobre BigQuery. En esta table se guarda toda la información referente a las actividades realizan los usuarios cuando ingresan al Home Banking de Santander. La estructura de dicha tabla se pueden ver a continuación:

![image](https://user-images.githubusercontent.com/62435760/127665003-e3aad47b-616d-44aa-af21-c25249e11123.png)

Basado en esa tabla, el área de la banca privada del banco desea que se arme un modelo dimensional en donde se contemplen dos tablas principales:

●	La primera vez que el usuario se logueo al Home Banking. Asumiendo que dicha situación es un tipo de evento.

●	La actividad diaria de cada usuario.

Tenga en cuenta las siguientes consideraciones técnicas:

1.	La table de origen contiene mil millones de registros.
2.	El modelo a construer debe poder ejecutarse tanto en consolas SQL o en herramientas de BI.
3.	Uno de los KPIs mas importantes que tiene la organización es la de retención de clientes. Dicho KPI es el porcentaje de usuarios que realizaron una actividad diferente al login durante 2 dos días consecutivos y cuya sesión haya durando al menos 5 minutos.

### Pregunta 1
#### Como resolvería este tipo de petición? Explique detalladamente el proceso de limpieza y transformación del modelo inicial. Que tecnologías utilizaría y por que?

Construiria al menos dos procesos ETL, correspondientes cada uno a la ingesta de cada Hecho definido. Para este caso se realizaron los script de carga de los mismos, y estos deberian ser referenciados por el proceso ETL. Como herramienta podria utilizar cualquiera que permita el desarrollo de procesos ETL o incluso tambien algun lenguaje de manipulacion de datos como ser python, en el cual se configuraria el correcto ingreso a las bases de datos involucradas, esta informacion la tomaria de un archivo de configuracion. Desde python se ejecutaran las consultas detalladas en los siguientes puntos y su resultado se ingestara en el DW.
En cuanto el proceso de limpieza y transformacion se tienen en cuenta los siguientes puntos:

● se eliminaran aquellos casos en que no exista USER_ID ya que es un campo indispensable para el calculo de KPI

● se define un formato de fecha estandar yyyy-mm-dd HH:MM:SS

● Tipificar cada una de las ciudades a codigos estandar dentro del DW para identificarlos en sus consultas

● Se genera campo DOSD_FL para almacenar si un usuario se conecta por dos dias consecutivos

### Ejercicio 1
#### Realice el DER que de soporte al modelo dimensional solicitado por la banca privada.

### Se definieron dos Hechos:
● Primer Login

● Actividad

### Dimensiones
● Fecha

● Ciudad (sugerencia para posibles mediciones)

![image](https://github.com/ValeAC/DE-Santander-valeria-couto-test-resolucion/blob/main/Modelo_dimensional-ACTIVIDAD.png)

![image](https://github.com/ValeAC/DE-Santander-valeria-couto-test-resolucion/blob/main/Modelo_dimensional-PRIMER%20LOGIN.png)

### Ejercicio 2 
#### Escriba las queries necesarias partiendo de la tabla inicial y que de como resultado el modelo planteado en el ejercicio anterior.

● Las queries realizadas para crear las tablas del modelo anterior se encuentran en el Script "SCRIPT_CREACION.SQL"

● Asumiendo que la tabla "actividad_session" ya cuenta con información correspondiente a una ingesta anterior. El proceso de carga que se ejecutaría diariamente para actualizar la información, es el correspondiente al script "CARGA_ACTIVIDAD.sql". En el mismo se genera una tabla temporal con la información del último login de los usuarios, esta fecha se compara con las que se obtienen de BIGQUERY para realizar el insert a actividad. Con la finalidad de tener control de los días consecutivos, se genera un campo llamado "DOSD_FL" en donde se pondrá un 1 o un 0 en caso de haber login consecutivos.

● Para el caso de la tabla primer login el proceso de carga que se ejecutara diariamente para actualizar los usuarios que ingresan por primera vez es el correspondiente al script "Carga_PRIMERAVEZ.SQL". En el cual se genera una tabla temporal que obtiene la fecha mínima de login de cada usuario, para luego validar que no existe en la tabla "primer_login" e insertar la información.


### Ejercicio 3
#### Escriba la consulta necesaria para obtener el KPI de retención de clientes para los 10 clientes que mas veces se hayan logueado en el último mes.

● La consulta correspondiente a los 10 clientes que más veces se hayan logueado se encuentra en el script "EJERCICIO#.SQL". Donde también desarrollo la query correspondiente al punto 3 de las consideraciones técnicas a tener en cuenta.

### Python 
(Para hacerlo interesante, usar Python 2.7)

Se deberá escribir un script que transforme el archivo datos_data_engineer.tsv en un archivo CSV que pueda ser insertado en una base de datos, y/o interpretado por cualquier parser estándar de archivos delimitados, de la manera más sencilla posible.

El archivo resultante debe tener las siguientes características:
* Cada row contiene la misma cantidad de campos
* Los campos se separan con un pipe |
* Se deben poder leer correctamente los caracteres especiales que estén presentes en los campos actuales del archivo. 
* El encoding del archivo final debe ser UTF-8 (datos_de_santander.tsv es un archivo UTF-16LE)

#### ● El script correspondiente a este punto se denomina "test_python.py"
