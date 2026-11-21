# 05 · Automatización con n8n

- **Flujo exportado:** [`automatizacion/onboarding_yom.json`](../automatizacion/onboarding_yom.json)
  (identificadores internos reemplazados por marcadores con `scripts/sanitizar_n8n.py`; para reimportarlo hay
  que asociar credenciales propias de Google Sheets, Gmail, Slack y Google Calendar).
- **Captura del canvas:** [`automatizacion/canvas.jpeg`](../automatizacion/canvas.jpeg)
- **Estado:** workflow construido, activado y probado con la empresa en n8n Cloud. La evidencia que se
  publica aquí es el flujo exportado y la captura del canvas; el historial de ejecuciones queda en la cuenta
  de n8n de la empresa y no se reproduce en este repositorio por tratarse de datos de personas reales.

## Paso a paso, trazado al BPMN y a la base de datos

| # | Nodo n8n | Tipo | Qué hace | Tarea BPMN to-be | Dato en la base |
|---|---|---|---|---|---|
| 1 | Google Sheets Trigger | Sheets (polling cada 1 min) | Detecta una respuesta nueva o editada en *Formulario de Recolección de Datos Generales (Respuestas)* | Evento de inicio: *Ingreso confirmado* → *Detectar nueva respuesta* | `onboarding.fecha_registro` |
| 2 | Code in JavaScript | Código | Se queda con la última fila recibida | *Normalizar datos del ingreso* | — |
| 3 | Edit Fields | Set | Renombra campos, convierte la fecha serial de Sheets a AAAA-MM-DD, arma `onboardingId` y fija `estado = "Datos solicitados"` | *Normalizar datos del ingreso* | `onboarding.codigo`, `fecha_ingreso` |
| 4 | If | Condición | Pretende cortar si la fila ya fue procesada | Gateway XOR *¿Ingreso ya procesado?* | `UNIQUE` en `codigo` y en `notificacion` |
| 5 | Append row in sheet | Sheets | Agrega la fila a `Onboarding_Master` | *Registrar ingreso en Onboarding_Master* | fila en `onboarding` (+ `colaborador`) |
| — | (6 salidas en paralelo) | — | — | Gateway AND de apertura | — |
| 6 | Envío recordatorio a líder | Gmail | Avisa al líder quién entra, quién es su buddy y cuándo | *Enviar recordatorio al líder* | `notificacion` · `recordatorio_lider` |
| 7 | Bienvenida a Yom | Gmail | Correo al trabajador con carta de oferta, correo corporativo, contraseña provisoria y enlace al formulario de documentos | *Enviar bienvenida y formulario de documentos* | `notificacion` · `bienvenida_correo`; `documento.fecha_solicitud` |
| 8 | Aviso a Sofi: creación de accesos | Slack (mensaje directo) | Pide a la Chief of Staff crear los accesos | *Notificar creación de accesos* | `notificacion` · `aviso_accesos` |
| 9 | Datos importantes a nuevo Yomer | Gmail | Detalles del primer día (hora, dirección, vestimenta, contacto del buddy) | *Enviar datos del primer día* | `notificacion` · `datos_primer_dia` |
| 10 | Aviso de bienvenida al team de Yom | Slack (canal) | Anuncia al equipo el próximo ingreso | *Anunciar ingreso al equipo* | `notificacion` · `anuncio_equipo` |
| 11 | Code in JavaScript1 | Código | Calcula la reunión: día de ingreso, 10:00–11:00 (hora de Chile) | *Calcular horario de la reunión* | `reunion.inicio`, `reunion.fin` |
| 12 | Reunión entre Nuevo Yomer y Onboarding Buddy | Google Calendar | Crea el evento con trabajador y buddy como invitados | *Agendar reunión con el buddy* | `reunion`; `notificacion` · `reunion_buddy` |
| 13 | Wait | Espera | Pausa hasta que termina la reunión del primer día | Evento intermedio temporizador *Fin de la reunión del día 1* | — |
| 14 | Mensaje de bienvenida automatizado | Slack (canal) | Publica "hoy se integra…" en el canal general | *Publicar bienvenida del día 1* | `notificacion` · `bienvenida_dia1` (`diferida = 1`) |
| 15 | Indicaciones Onboarding Buddy | Gmail | Envía al buddy la presentación de cultura y le recuerda la reunión | *Enviar indicaciones al buddy* | `notificacion` · `indicaciones_buddy` |

Las ramas 8→9 y 11→12→13→14 son **secuenciales** dentro del paralelo; las demás son de un solo nodo. En total:
6 ramas y 8 acciones, que son exactamente las 8 filas de la tabla `accion`.

## Hallazgos de la revisión del flujo (para YOM)

Revisamos el JSON nodo por nodo y encontramos puntos de mejora que no impidieron la prueba, pero que conviene
corregir antes de usarlo de forma permanente:

1. **El nodo `If` no filtra filas ya procesadas.** La condición tiene un `=` de más (`=={{$json.procesado}}`),
   por lo que compara un texto que empieza con "=" contra un texto vacío y nunca resulta verdadera: todas las
   filas pasan. Como el trigger escucha *cualquier* edición de la planilla, editar una celda puede volver a
   disparar los correos. *Sugerencia:* `{{$json.procesado}}` igual a vacío → continuar, y escribir
   `procesado = sí` en la fila al terminar. En la base, los `UNIQUE` impiden registrar el duplicado.
2. **Dos ingresos en el mismo minuto:** `Code in JavaScript` toma solo la última fila, así que si RRHH registra
   dos personas dentro del mismo minuto de polling, la primera no se procesa. *Sugerencia:* procesar todas las
   filas nuevas (quitar ese nodo y dejar que el `If` filtre).
3. **`createdAt` se llena con la fecha de entrada**, no con la fecha de registro, por lo que la planilla no
   permite medir cuánto tarda el proceso. *Sugerencia:* `createdAt = {{$now}}`.
4. **La contraseña provisoria viaja por correo y queda en texto plano** en `Onboarding_Master`. *Sugerencia:*
   no guardarla y forzar el cambio en el primer inicio de sesión (ver `anexo-ley-21719.md`).
5. **Columnas que nadie llena:** `reunionAgendada`, `meetingEventId` y `correoEnviadoAt` existen en la planilla
   pero el flujo no las actualiza. *Sugerencia:* un nodo *Update row* al final de cada rama; esos son
   justamente los datos que la base SQL guarda en `reunion` y `notificacion`.

*(Verificar los puntos 1 y 2 en el editor de n8n antes de citarlos en la defensa.)*
