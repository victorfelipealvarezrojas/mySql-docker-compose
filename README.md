# MySQL Docker Configuration 🐋

Este repositorio contiene la configuración de un contenedor Docker para MySQL 8.0, optimizado para rendimiento y recursos.

## 📁 Estructura del Proyecto

MYSQL/
├── mysql/
│   └── conf/
│       └── my.cnf       # Configuración de MySQL
├── .env                 # Variables de entorno
└── docker-compose.yml   # Configuración de Docker

## ⚙️ Detalles de Configuración

### 1. Variables de Entorno
El archivo `.env` contiene las credenciales y configuración básica de la base de datos:
- Password para root
- Nombre de la base de datos
- Usuario y contraseña para acceso regular
- Configuración segura y separada del código

### 2. Optimizaciones MySQL
El archivo `my.cnf` incluye optimizaciones para:
- Buffer pool de 2GB con 4 instancias
- Configuración de logs optimizada
- Soporte para 1000 conexiones simultáneas
- Codificación UTF8MB4 para soporte completo de caracteres

### 3. Configuración Docker
El `docker-compose.yml` establece:
- Imagen MySQL 8.0
- Límites de recursos (CPU y memoria)
- Configuración de red aislada
- Sistema de healthcheck
- Persistencia de datos

## 🚀 Características Principales

- **Rendimiento Optimizado**: Configuración balanceada para uso eficiente de recursos
- **Seguridad**: Credenciales separadas y red aislada
- **Persistencia**: Datos almacenados en volumen Docker
- **Alta Disponibilidad**: Reinicio automático y healthchecks
- **Healthcheck**: Verificación de estado cada 10 segundos con 5 reintentos

## 🛠️ Requisitos del Sistema

- Docker y Docker Compose instalados
- Mínimo 4GB RAM disponible
- 2 cores CPU disponibles
- Espacio en disco para persistencia

## 📚 Uso Básico

1. **Iniciar el servicio**: `docker-compose up -d`
2. **Detener el servicio**: `docker-compose down`
3. **Acceder a MySQL**: `docker exec -it mysql_db mysql -u [usuario] -p`

## 🔧 Mantenimiento

- Backups automáticos configurables
- Logs accesibles vía Docker
- Monitoreo de recursos integrado
- Fácil actualización de configuraciones