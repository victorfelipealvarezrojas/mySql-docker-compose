# MySQL Docker Configuration 🐋

Este repositorio contiene la configuración de un contenedor Docker para MySQL 8.0, optimizado para rendimiento y recursos.

## 📁 Estructura del Proyecto


```
MYSQL/
├── mysql/
│   ├── conf/
│   │   └── my.cnf       # Configuración optimizada de MySQL
│   └── init/
│       └── init.sql     # Script de inicialización y permisos
├── .env                 # Variables de entorno
└── docker-compose.yml   # Configuración de Docker
```

## ⚙️ Detalles de Configuración

### 1. Variables de Entorno (.env)
```env
MYSQL_ROOT_PASSWORD=pass1234
MYSQL_DATABASE=test
MYSQL_USER=valvarez
MYSQL_PASSWORD=valvarez1234
```

### 2. Configuración MySQL (my.cnf)
```ini
[mysqld]
# Configuración básica
default_authentication_plugin = mysql_native_password
skip-host-cache
skip-name-resolve

# Configuración de buffer y memoria
innodb_buffer_pool_size = 2G
innodb_buffer_pool_instances = 4
innodb_log_file_size = 512M
innodb_log_buffer_size = 16M
innodb_thread_concurrency = 0
thread_cache_size = 32

# Desactivar query cache
query_cache_type = 0
query_cache_size = 0

# Conexiones y paquetes
max_connections = 1000
max_allowed_packet = 128M

# Configuración InnoDB
innodb_flush_method = O_DIRECT
innodb_flush_log_at_trx_commit = 2
innodb_file_per_table = 1

# Configuración de caracteres
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci

# Permitir conexiones remotas
bind-address = 0.0.0.0
```

### 3. Script de Inicialización (init.sql)
```sql
-- Esperar que MySQL esté listo
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
```

### 4. Docker Compose (docker-compose.yml)
```yaml
version: '3.8'
services:
  mysql:
    image: mysql:8.0
    container_name: mysql_db
    command: --default-authentication-plugin=mysql_native_password
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
      TZ: America/Lima
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
      - ./mysql/conf:/etc/mysql/conf.d
      - ./mysql/init:/docker-entrypoint-initdb.d
    networks:
      - mysql_network
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 4G
        reservations:
          cpus: '1'
          memory: 2G

volumes:
  mysql_data:
    driver: local

networks:
  mysql_network:
    driver: bridge
```

## 🚀 Características Principales

- Configuración optimizada de MySQL 8.0
- Permisos completos para el usuario
- Control de recursos (CPU y memoria)
- Persistencia de datos
- Healthcheck configurado
- Soporte UTF8MB4

## 📚 Uso Básico

1. **Iniciar el servicio**:
```bash
docker-compose up -d
```

2. **Detener el servicio**:
```bash
docker-compose down
```

3. **Acceder a MySQL**:
```bash
docker exec -it mysql_db mysql -u valvarez -p
```