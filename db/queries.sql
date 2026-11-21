-- =====================================================================
-- queries.sql — Consultas de negocio del caso YOM (onboarding)
-- Motor: SQLite 3. Ejecutar después de schema.sql y seed.sql (ver README.md).
-- Fecha de corte de los datos: 2026-11-09. Interpretación: docs/04-sql-consultas.md
-- =====================================================================

-- Q1 · ¿Cuánto tarda en salir cada aviso desde que RRHH registra el ingreso?
--      (en el AS-IS dependía de que RRHH se acordara; con n8n depende del polling de 1 minuto)
--      Se excluye la acción diferida (bienvenida del día 1), que sale a propósito el día de ingreso.
SELECT o.flujo,
       COUNT(*)                                                                         AS avisos,
       ROUND(AVG((julianday(n.fecha_envio) - julianday(o.fecha_registro)) * 24 * 60), 1) AS minutos_promedio,
       ROUND(MAX((julianday(n.fecha_envio) - julianday(o.fecha_registro)) * 24 * 60), 1) AS minutos_maximo
FROM v_notificacion n
JOIN onboarding o ON o.id_onboarding = n.id_onboarding
WHERE n.estado = 'enviado' AND n.diferida = 0
GROUP BY o.flujo;

-- Q2 · ¿Qué porcentaje de las 8 acciones de bienvenida recibe cada incorporación?
--      Solo ingresos ya ocurridos (para que la acción del día 1 haya podido ejecutarse).
SELECT o.flujo, o.tipo_vinculo,
       COUNT(DISTINCT o.id_onboarding)                                                  AS incorporaciones,
       ROUND(100.0 * COUNT(n.id_notificacion) / (8 * COUNT(DISTINCT o.id_onboarding)), 1) AS cobertura_pct
FROM onboarding o
LEFT JOIN notificacion n ON n.id_onboarding = o.id_onboarding AND n.estado = 'enviado'
WHERE o.fecha_ingreso <= '2026-11-09'
GROUP BY o.flujo, o.tipo_vinculo
ORDER BY o.flujo, o.tipo_vinculo;

-- Q3 · ¿Cuántos días tarda el trabajador en entregar toda su documentación y cuántos superan 3 días?
WITH completos AS (
  SELECT o.id_onboarding, o.flujo,
         julianday(MAX(d.fecha_recepcion)) - julianday(MIN(d.fecha_solicitud)) AS dias
  FROM onboarding o JOIN documento d ON d.id_onboarding = o.id_onboarding
  GROUP BY o.id_onboarding
  HAVING SUM(d.fecha_recepcion IS NULL) = 0
)
SELECT flujo, COUNT(*) AS incorporaciones, ROUND(AVG(dias), 1) AS dias_promedio,
       SUM(dias > 3) AS sobre_3_dias
FROM completos GROUP BY flujo;

-- Q4 · ¿Qué documentos están pendientes hoy y a quién hay que pedírselos? (lista operativa para RRHH)
SELECT o.nombre, o.fecha_ingreso, d.tipo,
       ROUND(julianday('2026-11-09 18:00:00') - julianday(d.fecha_solicitud), 1) AS dias_esperando
FROM documento d JOIN onboarding o ON o.id_onboarding = d.id_onboarding
WHERE d.fecha_recepcion IS NULL
ORDER BY o.fecha_ingreso, d.tipo;

-- Q5 · ¿Cuántos días pasan desde el registro hasta el contrato firmado? (Buk vs. contrato interno)
SELECT tipo_vinculo, flujo,
       COUNT(*)                     AS contratos_firmados,
       ROUND(AVG(dias_hasta_firma), 1) AS dias_promedio,
       ROUND(MAX(dias_hasta_firma), 1) AS dias_maximo
FROM v_contrato WHERE estado = 'firmado'
GROUP BY tipo_vinculo, flujo
ORDER BY tipo_vinculo, flujo;

-- Q6 · ¿La reunión con el onboarding buddy queda agendada para el mismo día de ingreso?
SELECT o.flujo,
       COUNT(*)                                                               AS incorporaciones,
       SUM(r.id_reunion IS NOT NULL AND date(r.inicio) = o.fecha_ingreso)     AS reunion_dia_1,
       ROUND(100.0 * SUM(r.id_reunion IS NOT NULL AND date(r.inicio) = o.fecha_ingreso) / COUNT(*), 1) AS pct_dia_1
FROM onboarding o LEFT JOIN reunion r ON r.id_onboarding = o.id_onboarding
GROUP BY o.flujo;

-- Q7 · ¿Cómo se reparte la carga entre colaboradores como buddy y como líder?
--      (consulta posible gracias a la tabla colaborador; en la planilla había que contar nombres escritos a mano)
SELECT c.nombre,
       (SELECT COUNT(*) FROM onboarding o WHERE o.id_buddy = c.id_colaborador) AS veces_buddy,
       (SELECT COUNT(*) FROM onboarding o WHERE o.id_lider = c.id_colaborador) AS veces_lider
FROM colaborador c
ORDER BY veces_buddy DESC, veces_lider DESC;

-- Q8 · Incorporaciones que todavía no están completas o que tienen una acción fallida (qué mirar hoy)
SELECT nombre, tipo_vinculo, fecha_ingreso, acciones_enviadas, acciones_fallidas,
       documentos_pendientes, contrato, estado
FROM v_estado_onboarding
WHERE estado <> 'completo' OR acciones_fallidas > 0
ORDER BY fecha_ingreso;
