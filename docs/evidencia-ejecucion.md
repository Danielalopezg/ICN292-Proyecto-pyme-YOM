# Evidencia de ejecución

Salida real de la base en un entorno limpio. Reproducible con los pasos del
[`README.md`](../README.md); los números del informe salen de aquí y no están escritos a mano.

- **Motor:** SQLite 3 (ejecutado con la biblioteca SQLite 3.53.1)
- **Fecha de la corrida:** 18-11-2026
- **Orden:** `schema.sql` → `seed.sql` → `queries.sql` → `pruebas_restricciones.sql`

## 1. Carga del esquema y de los datos

```
[OK] schema.sql ejecutado sin errores
[OK] seed.sql ejecutado sin errores
```

### Filas cargadas

| Tabla | Filas |
|---|---|
| accion | 8 |
| colaborador | 9 |
| contacto_emergencia | 19 |
| contrato | 18 |
| documento | 90 |
| notificacion | 109 |
| onboarding | 20 |
| reunion | 15 |

Vistas creadas: `v_contrato`, `v_estado_onboarding`, `v_notificacion`.

## 2. Consultas de negocio (`queries.sql`)

```

--- Q1 · ¿Cuánto tarda en salir cada aviso desde que RRHH registra el ingreso?
  flujo   avisos  minutos_promedio  minutos_maximo
  ------  ------  ----------------  --------------
  manual  25      2197.4            4217.5        
  n8n     69      1.1               1.7           
  (2 filas)

--- Q2 · ¿Qué porcentaje de las 8 acciones de bienvenida recibe cada incorporación?
  flujo   tipo_vinculo  incorporaciones  cobertura_pct
  ------  ------------  ---------------  -------------
  manual  contratado    5                52.5         
  manual  practicante   5                27.5         
  n8n     contratado    4                96.9         
  n8n     practicante   3                100.0        
  (4 filas)

--- Q3 · ¿Cuántos días tarda el trabajador en entregar toda su documentación y cuántos superan 3 días?
  flujo   incorporaciones  dias_promedio  sobre_3_dias
  ------  ---------------  -------------  ------------
  manual  10               4.9            8           
  n8n     8                2.9            2           
  (2 filas)

--- Q4 · ¿Qué documentos están pendientes hoy y a quién hay que pedírselos? (lista operativa para RRHH)
  nombre           fecha_ingreso  tipo              dias_esperando
  ---------------  -------------  ----------------  --------------
  Rocío Cáceres    2026-11-18     cedula            5.2           
  Rocío Cáceres    2026-11-18     foto_personal     5.2           
  Rocío Cáceres    2026-11-18     salud_afiliacion  5.2           
  Nicolás Paredes  2026-11-19     antecedentes      12.1          
  (4 filas)

--- Q5 · ¿Cuántos días pasan desde el registro hasta el contrato firmado? (Buk vs. contrato interno)
  tipo_vinculo  flujo   contratos_firmados  dias_promedio  dias_maximo
  ------------  ------  ------------------  -------------  -----------
  contratado    manual  5                   13.6           15.0       
  contratado    n8n     4                   8.6            10.5       
  practicante   manual  5                   8.8            12.2       
  practicante   n8n     4                   5.0            6.2        
  (4 filas)

--- Q6 · ¿La reunión con el onboarding buddy queda agendada para el mismo día de ingreso?
  flujo   incorporaciones  reunion_dia_1  pct_dia_1
  ------  ---------------  -------------  ---------
  manual  10               5              50.0     
  n8n     10               10             100.0    
  (2 filas)

--- Q7 · ¿Cómo se reparte la carga entre colaboradores como buddy y como líder?
  nombre           veces_buddy  veces_lider
  ---------------  -----------  -----------
  Valentina Rojas  4            3          
  Ignacio Torres   4            0          
  Fernanda Castro  4            0          
  Diego Herrera    4            0          
  Camila Soto      4            0          
  Matías Fuentes   0            6          
  Carolina Vega    0            4          
  Rodrigo Pizarro  0            4          
  Andrés Muñoz     0            3          
  (9 filas)

--- Q8 · Incorporaciones que todavía no están completas o que tienen una acción fallida (qué mirar hoy)
  nombre           tipo_vinculo  fecha_ingreso  acciones_enviadas  acciones_fallidas  documentos_pendientes  contrato      estado           
  ---------------  ------------  -------------  -----------------  -----------------  ---------------------  ------------  -----------------
  Trinidad Lagos   contratado    2026-10-27     7                  1                  0                      firmado       completo         
  Rocío Cáceres    practicante   2026-11-18     7                  0                  3                      sin_contrato  datos_solicitados
  Nicolás Paredes  contratado    2026-11-19     7                  0                  1                      sin_contrato  datos_solicitados
  (3 filas)
```

La interpretación de cada consulta está en [`04-sql-consultas.md`](04-sql-consultas.md).

## 3. Pruebas de restricciones (`pruebas_restricciones.sql`)

Cada una de las ocho instrucciones de este archivo contiene un dato inválido y **debe** fallar.
Las ocho fallaron:

```
  [P1] RECHAZADO -> CHECK constraint failed: id_lider <> id_buddy
  [P2] RECHAZADO -> FOREIGN KEY constraint failed
  [P3] RECHAZADO -> CHECK constraint failed: tipo_vinculo IN ('contratado','practicante')
  [P4] RECHAZADO -> UNIQUE constraint failed: documento.id_onboarding, documento.tipo
  [P5] RECHAZADO -> CHECK constraint failed: (estado = 'firmado') = (fecha_firma IS NOT NULL)
  [P6] RECHAZADO -> FOREIGN KEY constraint failed
  [P7] RECHAZADO -> UNIQUE constraint failed: notificacion.id_onboarding, notificacion.codigo_accion
  [P8] RECHAZADO -> UNIQUE constraint failed: onboarding.correo_corporativo
```

Las ocho restricciones del modelo funcionan: dos CHECK de dominio, un CHECK de regla de negocio
(`id_lider <> id_buddy`), un CHECK de consistencia (`estado = 'firmado'` ⇔ `fecha_firma` no nula),
dos claves foráneas y tres restricciones UNIQUE.
