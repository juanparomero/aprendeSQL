# Ejecutar este script con un usuario que tenga los privilegios suficientes
# para realizar las operaciones siguientes. Ej. SYSTEM

# Se elimina el esquema con la finalidad de volverlo a construir
DROP USER usuario CASCADE;

# Se crea el usuario 
CREATE USER usuario -- nombre
IDENTIFIED BY USUARIO -- contraseña
DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP; --opcionalmente se especifica los tablespace a utilizar. Estos son por defecto

# Se otorga privilegios
GRANT CONNECT,RESOURCE TO usuario; -- privilegios para conectar y RESOURCE es un rol con un grupo de privilegios para poder trabajar
GRANT DEBUG CONNECT SESSION, DEBUG ANY PROCEDURE TO usuario; --necesario para depurar desde sqldeveloper

# Se realiza la conexión con el nuevo usuario
CONNECT USUARIO/USUARIO;

# Se ejecutan los scripts para la creación de los objetos del esquema HR (esquema de ejemplo dado por Oracle)
# Se deben ejecutar los script en el siguiente orden. Teniendo en cuenta, que en este ejemplo, los tres ficheros 
# están en una carpeta llamada Schema HR en el escritorio de un sistema operativo Windows. Si es necesario
# esto se ha de modificar indicando la ruta a los ficheros.
START "%USERPROFILE%\DESKTOP\Schema HR\HR_CRE.SQL"
START "%USERPROFILE%\DESKTOP\Schema HR\HR_POPUL.SQL"
START "%USERPROFILE%\DESKTOP\Schema HR\HR_IDX.SQL"
