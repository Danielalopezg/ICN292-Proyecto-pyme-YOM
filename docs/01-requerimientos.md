# 01 · Requerimientos

Se mantienen los de la Entrega 1. La columna **E2** indica dónde quedó implementado cada uno.

| ID | Requisito | MoSCoW | E2 |
|---|---|---|---|
| RF01 | Capturar los datos del nuevo ingreso en un formulario digital | Must | Formulario de datos generales (RRHH) + formulario de documentos (trabajador) |
| RF02 | No continuar el flujo con datos incompletos o repetidos | Must | `Code in JavaScript` + `If` en n8n; CHECK/UNIQUE en la base (ver hallazgo del `If` en `05`) |
| RF03 | Registrar el estado de cada documento | Must | tabla `documento` (estado derivado de `fecha_recepcion`) |
| RF04 | Recordatorio automático al líder | Must | nodo `Envío recordatorio a líder` |
| RF05 | Correo de bienvenida automático | Must | nodos `Bienvenida a Yom` y `Datos importantes a nuevo Yomer` |
| RF06 | Aviso al Chief of Staff para crear accesos | Must | nodo `Aviso a Sofi: creación de accesos` (Slack) |
| RF07 | Aviso de bienvenida por Slack | Should | nodos `Aviso de bienvenida al team de Yom` y `Mensaje de bienvenida automatizado` |
| RF08 | Agendar reunión con el onboarding buddy | Must | nodo `Reunión entre Nuevo Yomer y Onboarding Buddy` + tabla `reunion` |
| RF09 | Indicaciones al buddy | Should | nodo `Indicaciones Onboarding Buddy` |
| RF10 | Diferenciar contratado / practicante | Must | `onboarding.tipo_vinculo`, `v_contrato` (campo propuesto para el formulario) |
| RF11 | Registrar cada acción (canal, destinatario, fecha, estado) | Could → **hecho** | tablas `accion` + `notificacion` |
| RNF01 | Disponibilidad del motor de automatización | Must | n8n Cloud, workflow activo, polling cada 1 min |
| RNF02 | Formulario completable en < 10 min | Should | formulario de datos generales de 1 página |
| RNF03 | Registro trazable con fecha y estado | Must | SQLite con FK, CHECK y UNIQUE |
| RNF04 | Protección de datos personales (Ley 21.719) | Must | ver `anexo-ley-21719.md` |
| RNF05 | Acciones en paralelo y en minutos | Should | Q1: 1,1 min promedio |
| RNF06 | Reproducible por un tercero | Must | `README.md` (solo requiere sqlite3) |
