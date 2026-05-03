# Estrategia de Datos: Fuente A y Fuente B

## Fuente A: Carga Histórica Inicial
- **Origen:** Dataset masivo de OpenSky Network (Aircraft Database Complete).
- **Volumen:** ~1,100,000 filas.
- **Estructura:** Se han derivado 5 tablas (3 Dimensiones, 2 de Hechos) mediante transformaciones SQL en Snowflake, cumpliendo con el requisito de normalización y volumen.

## Fuente B: Carga Incremental Diaria
Para simular el flujo diario de nuevos registros de aeronaves, se generarán archivos CSV sintéticos que representan las altas en el registro global de las últimas 24 horas.

### Prompt para generación de Fuente B :
> "Genera un archivo CSV con 10 registros de aviones nuevos siguiendo este esquema: icao24, registration, manufacturername, model, typecode, operator, owner, built. Usa fechas de construcción de 2026. Asegúrate de incluir una columna 'aws_load_date' con la fecha actual (2026-05-04) para simular la fecha de llegada al bucket."

### Justificación de Realismo
Los datos generados mantienen la coherencia técnica (formatos de ICAO24 y matrículas reales) y respetan la integridad referencial con las dimensiones de fabricantes ya existentes en la Fuente A.