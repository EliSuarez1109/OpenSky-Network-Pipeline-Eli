# Documento de Diseño: Pipeline de Datos OpenSky Network

## 1. Descripción del dominio y problemática
**Dominio:** Aviación Civil y Registros Globales de Aeronaves.

**Problemática:** 
Los datos de registros de aeronaves a menudo se encuentran en formatos crudos con inconsistencias significativas. Durante la fase de ingesta, se identificaron desafíos técnicos como:
*   Inconsistencias en la codificación de caracteres (errores de UTF-8).
*   Delimitadores complejos dentro de campos de texto.
*   Presencia de comillas dobles innecesarias que envuelven los datos y ensucian los registros.

Este proyecto aborda la centralización y limpieza de más de **1.1 millones de registros históricos** (Fuente A) para permitir a los analistas consultar información veraz sobre fabricantes, operadores y dueños de aeronaves, eliminando la complejidad del dato original mediante transformaciones en dbt.

## 2. Preguntas analíticas
El Data Warehouse está diseñado para responder a las siguientes interrogantes de negocio:
1.  **Concentración de Mercado:** ¿Cuáles son los 5 principales fabricantes que dominan la flota global y qué porcentaje del total representan?
2.  **Diversidad de Flota por Operador:** ¿Qué aerolíneas (operadores) poseen la flota más diversificada en términos de modelos de aeronaves distintos?
3.  **Análisis de Ciclo de Vida:** ¿Cuál es la antigüedad promedio de las aeronaves desglosada por fabricante y modelo?

## 3. Esquema dimensional propuesto
Se implementa un modelo en estrella (**Star Schema**) para optimizar el rendimiento de las consultas y facilitar la integración con Power BI mediante DirectQuery.

### Tablas de Dimensiones
*   **`DIM_MODELS`**: Atributos del fabricante, nombre del modelo y código de tipo.
*   **`DIM_OPERATORS`**: Información de aerolíneas, incluyendo callsigns.
*   **`DIM_OWNERS`**: Registro de los propietarios legales de las aeronaves.

### Tablas de Hechos
*   **`FACT_AIRCRAFT_INVENTORY`**: Tabla de hechos (una fila por `icao24`). Conecta con todas las dimensiones mediante llaves subrogadas (MD5).
*   **`FACT_OPERATOR_STATS`**: Tabla de hechos agregada que precalcula métricas de volumen para mejorar el tiempo de respuesta del dashboard.

> **Diagrama Lógico:** Las tablas de dimensiones se relacionan con las tablas de hechos mediante llaves primarias (`model_id`, `operator_id`, `owner_id`) en una relación de **1:N**.

## 4. Justificación de la elección de fuente de datos
Se seleccionó la **OpenSky Aircraft Database (Complete)** debido a:
*   **Volumen:** Provee un dataset masivo que supera con creces el requisito mínimo de 500,000 filas.
*   **Calidad de Aprendizaje:** Los errores de formato encontrados (comillas, tipos de datos) son ideales para demostrar capacidades de limpieza de datos (Data Cleaning) y modelado avanzado.

## 5. Estrategia de carga incremental
Para la **Fuente B (S3)**, se utiliza una estrategia de **"Append"** controlada:
1.  **Ingesta Automatizada:** Los archivos cada 2 horas se cargan desde un External Stage de AWS S3 mediante el comando `COPY INTO`.
2.  **Detección de Novedades:** Se utiliza la columna de auditoría `_LOADED_AT` para identificar nuevos registros.
3.  **Modelado dbt:** Los modelos se configuran como `materialized='incremental'`.
4.  **Optimización:** dbt utiliza un filtro `is_incremental()` para procesar únicamente los datos cuya fecha de carga sea superior a la máxima existente en el warehouse, garantizando eficiencia y ahorro de créditos en Snowflake.