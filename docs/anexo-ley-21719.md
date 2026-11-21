# Anexo · Datos personales y Ley 21.719

La Ley 21.719 moderniza la protección de datos personales en Chile (principios de licitud, finalidad,
proporcionalidad, calidad, seguridad, responsabilidad y transparencia; derechos de acceso, rectificación,
supresión, oposición y portabilidad). *(Verificar con el material del curso la fecha de entrada en vigencia y
los artículos vistos en clases.)* El onboarding trata muchos datos personales, así que se revisó el flujo real:

| Riesgo detectado en el flujo real | Medida en el modelo / recomendación a YOM |
|---|---|
| La contraseña provisoria viaja por correo y queda en texto plano en `Onboarding_Master` | No se almacena en la base; recomendación: no guardarla y forzar su cambio en el primer inicio de sesión |
| La planilla mezcla datos del trabajador con archivos de salud y antecedentes (`saludAfiliacionFileIds`, `antecedentesFileIds`) | `documento` guarda solo la referencia al archivo en Drive, nunca su contenido; recomendación: carpeta con permisos restringidos |
| Datos de un tercero (contacto de emergencia) | Tabla separada `contacto_emergencia`, que no se muestra en el visor |
| No hay registro de consentimiento | `consentimiento_datos` y `fecha_consentimiento` propuestos para el formulario del trabajador |
| Gmail, Slack, Google Calendar y n8n Cloud procesan datos fuera de Chile | Riesgo residual: transferencia internacional; recomendación: acuerdos de encargo o n8n autoalojado |
| Repositorio público | Solo datos sintéticos, dominio ficticio y flujo publicado sin identificadores internos |
