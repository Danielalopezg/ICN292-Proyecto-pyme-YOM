-- =====================================================================
-- pruebas_restricciones.sql — demuestra que la base RECHAZA datos inválidos.
-- Cada INSERT/UPDATE de abajo DEBE fallar. Ejecutar sobre una base ya cargada:
--   sqlite3 db/yom.db < db/pruebas_restricciones.sql
-- (sqlite3 sigue con la siguiente instrucción tras cada error y los muestra todos)
-- =====================================================================
PRAGMA foreign_keys = ON;

-- P1 · Líder y buddy no pueden ser la misma persona
INSERT INTO onboarding (codigo,nombre,email_personal,cargo,tipo_vinculo,id_lider,id_buddy,fecha_ingreso,fecha_registro,flujo)
VALUES ('p1','Prueba','p1@x.cl','Analista','contratado',1,1,'2026-12-01','2026-11-09 10:00:00','n8n');

-- P2 · Un buddy que no existe en colaborador (integridad referencial)
INSERT INTO onboarding (codigo,nombre,email_personal,cargo,tipo_vinculo,id_lider,id_buddy,fecha_ingreso,fecha_registro,flujo)
VALUES ('p2','Prueba','p2@x.cl','Analista','contratado',1,999,'2026-12-01','2026-11-09 10:00:00','n8n');

-- P3 · Tipo de vínculo fuera del dominio
INSERT INTO onboarding (codigo,nombre,email_personal,cargo,tipo_vinculo,id_lider,id_buddy,fecha_ingreso,fecha_registro,flujo)
VALUES ('p3','Prueba','p3@x.cl','Analista','honorarios',1,6,'2026-12-01','2026-11-09 10:00:00','n8n');

-- P4 · El mismo documento dos veces para un mismo ingreso (antes: columna sobrescrita en la planilla)
INSERT INTO documento (id_onboarding,tipo,fecha_solicitud) VALUES (1,'cedula','2026-11-09 10:00:00');

-- P5 · Contrato "firmado" sin fecha de firma
UPDATE contrato SET fecha_firma = NULL WHERE id_contrato = 1;

-- P6 · Una notificación de una acción que no existe en el flujo n8n
INSERT INTO notificacion (id_onboarding,codigo_accion,fecha_envio,estado) VALUES (1,'accion_inventada','2026-11-09 10:00:00','enviado');

-- P7 · La misma acción registrada dos veces para un ingreso (evita duplicados si n8n se ejecuta de nuevo)
INSERT INTO notificacion (id_onboarding,codigo_accion,fecha_envio,estado) VALUES (11,'bienvenida_correo','2026-11-09 10:00:00','enviado');

-- P8 · Dos ingresos con el mismo correo corporativo
UPDATE onboarding SET correo_corporativo = 'benjamin.araya@yom-demo.cl' WHERE id_onboarding = 2;

SELECT 'Si ves 8 errores arriba, todas las restricciones funcionan.' AS resultado;
