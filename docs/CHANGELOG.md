# CHANGELOG — Entrega 1 → Entrega 2

## Se mantuvo
- Caso PYME (YOM), equipo, problema, objetivo del SIG y requerimientos (`01`).
- BPMN AS-IS.
- La idea central del TO-BE: un registro dispara en paralelo las acciones de bienvenida.

## Proceso (BPMN TO-BE y n8n)
| Cambio | Motivo |
|---|---|
| Disparador: formulario de **RRHH** (datos generales) en vez del formulario del trabajador | Los datos que necesita la automatización (líder, buddy, correo corporativo, carta) los tiene RRHH |
| Se agrega *Registrar ingreso en Onboarding_Master* y el gateway *¿Ingreso ya procesado?* | Así quedó implementado (nodos `Append row in sheet` e `If`) |
| De 7 acciones a **6 ramas con 8 acciones** | Ramas secuenciales en n8n: aviso de accesos → datos del primer día; reunión → espera → bienvenida del día 1 |
| Evento temporizador antes de la bienvenida del día 1 | Nodo `Wait` |
| Tareas en infinitivo | Convención BPMN verbo + objeto |

## Datos (ER y SQL)
| Cambio | Motivo |
|---|---|
| `trabajador` → `onboarding`, con `codigo`, `correo_corporativo`, `link_carta_oferta` | Calza 1 a 1 con una fila de `Onboarding_Master` |
| `lider` + `buddy` → una sola tabla `colaborador` | Una persona puede ser líder y buddy; evita anomalías de inserción, actualización y eliminación |
| Se elimina `area` | El formulario real no la captura; no se modelan datos que el proceso no genera |
| `documento` con los 6 tipos de la planilla y `drive_file_id`; sin columna `estado` | Normaliza el grupo repetitivo `…FileIds` (1FN); el estado se deriva de `fecha_recepcion` |
| Nuevo catálogo `accion` (8 nodos n8n); `notificacion` ya no guarda canal ni destinatario | Elimina dependencia transitiva (3FN) y traza cada fila a un nodo |
| `reunion` sin `rut_buddy`, con `event_id`, `inicio` y `fin` | El buddy ya está en `onboarding` (3FN); calza con Google Calendar |
| `fecha_registro` separada de `fecha_ingreso` | En la planilla `createdAt` repetía la fecha de entrada |
| La contraseña provisoria no se almacena | Seguridad y Ley 21.719 |
| Estado del ingreso **derivado** en `v_estado_onboarding` | En la planilla era un texto fijo que no se actualizaba |
| Nuevo `db/pruebas_restricciones.sql` | Evidencia de que la base rechaza las anomalías |

## Repositorio y entrega
| Cambio | Motivo |
|---|---|
| Stack propuesto en E1 (PostgreSQL + Docker + Metabase) → **SQLite** | La prueba de oro debe correr en un PC limpio solo con el cliente SQL |
| README centrado en clonar → cargar → consultar | Exigencia de la pauta E2 |
| Interfaz Streamlit pasa a ser opcional y solo de lectura | No es requisito de la E2; el registro real lo hace n8n |
| Nuevos `docs/05-automatizacion-n8n.md` y `docs/DECLARACION_IA.md` | Exigencias de la pauta E2 |
