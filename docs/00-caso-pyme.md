# Caso PYME: You Order Me SpA

## Identificación

You Order Me SpA (YOM) es una empresa chilena dedicada al desarrollo de software y tecnología para el comercio.

| Atributo | Detalle |
|---|---|
| Razón social | You Order Me SpA (YOM) |
| Rubro | Desarrollo de software y tecnología para el comercio |
| Tamaño aproximado | 35 personas |
| Ubicación | Presidente Errázuriz 2999, oficina 502, Las Condes, Santiago de Chile |
| Modalidad de trabajo | Híbrida (presencial y remota) |
| Contraparte del proyecto | Sofía, Chief of Staff |

La estructura interna es plana y con roles acotados, lo que explica que una misma persona, la Chief of Staff, concentre buena parte de la coordinación administrativa. El esquema híbrido es relevante para el proceso analizado, porque parte de la coordinación de la incorporación depende de saber qué días asiste presencialmente cada persona.

## Evidencia de existencia

La verificación se realizó mediante una **entrevista semiestructurada** con Sofía, Chief of Staff de YOM, efectuada el **27 de agosto de 2026**. La entrevista se orientó a reconstruir el proceso de incorporación paso a paso: quién inicia cada actividad, qué herramienta se usa, cuánto demora y qué ocurre cuando algo falla.

La transcripción completa está en [informe/Entrevista_YOM.pdf](../informe/Entrevista_YOM.pdf) y se referencia en el Anexo A del informe.

## Problema de negocio

El proceso de incorporación de nuevo personal está disperso entre herramientas informales. La captura de datos se realiza con un Google Form cuyas respuestas quedan en una planilla de Google Sheets, sin repositorio oficial ni validación estandarizada. No existe un lugar único donde consultar en qué etapa se encuentra cada ingreso, de modo que el seguimiento depende de que las personas involucradas se pregunten entre sí por correo o mensajería.

Esta forma de trabajo produce cuatro efectos concretos identificados en la entrevista:

- **Tiempos de espera.** Consolidar los datos de un nuevo trabajador toma más de un día, principalmente por esperas de respuesta y por el reenvío de formularios mal completados. Desde el inicio del proceso hasta tener el contrato firmado transcurre hasta una semana y media.
- **Riesgo de pérdida de información.** Los datos de la planilla se pierden o se desalinean si el formulario se modifica, ya que las columnas dejan de corresponder a las preguntas originales.
- **Informalidad en el ingreso de practicantes.** El flujo para practicantes está menos definido que el de trabajadores contratados, lo que aumenta la variabilidad del proceso.
- **Costo indirecto de coordinación.** RRHH y las jefaturas destinan tiempo a resolver manualmente excepciones como documentos faltantes o reenvíos.

El problema no es la falta de una herramienta puntual, sino la ausencia de un sistema que centralice los datos, dispare las acciones del proceso de forma automática y permita saber en qué estado está cada incorporación.

## Objetivo del SIG

**Automatizar y centralizar el proceso de incorporación de nuevo personal de YOM**, de modo que las acciones asociadas al ingreso se ejecuten a partir de los datos entregados por el trabajador y no de la coordinación manual entre áreas. La automatización se implementa con n8n y el registro queda en una base de datos relacional que funciona como repositorio único.

Objetivos específicos:

- Reemplazar la planilla de Google Sheets por un repositorio único y trazable.
- Disparar de forma automática y en paralelo las notificaciones y acciones que hoy se ejecutan de manera secuencial y manual.
- Registrar el estado de cada etapa y de cada documento, consultable en un solo lugar por RRHH y las jefaturas.
- Habilitar la medición del proceso mediante indicadores de tiempo y de completitud, hoy inexistentes.
