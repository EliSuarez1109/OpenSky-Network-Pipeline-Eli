# OpenSky Network Data Pipeline

Este proyecto consiste en el diseño y construcción de un pipeline de datos **end-to-end** para el análisis de la flota global de aeronaves. Utiliza datos de **OpenSky Network**, procesando más de 1.1 millones de registros históricos y gestionando cargas incrementales diarias.

## Arquitectura del Proyecto

El pipeline integra las siguientes tecnologías del "Modern Data Stack":
*   **Fuente de Datos:** OpenSky Aircraft Database (CSV).
*   **Infraestructura Cloud:** AWS S3 (Bucket para cargas diarias).
*   **Data Warehouse:** Snowflake (Esquemas RAW y ANALYTICS).
*   **Transformación:** dbt Core (Modelado dimensional e incremental).
*   **Visualización:** Power BI (DirectQuery).

## Estado Actual del Proyecto

Hasta el momento, se han completado las siguientes fases:

### 1. Ingesta de la Fuente A (Histórica)
*   Se han cargado exitosamente **1,088,806 filas** desde el dataset `aircraft-database-complete`.
*   Los datos se ingirieron en Snowflake en la tabla `OPENSKY_DB.RAW.AIRCRAFT_RAW`.
*   Se implementó una carga flexible mediante una columna `STRING` para gestionar inconsistencias de formato y caracteres UTF-8.

### 2. Modelado en Snowflake
Se ha diseñado y ejecutado un esquema en estrella (**Star Schema**) que distribuye los datos en 5 tablas:
*   **Dimensiones:** `DIM_MODELS`, `DIM_OPERATORS`, `DIM_OWNERS`.
*   **Hechos:** `FACT_AIRCRAFT_INVENTORY`, `FACT_OPERATOR_STATS`.

### 3. Configuración de dbt
*   Proyecto dbt inicializado bajo el nombre `opensky_eli`.
*   Configuración de seguridad mediante `.gitignore` para excluir `profiles.yml`, `target/` y logs.
*   Documento de diseño inicializado en `docs/project_design.md`.

## Estructura del Repositorio
```text
.
├── opensky_eli/              # Proyecto dbt
│   ├── docs/                 # Documentación técnica (.md)
│   ├── models/               # Modelos SQL (Staging y Marts)
│   ├── macros/               # Macros personalizadas
│   └── dbt_project.yml       # Configuración del proyecto
├── logs/                     # Logs de ejecución (ignorado en Git)
├── .gitignore                # Reglas de exclusión de seguridad
└── README.md                 # Guía del proyecto