# Declaración de uso de inteligencia artificial

ICN-292 · Entrega 2 · Equipo P101 — You Order Me SpA

El equipo declara haber usado asistentes de IA generativa durante el desarrollo de esta entrega.
A continuación se detalla en qué se usaron, qué quedó bajo responsabilidad del equipo y qué no se
delegó a la herramienta.

## Herramientas utilizadas

| Herramienta | Uso |
|---|---|
| Claude (Anthropic) | Apoyo en redacción y estructura del informe, revisión del esquema SQL, generación del script de datos sintéticos y revisión del flujo n8n exportado |

*(Completar si el equipo usó además otra herramienta, por ejemplo ChatGPT o GitHub Copilot.)*

## En qué se usó

| Producto | Aporte de la IA | Aporte y responsabilidad del equipo |
|---|---|---|
| Levantamiento del caso | Ninguno | Entrevista a la Chief of Staff de YOM (27-08-2026), realizada íntegramente por el equipo |
| Flujo n8n | Ninguno en su construcción | El flujo fue diseñado, implementado y probado por el equipo con la empresa |
| BPMN AS-IS y TO-BE | Ninguno en el trazado | Diagramados por el equipo en Lucidchart a partir de la entrevista y del flujo real |
| Modelo de datos (3FN) | Revisión crítica de la normalización y de las anomalías detectadas | Decisiones de diseño, elección de entidades, claves y reglas |
| `schema.sql`, `queries.sql`, `pruebas_restricciones.sql` | Apoyo en redacción SQL y en la revisión de restricciones | Definición de las preguntas de negocio y validación de cada resultado |
| `seed.sql` | Generado por el script `scripts/generar_seed.py`, escrito con apoyo de IA | Calibración de los parámetros con los tiempos reportados en la entrevista |
| Informe y documentación `.md` | Apoyo en redacción y ordenamiento | Contenido, datos, interpretaciones y conclusiones |
| Presentación | Apoyo en estructura | Guion y defensa oral |

## Verificación

- Todos los números del informe provienen de ejecutar `db/queries.sql` sobre la base cargada con
  `schema.sql` y `seed.sql`. La salida está en [`evidencia-ejecucion.md`](evidencia-ejecucion.md).
  Ningún resultado fue escrito a mano ni estimado.
- Los datos de `seed.sql` son **sintéticos**: ninguna persona es real y el dominio de correo es
  ficticio. No se publicaron datos personales de trabajadores de YOM.
- El flujo n8n publicado es el real, con los identificadores internos de la empresa reemplazados
  por marcadores mediante `scripts/sanitizar_n8n.py`.
- Las afirmaciones sobre el proceso actual provienen de la entrevista y no de la herramienta.

## Qué no se delegó

La entrevista, la implementación y prueba del flujo n8n, las decisiones de modelado, la
interpretación de los resultados y la defensa oral son trabajo del equipo. El equipo revisó y
asume la responsabilidad por todo el contenido entregado.
