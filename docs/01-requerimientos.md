# Requerimientos

## Actores y roles

| Actor | Tipo | Participación en el proceso |
|---|---|---|
| Recursos Humanos (RRHH) | Humano | Coordina el proceso, envía formulario, crea accesos generales (correo, Slack), redacta bienvenida. |
| Jefatura directa | Humano | Valida datos del nuevo trabajador, participa en reuniones de bienvenida. |
| Gerencia general | Humano | Confirma sueldo y beneficios en cargos que lo requieren. |
| Ingeniería / TI | Humano | Crea accesos técnicos (Linear, repositorio, sitio web). |
| Nuevo trabajador | Humano | Llena el formulario y entrega documentación. |
| Agencia externa | Sistema externo | Formaliza el contrato a partir de los datos enviados por RRHH. |
| Buk | Sistema externo | Plataforma de firma digital del contrato. |
| Slack / Gmail | Sistema externo | Canales de comunicación interna usados durante la incorporación. |

## Alcance

### Dentro del alcance
- Captura y validación de datos del nuevo trabajador.
- Trazabilidad del proceso de incorporación (estado por etapa).
- Registro de generación de accesos (generales y técnicos).
- Apoyo a la coordinación de la bienvenida.

### Fuera del alcance
- Proceso para generar el contrato, ejecutado por la agencia externa.
- Evaluación psicolaboral (no mencionada como parte del flujo actual).

## Requisitos funcionales

| ID | Requisito | Prioridad | Trazabilidad |
|---|---|---|---|
| RF-01 | El sistema debe permitir a RRHH enviar un formulario estructurado de incorporación al nuevo trabajador. | Must | Formulario disperso / sin control (entrevista) |
| RF-02 | El sistema debe centralizar los datos del formulario en un repositorio único y trazable, reemplazando el uso informal de Google Sheets. | Must | Pérdida de información si cambia el formulario (entrevista) |
| RF-03 | El sistema debe permitir el flujo de validación de datos entre RRHH y jefatura directa (y gerencia general cuando corresponda). | Must | Validación manual y dispersa (entrevista) |
| RF-04 | El sistema debe registrar el estado de completitud de documentos y alertar sobre datos o documentos faltantes. | Should | Camino de excepción no estandarizado (entrevista) |
| RF-05 | El sistema debe diferenciar el flujo de incorporación entre trabajadores contratados y practicantes. | Should | Proceso más desordenado para practicantes (entrevista) |
| RF-06 | El sistema debe registrar el envío de datos a la agencia externa y a Buk para la firma del contrato. | Must | Contrato vía agencia externa + Buk (entrevista) |
| RF-07 | El sistema debe apoyar la coordinación de la bienvenida (reuniones, desayuno, aviso a la oficina). | Could | Bienvenida coordinada manualmente por RRHH (entrevista) |
| RF-08 | El sistema debe permitir el seguimiento del tiempo transcurrido en cada etapa del proceso. | Should | Tiempos de espera de hasta 1,5 semanas (entrevista) |

## Requisitos no funcionales

| ID | Requisito | Prioridad | Trazabilidad |
|---|---|---|---|
| RNF-01 | Los datos personales del trabajador (RUT, contacto de emergencia, sueldo) deben almacenarse con control de acceso restringido. | Must | Ley 21.719 / datos hoy en Sheets sin control (entrevista) |
| RNF-02 | El formulario de ingreso debe ser usable para minimizar errores de llenado y reenvíos. | Should | Formularios mal llenados generan reprocesos (entrevista) |
| RNF-03 | El sistema debe estar disponible para consulta simultánea de RRHH y jefaturas. | Should | Múltiples actores consultan el mismo proceso (entrevista) |
| RNF-04 | El sistema debe permitir trazabilidad/auditoría de cambios sobre los datos del trabajador. | Must | Sin trazabilidad oficial hoy (entrevista) |
| RNF-05 | Las 7 notificaciones automáticas deben dispararse en paralelo, en segundos, tras completar el formulario. | Should | Eliminar la espera manual |
