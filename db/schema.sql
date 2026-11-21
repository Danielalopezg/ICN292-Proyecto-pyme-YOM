-- =====================================================================
-- ICN-292 · Entrega 2 · Caso You Order Me (YOM) — Onboarding automatizado con n8n
-- schema.sql — modelo normalizado a 3FN.  Motor: SQLite 3 (>= 3.31)
--
-- Origen: la planilla operativa "Onboarding_Master" donde n8n registra cada ingreso
-- (nodo "Append row in sheet"). Esa planilla repite líder y buddy en cada fila y tiene
-- una columna por tipo de documento; este esquema es su versión normalizada.
-- Cambios respecto a la Entrega 1: docs/CHANGELOG.md
-- =====================================================================
PRAGMA foreign_keys = ON;

DROP VIEW  IF EXISTS v_estado_onboarding;
DROP VIEW  IF EXISTS v_contrato;
DROP VIEW  IF EXISTS v_notificacion;
DROP TABLE IF EXISTS reunion;
DROP TABLE IF EXISTS notificacion;
DROP TABLE IF EXISTS accion;
DROP TABLE IF EXISTS documento;
DROP TABLE IF EXISTS contrato;
DROP TABLE IF EXISTS contacto_emergencia;
DROP TABLE IF EXISTS onboarding;
DROP TABLE IF EXISTS colaborador;

-- Personas de YOM que participan como líder o como onboarding buddy.
-- En Onboarding_Master se repetían (lider, liderEmail, buddyNombre, buddyEmail, telefonobuddy) en cada fila.
CREATE TABLE colaborador (
  id_colaborador  INTEGER PRIMARY KEY,
  nombre          TEXT NOT NULL,
  email           TEXT NOT NULL UNIQUE,
  telefono        TEXT
);

-- Una fila por proceso de incorporación (= una fila de Onboarding_Master).
CREATE TABLE onboarding (
  id_onboarding         INTEGER PRIMARY KEY,
  codigo                TEXT NOT NULL UNIQUE,      -- onboardingId de n8n: email + fecha (aaaammdd)
  nombre                TEXT NOT NULL,
  email_personal        TEXT NOT NULL,
  correo_corporativo    TEXT UNIQUE,               -- "Correo nuevo yom"
  rut                   TEXT UNIQUE,               -- lo informa el trabajador en el formulario de documentos
  cargo                 TEXT NOT NULL,
  tipo_vinculo          TEXT NOT NULL CHECK (tipo_vinculo IN ('contratado','practicante')),
  id_lider              INTEGER NOT NULL REFERENCES colaborador(id_colaborador),
  id_buddy              INTEGER NOT NULL REFERENCES colaborador(id_colaborador),
  link_carta_oferta     TEXT,
  fecha_ingreso         TEXT NOT NULL,             -- AAAA-MM-DD
  fecha_registro        TEXT NOT NULL,             -- cuando RRHH completa el formulario de datos generales
  flujo                 TEXT NOT NULL CHECK (flujo IN ('manual','n8n')),   -- AS-IS vs. TO-BE
  consentimiento_datos  INTEGER NOT NULL DEFAULT 0 CHECK (consentimiento_datos IN (0,1)),
  fecha_consentimiento  TEXT,
  CHECK (id_lider <> id_buddy)
  -- La contraseña provisoria NO se almacena (en la planilla quedaba en texto plano).
);

-- Dato de un tercero: separado para restringir su acceso (Ley 21.719).
CREATE TABLE contacto_emergencia (
  id_onboarding  INTEGER PRIMARY KEY REFERENCES onboarding(id_onboarding) ON DELETE CASCADE,
  nombre         TEXT NOT NULL,
  telefono       TEXT NOT NULL,
  relacion       TEXT NOT NULL
);

-- Contrato vía Buk (contratados) o contrato interno (practicantes). 1:1 con onboarding.
CREATE TABLE contrato (
  id_contrato      INTEGER PRIMARY KEY,
  id_onboarding    INTEGER NOT NULL UNIQUE REFERENCES onboarding(id_onboarding) ON DELETE CASCADE,
  fecha_solicitud  TEXT NOT NULL,
  fecha_firma      TEXT,                           -- NULL = sin firmar
  estado           TEXT NOT NULL CHECK (estado IN ('solicitado','enviado_firma','firmado')),
  CHECK ((estado = 'firmado') = (fecha_firma IS NOT NULL))
);

-- En Onboarding_Master había una columna por documento (afpAfiliacionFileIds, saludAfiliacionFileIds, ...):
-- grupo repetitivo (viola 1FN). Aquí cada documento es una fila. El estado se deriva de fecha_recepcion.
CREATE TABLE documento (
  id_documento     INTEGER PRIMARY KEY,
  id_onboarding    INTEGER NOT NULL REFERENCES onboarding(id_onboarding) ON DELETE CASCADE,
  tipo             TEXT NOT NULL CHECK (tipo IN ('afp_afiliacion','afp_cotizaciones','salud_afiliacion',
                                                  'cedula','antecedentes','foto_personal')),
  drive_file_id    TEXT,                           -- solo la referencia al archivo en Drive, nunca el contenido
  fecha_solicitud  TEXT NOT NULL,
  fecha_recepcion  TEXT,                           -- NULL = pendiente
  UNIQUE (id_onboarding, tipo)
);

-- Catálogo de las 8 acciones del flujo n8n. Canal y destinatario dependen de la acción, no de cada envío:
-- guardarlos en notificacion sería una dependencia transitiva.
CREATE TABLE accion (
  codigo            TEXT PRIMARY KEY,
  nodo_n8n          TEXT NOT NULL UNIQUE,          -- nombre exacto del nodo en automatizacion/onboarding_yom.json
  canal             TEXT NOT NULL CHECK (canal IN ('correo','slack','calendario')),
  destinatario_rol  TEXT NOT NULL CHECK (destinatario_rol IN ('trabajador','lider','chief_of_staff','buddy','trabajador_y_buddy','equipo')),
  diferida          INTEGER NOT NULL DEFAULT 0 CHECK (diferida IN (0,1))   -- 1 = sale después del nodo Wait
);

-- Cada fila = una acción ejecutada para un onboarding (trazabilidad n8n <-> datos).
CREATE TABLE notificacion (
  id_notificacion  INTEGER PRIMARY KEY,
  id_onboarding    INTEGER NOT NULL REFERENCES onboarding(id_onboarding) ON DELETE CASCADE,
  codigo_accion    TEXT NOT NULL REFERENCES accion(codigo),
  fecha_envio      TEXT NOT NULL,                  -- AAAA-MM-DD HH:MM:SS
  estado           TEXT NOT NULL CHECK (estado IN ('enviado','fallido')),
  UNIQUE (id_onboarding, codigo_accion)
);

-- Reunión trabajador–buddy creada en Google Calendar. Los asistentes NO se repiten aquí:
-- el buddy ya está en onboarding.id_buddy (evita dependencia transitiva).
CREATE TABLE reunion (
  id_reunion      INTEGER PRIMARY KEY,
  id_onboarding   INTEGER NOT NULL UNIQUE REFERENCES onboarding(id_onboarding) ON DELETE CASCADE,
  event_id        TEXT,                            -- meetingEventId de Google Calendar
  inicio          TEXT NOT NULL,
  fin             TEXT NOT NULL,
  fecha_agendada  TEXT NOT NULL,
  CHECK (fin > inicio)
);

CREATE INDEX idx_notif_onb ON notificacion(id_onboarding);
CREATE INDEX idx_doc_onb   ON documento(id_onboarding);

-- Vista: notificaciones con su canal y destinatario (lo que antes era columna repetida)
CREATE VIEW v_notificacion AS
SELECT n.*, a.nodo_n8n, a.canal, a.destinatario_rol, a.diferida
FROM notificacion n JOIN accion a ON a.codigo = n.codigo_accion;

-- Vista: contrato con datos derivados (en E1 "gestionado_por_buk" era un atributo almacenado)
CREATE VIEW v_contrato AS
SELECT c.*, o.tipo_vinculo, o.flujo,
       CASE WHEN o.tipo_vinculo = 'contratado' THEN 1 ELSE 0 END AS gestionado_por_buk,
       ROUND(julianday(c.fecha_firma) - julianday(o.fecha_registro), 1) AS dias_hasta_firma
FROM contrato c JOIN onboarding o ON o.id_onboarding = c.id_onboarding;

-- Vista: estado de cada incorporación. En la planilla "estado" se escribía como texto fijo
-- ("Datos solicitados"); aquí se DERIVA de los hechos registrados y no puede quedar desactualizado.
CREATE VIEW v_estado_onboarding AS
SELECT o.id_onboarding, o.codigo, o.nombre, o.cargo, o.tipo_vinculo, o.flujo, o.fecha_ingreso,
       l.nombre AS lider, b.nombre AS buddy,
       (SELECT COUNT(*) FROM notificacion n WHERE n.id_onboarding = o.id_onboarding AND n.estado = 'enviado') AS acciones_enviadas,
       (SELECT COUNT(*) FROM notificacion n WHERE n.id_onboarding = o.id_onboarding AND n.estado = 'fallido') AS acciones_fallidas,
       (SELECT COUNT(*) FROM documento d WHERE d.id_onboarding = o.id_onboarding AND d.fecha_recepcion IS NULL) AS documentos_pendientes,
       COALESCE((SELECT c.estado FROM contrato c WHERE c.id_onboarding = o.id_onboarding), 'sin_contrato') AS contrato,
       CASE
         WHEN EXISTS (SELECT 1 FROM contrato c WHERE c.id_onboarding = o.id_onboarding AND c.estado = 'firmado')
          AND NOT EXISTS (SELECT 1 FROM documento d WHERE d.id_onboarding = o.id_onboarding AND d.fecha_recepcion IS NULL)
              THEN 'completo'
         WHEN NOT EXISTS (SELECT 1 FROM documento d WHERE d.id_onboarding = o.id_onboarding AND d.fecha_recepcion IS NULL)
              THEN 'documentos_completos'
         ELSE 'datos_solicitados'
       END AS estado
FROM onboarding o
JOIN colaborador l ON l.id_colaborador = o.id_lider
JOIN colaborador b ON b.id_colaborador = o.id_buddy;
