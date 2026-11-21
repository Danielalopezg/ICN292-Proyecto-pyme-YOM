# 00 · Caso PYME

| Campo | Detalle |
|---|---|
| Empresa | You Order Me SpA (YOM) |
| Rubro | Desarrollo de software y tecnología para el comercio |
| Tamaño | ~35 personas |
| Ubicación | Presidente Errázuriz 2999, of. 502, Las Condes, Santiago |
| Evidencia | Entrevista a Sofía, Chief of Staff, realizada por el equipo el 27-08-2026 (Anexo A del informe) |
| Continuidad | Mismo caso y mismo proceso que la Entrega 1 |

**Proceso crítico:** incorporación (onboarding) de nuevos trabajadores, contratados y practicantes.

**Problema (AS-IS, según la entrevista):** la incorporación depende de avisos manuales que RRHH coordina entre
jefatura, TI y equipo; los datos quedan en una planilla de Google Sheets que no es un repositorio oficial; los
documentos faltantes se piden por WhatsApp o correo sin plazo; el contrato se firma recién a la semana y media
como mínimo; y con practicantes el proceso es más informal (reuniones que no se agendan, bienvenida otro día).

**Solución (TO-BE):** un flujo n8n que, apenas RRHH registra un ingreso, ejecuta en paralelo las acciones de
bienvenida (líder, trabajador, Chief of Staff, equipo y onboarding buddy), y una base de datos normalizada que
deja trazado cada paso. El flujo fue probado con la empresa.
