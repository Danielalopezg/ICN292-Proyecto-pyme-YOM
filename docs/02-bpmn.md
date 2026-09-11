# Procesos BPMN:

Esta sección presenta el proceso de incorporación en dos versiones: el *as-is*, tal como se ejecuta hoy, y el *to-be*, con la automatización propuesta.

## BPMN as-is:

![BPMN as-is](<../assets/BPMN_(AS-IS).png>)

El proceso actual es fundamentalmente secuencial: cada actividad espera a que la anterior termine y esa transición ocurre por correo o mensaje que alguien debe recordar enviar.

1. RRHH envía el formulario de incorporación (Google Forms) al nuevo trabajador.
2. El trabajador completa el formulario con su nombre, RUT, contacto de emergencia y documentos; las respuestas quedan en Google Sheets.
3. RRHH envía los datos a la agencia externa, que redacta el contrato.
4. RRHH y la jefatura directa validan los datos, y la gerencia general confirma sueldo y beneficios cuando corresponde.
5. El contrato se envía a Buk para la firma digital.
6. RRHH coordina los accesos generales (correo, Slack) e Ingeniería/TI crea los accesos técnicos (Linear, repositorio, sitio web) si aplica.
7. RRHH publica la bienvenida en Slack, agenda las reuniones y el desayuno, y avisa a la oficina según el esquema híbrido.
8. Camino de excepción: si falta un documento, el contacto con el trabajador es manual y no estandarizado (WhatsApp o correo).

**Pools y lanes:** Trabajador nuevo | RRHH | Jefatura directa | Gerencia general | Ingeniería/TI | Agencia externa / Buk.

No existe ningún punto en que las actividades se ejecuten en paralelo, pese a que varias son independientes entre sí. Esa es la principal oportunidad de mejora que recoge el rediseño.

## BPMN to-be:

![BPMN to-be](<../assets/BPMN_(TO-BE n8n).png>)

El evento que gatilla el flujo deja de ser un correo enviado por una persona y pasa a ser el envío del formulario por parte del nuevo trabajador. Ese envío llega a n8n mediante un webhook, que registra los datos y abre un gateway paralelo (AND) desde el cual se disparan simultáneamente las siete notificaciones y acciones del proceso.

| N.º | Acción automatizada | Destinatario | Canal |
|---|---|---|---|
| 1 | Correo de bienvenida a YOM | Nuevo trabajador | Correo electrónico |
| 2 | Aviso de bienvenida | Nuevo trabajador | Slack |
| 3 | Invitación a la reunión con el onboarding buddy | Nuevo trabajador | Calendario |
| 4 | Aviso para crear los accesos (correo, Slack, sistemas) | Chief of Staff / RRHH | Slack |
| 5 | Recordatorio de que debe incorporar a un nuevo trabajador | Líder de área | Correo o Slack |
| 6 | Invitación a la reunión con el nuevo trabajador | Onboarding buddy | Calendario |
| 7 | Indicaciones para completar el proceso de acompañamiento | Onboarding buddy | Correo electrónico |

Una vez ejecutadas las siete ramas, el flujo converge en un gateway de sincronización que cierra el proceso. Las actividades que dependen de terceros, como la redacción del contrato y su firma en Buk, se mantienen, pero quedan registradas con fecha y estado en lugar de depender del seguimiento informal de una persona.

**Pools y lanes:** Nuevo Trabajador | n8n (Automatización) | Chief of Staff / RRHH | Líder de Área | Onboarding Buddy.

## Explicación de mejoras:

**Qué se automatiza:** La propuesta reemplaza la planilla de Google Sheets por un repositorio único y trazable, y hace que al completarse el formulario se disparen por sí solas las siete notificaciones mediante n8n. Esto significa pasar de horas o días de gestión manual a minutos, ya que las ramas se ejecutan en paralelo.

**Qué se controla:** RRHH y la jefatura pueden ver el estado de cada documento (pendiente, enviado o recibido) en un solo medio, con fecha de solicitud y recepción, lo que permite detectar a tiempo los casos que se demoran.

**Qué se mide:**

| Indicador | Definición | Línea base | Meta |
|---|---|---|---|
| Duración total del proceso | Del envío del formulario al cierre del proceso | Hasta 1,5 semanas | Reducir |
| Duración por etapa | Tiempo transcurrido en cada etapa | Sin medición | Registrar |
| Latencia de notificaciones | Del formulario al disparo de notificaciones | Horas o días | Menos de 5 min |
| Documentos pendientes | Documentos sin recepcionar tras N días | Sin medición | A la baja |
| Tiempo de firma en Buk | Del envío a firma a la firma efectiva | Aprox. 1,5 semanas | Seguimiento |

La automatización no elimina todos los cuellos de botella: el tiempo de firma en Buk depende de un tercero, por lo que se incorpora como indicador de seguimiento y no como meta a reducir. Lo que sí cambia es que pasa a ser medible.
