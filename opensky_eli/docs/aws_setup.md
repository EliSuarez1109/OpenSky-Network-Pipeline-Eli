# Configuración de Infraestructura AWS

## 1. Bucket S3
- **Nombre:** `opensky-eli-dbt-daily-feed`
- **Región:** us-east-1

## 2. Configuración de Acceso
Debido a las restricciones del entorno de laboratorio (AWS Academy/Learner Lab), se utilizan credenciales temporales del **LabRole** para la conexión.

### Pasos realizados:
1. Creación del bucket estándar.
2. Obtención de `Access Key`, `Secret Key` y `Session Token` desde la consola del laboratorio.
3. Configuración de un **External Stage** en Snowflake con estas credenciales para permitir la lectura del archivo diario.

> **Nota:** Las capturas de pantalla del bucket y el comando `LIST @STAGE` se adjuntan en el documento de entregable.