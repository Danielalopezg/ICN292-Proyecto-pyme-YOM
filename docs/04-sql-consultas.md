# 04 · SQL: diseño y consultas de negocio

**Motor:** SQLite 3. **Archivos:** [`schema.sql`](../db/schema.sql) (8 tablas, 3 vistas, PK/FK/CHECK/UNIQUE),
[`seed.sql`](../db/seed.sql) (20 incorporaciones sintéticas), [`queries.sql`](../db/queries.sql) (8 consultas).
Reproducir: `sqlite3 -header -column db/yom.db < db/queries.sql`. Corte de los datos: 09-11-2026.

## Resultados

| Consulta | Pregunta | Manual (AS-IS) | n8n (TO-BE) |
|---|---|---|---|
| Q1 | Minutos desde el registro hasta cada aviso (promedio / máximo) | 2.197 / 4.218 (~1,5 / ~2,9 días) | 1,1 / 1,7 |
| Q2 | Cobertura de las 8 acciones — contratados | 52,5 % | 96,9 % |
| Q2 | Cobertura de las 8 acciones — practicantes | 27,5 % | 100 % |
| Q3 | Días hasta documentación completa / casos sobre 3 días | 4,9 / 8 de 10 | 2,9 / 2 de 8 |
| Q4 | Documentos pendientes hoy | — | 4 (2 personas) |
| Q5 | Días hasta contrato firmado — contratados | 13,6 | 8,6 |
| Q5 | Días hasta contrato firmado — practicantes | 8,8 | 5,0 |
| Q6 | Reunión con el buddy el mismo día de ingreso | 50 % | 100 % |
| Q7 | Persona con más carga | Valentina Rojas: 4 veces buddy + 3 veces líder | |
| Q8 | Ingresos que requieren atención hoy | 3 (1 aviso fallido, 2 con documentos pendientes) | |

## Interpretación

**Q1 y Q6 — oportunidad.** En el flujo manual cada aviso salía en promedio un día y medio después de que RRHH
registraba el ingreso, y solo la mitad de las reuniones de bienvenida quedaba el primer día. Con n8n el retraso
lo fija el polling de 1 minuto del trigger, y la reunión siempre se agenda el día de ingreso a las 10:00, porque
el nodo `Code in JavaScript1` la calcula desde la fecha de entrada.

**Q2 — el hallazgo más relevante para YOM.** Los practicantes recibían apenas el 27,5 % de las acciones de
bienvenida, lo que confirma con datos el desorden que describió la entrevistada; con n8n la brecha desaparece,
porque el flujo no distingue el tipo de vínculo al avisar. El 96,9 % de los contratados no llega a 100 % por un
anuncio de Slack que falló, y precisamente para eso existe el estado `fallido` (Q8).

**Q3, Q4 y Q5 — lo que la automatización no controla.** La documentación llega antes porque el enlace al
formulario sale en el correo de bienvenida al minuto, pero sigue dependiendo de que el trabajador responda: Q4
muestra que hoy hay un documento esperando hace 12 días. El contrato de los contratados baja de 13,6 a 8,6 días
solo porque se puede solicitar antes (el modelo supone que se pide al completar la documentación); el plazo de
firma con Buk no cambia, por lo tanto es el siguiente cuello de botella.

**Q7 — riesgo de carga.** Una misma persona concentra 7 roles en el año (buddy y líder), algo que en la planilla
no se veía porque los nombres estaban escritos a mano en cada fila; con la tabla `colaborador` YOM puede repartir
mejor la función de buddy.

> Las magnitudes provienen de datos sintéticos calibrados: muestran el efecto esperado, no una medición del
> piloto real en la empresa.
