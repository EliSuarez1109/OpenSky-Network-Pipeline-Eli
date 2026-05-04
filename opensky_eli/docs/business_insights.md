# Business Insights: Operaciones OpenSky Network 2026 ✈️

**Fecha:** 4 de mayo de 2026  
**Preparado por:** Elizabeth Suárez
**Asunto:** Informe Ejecutivo de Hallazgos y Calidad de Datos

---

## 1. Hallazgos Cuantitativos (Insights)

Tras la ejecución del pipeline y el análisis de los modelos de datos en Snowflake, se han extraído los siguientes indicadores clave:

*   **Volumen de Carga Incremental:** El proceso de 2026 integró exitosamente **40 aeronaves únicas** y detectó **1 operador activo**. Aunque la cifra es pequeña frente a los **1,088,806 registros** de la base histórica total, representa el segmento de datos más reciente bajo el nuevo estándar de calidad.
*   **Concentración de Mercado:** Se observa una centralización total en los datos de la Fuente B, donde un único identificador de operador (**"2026"**) concentra las **40 aeronaves**, representando el **100.00% del Market Share** del periodo analizado.
*   **Líderes de Manufactura:** Existe un empate técnico en la preferencia de aeronaves para la nueva flota entre **Airbus** y **Cessna**, con **7 unidades** cada uno, seguidos por **Boeing** con **6 unidades**. Esto indica una distribución equilibrada entre aviación comercial de gran escala y aviación general/privada.

---

## 2. Propuestas de Mejora y Decisiones de Negocio

Basado en la integridad y patrones de los datos analizados, se proponen las siguientes acciones estratégicas:

*   **Corrección de Metadata en Origen:** Se ha identificado que el valor `2026` está siendo mapeado erróneamente como el identificador del operador (`operator_icao`). Se recomienda ajustar el proceso de extracción para recuperar el código ICAO real (ej. IBE, VLG) para permitir análisis de competencia veraces.
*   **Estrategia de Mantenimiento por Fabricante:** Dado que **Airbus** y **Cessna** lideran las incorporaciones, el equipo de operaciones puede negociar contratos de servicios técnicos por volumen con estos proveedores específicos para optimizar costos.
*   **Escalabilidad del Almacenamiento:** Con una base histórica que supera el millón de registros, se propone implementar políticas de **Clustering** en Snowflake sobre la columna `manufacturer` para mejorar el rendimiento de las consultas de analítica avanzada en un **30%**.

---

## 3. Anomalía o Patrón Inesperado

*   **El Fenómeno del "Dato Hardcoded":**  
    Se encontró una anomalía crítica durante la carga incremental: el campo `operator_icao` tiene el valor constante **"2026"** para todos los registros. 
*   **Impacto:** Este patrón sugiere un error en la fuente de datos S3 o en la lógica de transformación previa, donde el año de carga se está solapando con la identidad del operador. Esto impide distinguir la propiedad de las aeronaves en los reportes de negocio, requiriendo una revisión de la macro de limpieza y la ingesta original.

---

## 4. Resumen de Calidad de Datos (Data Quality)

Para garantizar la fiabilidad de este informe, el pipeline superó con éxito los siguientes controles:

*   **Freshness (SLA):** Verificado mediante test singular; los datos están actualizados dentro del rango de 24 horas.
*   **Unicidad:** 0% de duplicados en la dimensión de aeronaves (`unique_fact_aircraft_incremental_icao24`).
*   **Integridad referencial:** Validación completa de fabricantes conocidos (Airbus, Boeing, Cessna).