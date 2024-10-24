-- Primero esperar que MySQL esté listo
SELECT 1;

-- Crear usuario con todos los privilegios
CREATE USER IF NOT EXISTS 'valvarez'@'%' IDENTIFIED WITH mysql_native_password BY 'valvarez1234';

-- Dar privilegios absolutos
GRANT ALL PRIVILEGES ON *.* TO 'valvarez'@'%' WITH GRANT OPTION;

-- Permisos específicos adicionales
GRANT CREATE, DROP, REFERENCES, INDEX, ALTER, CREATE TEMPORARY TABLES,
      LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE,
      ALTER ROUTINE, EVENT, TRIGGER ON *.* TO 'valvarez'@'%';

-- Privilegios de sistema
GRANT RELOAD,PROCESS ON *.* TO 'valvarez'@'%';

-- Actualizar privilegios
FLUSH PRIVILEGES;

-- Verificar los privilegios
SHOW GRANTS FOR 'valvarez'@'%';