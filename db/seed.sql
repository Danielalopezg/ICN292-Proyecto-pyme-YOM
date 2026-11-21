-- seed.sql — datos SINTÉTICOS generados por scripts/generar_seed.py (semilla 292).
-- Ninguna persona es real. Calibrados con la entrevista a YOM (27-08-2026) y con el flujo n8n real.
-- Fecha de corte de los datos: 2026-11-09.
PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

-- Catálogo de acciones = nodos de acción del flujo n8n
INSERT INTO accion VALUES ('recordatorio_lider', 'Envío recordatorio a líder', 'correo', 'lider', 0);
INSERT INTO accion VALUES ('bienvenida_correo', 'Bienvenida a Yom', 'correo', 'trabajador', 0);
INSERT INTO accion VALUES ('aviso_accesos', 'Aviso a Sofi: creación de accesos', 'slack', 'chief_of_staff', 0);
INSERT INTO accion VALUES ('datos_primer_dia', 'Datos importantes a nuevo Yomer', 'correo', 'trabajador', 0);
INSERT INTO accion VALUES ('anuncio_equipo', 'Aviso de bienvenida al team de Yom', 'slack', 'equipo', 0);
INSERT INTO accion VALUES ('reunion_buddy', 'Reunión entre Nuevo Yomer y Onboarding Buddy', 'calendario', 'trabajador_y_buddy', 0);
INSERT INTO accion VALUES ('bienvenida_dia1', 'Mensaje de bienvenida automatizado', 'slack', 'equipo', 1);
INSERT INTO accion VALUES ('indicaciones_buddy', 'Indicaciones Onboarding Buddy', 'correo', 'buddy', 0);

INSERT INTO colaborador VALUES (1, 'Matías Fuentes', 'matias.fuentes@yom-demo.cl', NULL);
INSERT INTO colaborador VALUES (2, 'Carolina Vega', 'carolina.vega@yom-demo.cl', NULL);
INSERT INTO colaborador VALUES (3, 'Rodrigo Pizarro', 'rodrigo.pizarro@yom-demo.cl', NULL);
INSERT INTO colaborador VALUES (4, 'Valentina Rojas', 'valentina.rojas@yom-demo.cl', NULL);
INSERT INTO colaborador VALUES (5, 'Andrés Muñoz', 'andres.munoz@yom-demo.cl', NULL);
INSERT INTO colaborador VALUES (6, 'Ignacio Torres', 'ignacio.torres@yom-demo.cl', '+56 9 6123 4501');
INSERT INTO colaborador VALUES (7, 'Fernanda Castro', 'fernanda.castro@yom-demo.cl', '+56 9 6123 4502');
INSERT INTO colaborador VALUES (8, 'Diego Herrera', 'diego.herrera@yom-demo.cl', '+56 9 6123 4503');
INSERT INTO colaborador VALUES (9, 'Camila Soto', 'camila.soto@yom-demo.cl', '+56 9 6123 4504');

-- Onboarding 1: Benjamín Araya (contratado, flujo manual)
INSERT INTO onboarding VALUES (1, 'benjaminaraya@gmail.com-20260202', 'Benjamín Araya', 'benjaminaraya@gmail.com', 'benjamin.araya@yom-demo.cl', '20137129-5', 'Desarrollador Backend', 'contratado', 1, 7, 'https://drive.google.com/carta-oferta-001', '2026-02-16', '2026-02-02 11:48:18', 'manual', 0, NULL);
INSERT INTO contacto_emergencia VALUES (1, 'Contacto de Benjamín', '+56 9 5198 2291', 'pareja');
INSERT INTO documento VALUES (1, 1, 'afp_afiliacion', 'drv_ca3cbdc044', '2026-02-02 22:03:00', '2026-02-06 00:28:55');
INSERT INTO documento VALUES (2, 1, 'afp_cotizaciones', 'drv_85288e9a9c', '2026-02-02 22:03:00', '2026-02-10 02:52:42');
INSERT INTO documento VALUES (3, 1, 'salud_afiliacion', 'drv_47f42843cb', '2026-02-02 22:03:00', '2026-02-06 02:28:54');
INSERT INTO documento VALUES (4, 1, 'cedula', 'drv_d5bf31c9df', '2026-02-02 22:03:00', '2026-02-06 05:27:25');
INSERT INTO documento VALUES (5, 1, 'antecedentes', 'drv_d38d7668d0', '2026-02-02 22:03:00', '2026-02-06 07:20:54');
INSERT INTO documento VALUES (6, 1, 'foto_personal', 'drv_61406673cb', '2026-02-02 22:03:00', '2026-02-06 00:37:36');
INSERT INTO contrato VALUES (1, 1, '2026-02-10 20:15:08', '2026-02-17 08:27:45', 'firmado');
INSERT INTO notificacion VALUES (1, 1, 'recordatorio_lider', '2026-02-03 21:05:45', 'enviado');
INSERT INTO notificacion VALUES (2, 1, 'bienvenida_correo', '2026-02-03 23:02:05', 'enviado');
INSERT INTO notificacion VALUES (3, 1, 'aviso_accesos', '2026-02-04 08:43:14', 'enviado');
INSERT INTO notificacion VALUES (4, 1, 'datos_primer_dia', '2026-02-03 01:04:40', 'enviado');
INSERT INTO notificacion VALUES (5, 1, 'anuncio_equipo', '2026-02-04 09:10:51', 'enviado');
INSERT INTO notificacion VALUES (6, 1, 'reunion_buddy', '2026-02-04 07:12:49', 'enviado');
INSERT INTO reunion VALUES (1, 1, NULL, '2026-02-16 10:00:00', '2026-02-16 11:00:00', '2026-02-04 07:12:49');
INSERT INTO notificacion VALUES (7, 1, 'bienvenida_dia1', '2026-02-17 07:03:19', 'enviado');

-- Onboarding 2: Isidora Contreras (practicante, flujo manual)
INSERT INTO onboarding VALUES (2, 'isidoracontreras@gmail.com-20260216', 'Isidora Contreras', 'isidoracontreras@gmail.com', 'isidora.contreras@yom-demo.cl', '20174258-7', 'Practicante Comercial', 'practicante', 3, 6, 'https://drive.google.com/carta-oferta-002', '2026-03-09', '2026-02-16 16:32:01', 'manual', 0, NULL);
INSERT INTO contacto_emergencia VALUES (2, 'Contacto de Isidora', '+56 9 9917 4766', 'hermano/a');
INSERT INTO documento VALUES (7, 2, 'cedula', 'drv_4b676d2196', '2026-02-17 14:32:33', '2026-02-19 14:14:54');
INSERT INTO documento VALUES (8, 2, 'salud_afiliacion', 'drv_8059d6be27', '2026-02-17 14:32:33', '2026-02-19 16:38:32');
INSERT INTO documento VALUES (9, 2, 'foto_personal', 'drv_5e7f091a60', '2026-02-17 14:32:33', '2026-02-19 17:30:18');
INSERT INTO contrato VALUES (2, 2, '2026-02-20 07:21:49', '2026-02-25 01:49:39', 'firmado');
INSERT INTO notificacion VALUES (8, 2, 'recordatorio_lider', '2026-02-16 22:01:50', 'enviado');
INSERT INTO notificacion VALUES (9, 2, 'bienvenida_correo', '2026-02-17 10:35:26', 'enviado');

-- Onboarding 3: Joaquín Sepúlveda (contratado, flujo manual)
INSERT INTO onboarding VALUES (3, 'joaquinsepulveda@gmail.com-20260302', 'Joaquín Sepúlveda', 'joaquinsepulveda@gmail.com', 'joaquin.sepulveda@yom-demo.cl', '20211387-7', 'Analista de Datos', 'contratado', 2, 4, 'https://drive.google.com/carta-oferta-003', '2026-03-19', '2026-03-02 15:29:04', 'manual', 0, NULL);
INSERT INTO contacto_emergencia VALUES (3, 'Contacto de Joaquín', '+56 9 9688 8960', 'madre');
INSERT INTO documento VALUES (10, 3, 'afp_afiliacion', 'drv_249ab66510', '2026-03-03 05:13:19', '2026-03-07 19:34:46');
INSERT INTO documento VALUES (11, 3, 'afp_cotizaciones', 'drv_fc1dfc1ab5', '2026-03-03 05:13:19', '2026-03-03 22:10:46');
INSERT INTO documento VALUES (12, 3, 'salud_afiliacion', 'drv_c95109da74', '2026-03-03 05:13:19', '2026-03-03 18:02:10');
INSERT INTO documento VALUES (13, 3, 'cedula', 'drv_395a972508', '2026-03-03 05:13:19', '2026-03-03 19:25:33');
INSERT INTO documento VALUES (14, 3, 'antecedentes', 'drv_4634f8ef91', '2026-03-03 05:13:19', '2026-03-03 16:33:13');
INSERT INTO documento VALUES (15, 3, 'foto_personal', 'drv_1b6142b49', '2026-03-03 05:13:19', '2026-03-03 18:52:28');
INSERT INTO contrato VALUES (3, 3, '2026-03-08 10:39:11', '2026-03-15 09:44:41', 'firmado');
INSERT INTO notificacion VALUES (10, 3, 'bienvenida_correo', '2026-03-04 18:17:53', 'enviado');
INSERT INTO notificacion VALUES (11, 3, 'datos_primer_dia', '2026-03-03 18:18:06', 'enviado');
INSERT INTO notificacion VALUES (12, 3, 'anuncio_equipo', '2026-03-04 22:48:12', 'enviado');
INSERT INTO notificacion VALUES (13, 3, 'reunion_buddy', '2026-03-03 21:11:41', 'enviado');
INSERT INTO reunion VALUES (2, 3, NULL, '2026-03-19 10:00:00', '2026-03-19 11:00:00', '2026-03-03 21:11:41');
INSERT INTO notificacion VALUES (14, 3, 'bienvenida_dia1', '2026-03-19 22:17:28', 'enviado');

-- Onboarding 4: Antonia Espinoza (practicante, flujo manual)
INSERT INTO onboarding VALUES (4, 'antoniaespinoza@gmail.com-20260323', 'Antonia Espinoza', 'antoniaespinoza@gmail.com', 'antonia.espinoza@yom-demo.cl', '20248516-2', 'Practicante de Desarrollo', 'practicante', 1, 9, 'https://drive.google.com/carta-oferta-004', '2026-04-06', '2026-03-23 14:12:02', 'manual', 0, NULL);
INSERT INTO contacto_emergencia VALUES (4, 'Contacto de Antonia', '+56 9 5181 5629', 'pareja');
INSERT INTO documento VALUES (16, 4, 'cedula', 'drv_e173f670dd', '2026-03-23 22:21:51', '2026-03-27 10:20:22');
INSERT INTO documento VALUES (17, 4, 'salud_afiliacion', 'drv_18a78e82', '2026-03-23 22:21:51', '2026-03-27 01:25:53');
INSERT INTO documento VALUES (18, 4, 'foto_personal', 'drv_7595d3ef88', '2026-03-23 22:21:51', '2026-03-27 08:59:24');
INSERT INTO contrato VALUES (4, 4, '2026-03-28 01:17:48', '2026-03-30 00:02:06', 'firmado');
INSERT INTO notificacion VALUES (15, 4, 'reunion_buddy', '2026-03-25 17:47:38', 'enviado');
INSERT INTO reunion VALUES (3, 4, NULL, '2026-04-06 10:00:00', '2026-04-06 11:00:00', '2026-03-25 17:47:38');
INSERT INTO notificacion VALUES (16, 4, 'bienvenida_dia1', '2026-04-06 20:54:17', 'enviado');

-- Onboarding 5: Vicente Navarro (contratado, flujo manual)
INSERT INTO onboarding VALUES (5, 'vicentenavarro@gmail.com-20260406', 'Vicente Navarro', 'vicentenavarro@gmail.com', 'vicente.navarro@yom-demo.cl', '20285645-4', 'Ejecutiva de Customer Success', 'contratado', 4, 8, 'https://drive.google.com/carta-oferta-005', '2026-04-17', '2026-04-06 13:53:23', 'manual', 0, NULL);
INSERT INTO contacto_emergencia VALUES (5, 'Contacto de Vicente', '+56 9 7315 6024', 'padre');
INSERT INTO documento VALUES (19, 5, 'afp_afiliacion', 'drv_bfaf48ac21', '2026-04-07 08:39:08', '2026-04-14 02:22:04');
INSERT INTO documento VALUES (20, 5, 'afp_cotizaciones', 'drv_28e508d48a', '2026-04-07 08:39:08', '2026-04-11 05:53:15');
INSERT INTO documento VALUES (21, 5, 'salud_afiliacion', 'drv_b1a36777be', '2026-04-07 08:39:08', '2026-04-11 08:29:08');
INSERT INTO documento VALUES (22, 5, 'cedula', 'drv_7be84158cc', '2026-04-07 08:39:08', '2026-04-13 15:49:31');
INSERT INTO documento VALUES (23, 5, 'antecedentes', 'drv_d3f3bde096', '2026-04-07 08:39:08', '2026-04-11 06:49:12');
INSERT INTO documento VALUES (24, 5, 'foto_personal', 'drv_c3b02de049', '2026-04-07 08:39:08', '2026-04-11 01:21:50');
INSERT INTO contrato VALUES (5, 5, '2026-04-14 15:47:34', '2026-04-18 23:42:41', 'firmado');
INSERT INTO notificacion VALUES (17, 5, 'bienvenida_correo', '2026-04-09 09:07:50', 'enviado');
INSERT INTO notificacion VALUES (18, 5, 'aviso_accesos', '2026-04-09 12:10:52', 'enviado');
INSERT INTO notificacion VALUES (19, 5, 'bienvenida_dia1', '2026-04-18 09:06:23', 'enviado');

-- Onboarding 6: Martina Valenzuela (practicante, flujo manual)
INSERT INTO onboarding VALUES (6, 'martinavalenzuela@gmail.com-20260427', 'Martina Valenzuela', 'martinavalenzuela@gmail.com', 'martina.valenzuela@yom-demo.cl', '20322774-4', 'Practicante de Operaciones', 'practicante', 5, 9, 'https://drive.google.com/carta-oferta-006', '2026-05-08', '2026-04-27 09:33:52', 'manual', 0, NULL);
INSERT INTO contacto_emergencia VALUES (6, 'Contacto de Martina', '+56 9 8167 9591', 'padre');
INSERT INTO documento VALUES (25, 6, 'cedula', 'drv_82625f05a7', '2026-04-27 15:06:11', '2026-04-29 20:32:53');
INSERT INTO documento VALUES (26, 6, 'salud_afiliacion', 'drv_beae30283d', '2026-04-27 15:06:11', '2026-05-02 21:41:28');
INSERT INTO documento VALUES (27, 6, 'foto_personal', 'drv_23f88b9017', '2026-04-27 15:06:11', '2026-04-29 19:00:44');
INSERT INTO contrato VALUES (6, 6, '2026-05-03 13:08:04', '2026-05-05 00:52:01', 'firmado');
INSERT INTO notificacion VALUES (20, 6, 'recordatorio_lider', '2026-04-28 21:42:56', 'enviado');
INSERT INTO notificacion VALUES (21, 6, 'bienvenida_dia1', '2026-05-08 18:54:25', 'enviado');

-- Onboarding 7: Agustín Carrasco (contratado, flujo manual)
INSERT INTO onboarding VALUES (7, 'agustincarrasco@gmail.com-20260511', 'Agustín Carrasco', 'agustincarrasco@gmail.com', 'agustin.carrasco@yom-demo.cl', '20359903-K', 'Desarrolladora Frontend', 'contratado', 1, 4, 'https://drive.google.com/carta-oferta-007', '2026-05-25', '2026-05-11 14:17:34', 'manual', 0, NULL);
INSERT INTO contacto_emergencia VALUES (7, 'Contacto de Agustín', '+56 9 6488 5982', 'padre');
INSERT INTO documento VALUES (28, 7, 'afp_afiliacion', 'drv_2e5fad14bb', '2026-05-12 19:56:31', '2026-05-16 23:05:50');
INSERT INTO documento VALUES (29, 7, 'afp_cotizaciones', 'drv_5d5b25654b', '2026-05-12 19:56:31', '2026-05-16 22:45:47');
INSERT INTO documento VALUES (30, 7, 'salud_afiliacion', 'drv_fd33559824', '2026-05-12 19:56:31', '2026-05-19 05:07:39');
INSERT INTO documento VALUES (31, 7, 'cedula', 'drv_58fa2942f', '2026-05-12 19:56:31', '2026-05-17 01:11:17');
INSERT INTO documento VALUES (32, 7, 'antecedentes', 'drv_427192812d', '2026-05-12 19:56:31', '2026-05-16 21:52:48');
INSERT INTO documento VALUES (33, 7, 'foto_personal', 'drv_c2c66d816e', '2026-05-12 19:56:31', '2026-05-16 21:08:30');
INSERT INTO contrato VALUES (7, 7, '2026-05-19 21:48:33', '2026-05-24 11:55:41', 'firmado');
INSERT INTO notificacion VALUES (22, 7, 'recordatorio_lider', '2026-05-11 19:09:03', 'enviado');
INSERT INTO notificacion VALUES (23, 7, 'reunion_buddy', '2026-05-13 02:56:12', 'enviado');
INSERT INTO reunion VALUES (4, 7, NULL, '2026-05-25 10:00:00', '2026-05-25 11:00:00', '2026-05-13 02:56:12');
INSERT INTO notificacion VALUES (24, 7, 'bienvenida_dia1', '2026-05-25 17:49:33', 'enviado');

-- Onboarding 8: Florencia Gutiérrez (practicante, flujo manual)
INSERT INTO onboarding VALUES (8, 'florenciagutierrez@gmail.com-20260601', 'Florencia Gutiérrez', 'florenciagutierrez@gmail.com', 'florencia.gutierrez@yom-demo.cl', '20397032-3', 'Practicante de Datos', 'practicante', 2, 7, 'https://drive.google.com/carta-oferta-008', '2026-06-25', '2026-06-01 16:49:33', 'manual', 0, NULL);
INSERT INTO contacto_emergencia VALUES (8, 'Contacto de Florencia', '+56 9 9177 2821', 'pareja');
INSERT INTO documento VALUES (34, 8, 'cedula', 'drv_499ec595c6', '2026-06-02 09:06:24', '2026-06-03 12:16:08');
INSERT INTO documento VALUES (35, 8, 'salud_afiliacion', 'drv_6984f60efe', '2026-06-02 09:06:24', '2026-06-03 18:15:31');
INSERT INTO documento VALUES (36, 8, 'foto_personal', 'drv_ea4e68da57', '2026-06-02 09:06:24', '2026-06-03 16:17:27');
INSERT INTO contrato VALUES (8, 8, '2026-06-04 00:52:25', '2026-06-11 03:10:54', 'firmado');
INSERT INTO notificacion VALUES (25, 8, 'datos_primer_dia', '2026-06-03 07:36:59', 'enviado');

-- Onboarding 9: Maximiliano Bravo (contratado, flujo manual)
INSERT INTO onboarding VALUES (9, 'maximilianobravo@gmail.com-20260622', 'Maximiliano Bravo', 'maximilianobravo@gmail.com', 'maximiliano.bravo@yom-demo.cl', '20434161-3', 'Ejecutivo Comercial', 'contratado', 3, 8, 'https://drive.google.com/carta-oferta-009', '2026-07-10', '2026-06-22 11:46:05', 'manual', 0, NULL);
INSERT INTO contacto_emergencia VALUES (9, 'Contacto de Maximiliano', '+56 9 8930 6667', 'padre');
INSERT INTO documento VALUES (37, 9, 'afp_afiliacion', 'drv_d0a6510542', '2026-06-23 12:59:15', '2026-06-27 05:31:02');
INSERT INTO documento VALUES (38, 9, 'afp_cotizaciones', 'drv_766536be57', '2026-06-23 12:59:15', '2026-06-27 06:24:59');
INSERT INTO documento VALUES (39, 9, 'salud_afiliacion', 'drv_a713c796ce', '2026-06-23 12:59:15', '2026-07-01 01:22:30');
INSERT INTO documento VALUES (40, 9, 'cedula', 'drv_2a2c68eb20', '2026-06-23 12:59:15', '2026-06-29 06:30:06');
INSERT INTO documento VALUES (41, 9, 'antecedentes', 'drv_f06a610a1b', '2026-06-23 12:59:15', '2026-06-27 09:40:32');
INSERT INTO documento VALUES (42, 9, 'foto_personal', 'drv_e759a85acd', '2026-06-23 12:59:15', '2026-06-29 17:47:55');
INSERT INTO contrato VALUES (9, 9, '2026-07-01 11:04:53', '2026-07-07 11:42:22', 'firmado');
INSERT INTO notificacion VALUES (26, 9, 'bienvenida_correo', '2026-06-24 11:12:28', 'enviado');
INSERT INTO notificacion VALUES (27, 9, 'datos_primer_dia', '2026-06-24 22:58:54', 'enviado');
INSERT INTO notificacion VALUES (28, 9, 'reunion_buddy', '2026-06-22 16:07:40', 'enviado');
INSERT INTO reunion VALUES (5, 9, NULL, '2026-07-10 10:00:00', '2026-07-10 11:00:00', '2026-06-22 16:07:40');

-- Onboarding 10: Catalina Figueroa (practicante, flujo manual)
INSERT INTO onboarding VALUES (10, 'catalinafigueroa@gmail.com-20260706', 'Catalina Figueroa', 'catalinafigueroa@gmail.com', 'catalina.figueroa@yom-demo.cl', '20471290-5', 'Practicante de Customer Success', 'practicante', 4, 6, 'https://drive.google.com/carta-oferta-010', '2026-07-24', '2026-07-06 12:36:32', 'manual', 0, NULL);
INSERT INTO contacto_emergencia VALUES (10, 'Contacto de Catalina', '+56 9 7997 6463', 'pareja');
INSERT INTO documento VALUES (43, 10, 'cedula', 'drv_9c73763054', '2026-07-06 16:43:03', '2026-07-10 11:22:30');
INSERT INTO documento VALUES (44, 10, 'salud_afiliacion', 'drv_4f7b40e223', '2026-07-06 16:43:03', '2026-07-10 18:40:59');
INSERT INTO documento VALUES (45, 10, 'foto_personal', 'drv_481a585919', '2026-07-06 16:43:03', '2026-07-10 12:17:38');
INSERT INTO contrato VALUES (10, 10, '2026-07-11 00:00:09', '2026-07-18 17:42:12', 'firmado');
INSERT INTO notificacion VALUES (29, 10, 'bienvenida_correo', '2026-07-08 10:52:23', 'enviado');
INSERT INTO notificacion VALUES (30, 10, 'aviso_accesos', '2026-07-08 11:25:43', 'enviado');
INSERT INTO notificacion VALUES (31, 10, 'datos_primer_dia', '2026-07-06 16:48:07', 'enviado');
INSERT INTO notificacion VALUES (32, 10, 'bienvenida_dia1', '2026-07-25 10:27:40', 'enviado');

-- Onboarding 11: Lucas Riquelme (contratado, flujo n8n)
INSERT INTO onboarding VALUES (11, 'lucasriquelme@gmail.com-20260810', 'Lucas Riquelme', 'lucasriquelme@gmail.com', 'lucas.riquelme@yom-demo.cl', '20508419-3', 'Desarrollador Backend', 'contratado', 1, 9, 'https://drive.google.com/carta-oferta-011', '2026-08-21', '2026-08-10 09:15:25', 'n8n', 1, '2026-08-11 19:07:29');
INSERT INTO contacto_emergencia VALUES (11, 'Contacto de Lucas', '+56 9 6654 2928', 'hermano/a');
INSERT INTO documento VALUES (46, 11, 'afp_afiliacion', 'drv_8828e5a2d2', '2026-08-10 09:16:18', '2026-08-11 19:07:29');
INSERT INTO documento VALUES (47, 11, 'afp_cotizaciones', 'drv_eead5a2877', '2026-08-10 09:16:18', '2026-08-12 00:40:18');
INSERT INTO documento VALUES (48, 11, 'salud_afiliacion', 'drv_455e590928', '2026-08-10 09:16:18', '2026-08-11 21:02:35');
INSERT INTO documento VALUES (49, 11, 'cedula', 'drv_92f3fa54e2', '2026-08-10 09:16:18', '2026-08-11 21:59:00');
INSERT INTO documento VALUES (50, 11, 'antecedentes', 'drv_2498c43f0e', '2026-08-10 09:16:18', '2026-08-11 23:01:45');
INSERT INTO documento VALUES (51, 11, 'foto_personal', 'drv_c313315ed', '2026-08-10 09:16:18', '2026-08-13 06:49:34');
INSERT INTO contrato VALUES (11, 11, '2026-08-14 01:53:13', '2026-08-20 05:02:04', 'firmado');
INSERT INTO notificacion VALUES (33, 11, 'recordatorio_lider', '2026-08-10 09:16:36', 'enviado');
INSERT INTO notificacion VALUES (34, 11, 'bienvenida_correo', '2026-08-10 09:15:46', 'enviado');
INSERT INTO notificacion VALUES (35, 11, 'aviso_accesos', '2026-08-10 09:17:01', 'enviado');
INSERT INTO notificacion VALUES (36, 11, 'datos_primer_dia', '2026-08-10 09:15:53', 'enviado');
INSERT INTO notificacion VALUES (37, 11, 'anuncio_equipo', '2026-08-10 09:17:04', 'enviado');
INSERT INTO notificacion VALUES (38, 11, 'reunion_buddy', '2026-08-10 09:15:56', 'enviado');
INSERT INTO reunion VALUES (6, 11, 'evt_80212dff', '2026-08-21 10:00:00', '2026-08-21 11:00:00', '2026-08-10 09:15:56');
INSERT INTO notificacion VALUES (39, 11, 'bienvenida_dia1', '2026-08-21 11:00:00', 'enviado');
INSERT INTO notificacion VALUES (40, 11, 'indicaciones_buddy', '2026-08-10 09:16:09', 'enviado');

-- Onboarding 12: Emilia Cortés (practicante, flujo n8n)
INSERT INTO onboarding VALUES (12, 'emiliacortes@gmail.com-20260824', 'Emilia Cortés', 'emiliacortes@gmail.com', 'emilia.cortes@yom-demo.cl', '20545548-5', 'Practicante de Datos', 'practicante', 2, 8, 'https://drive.google.com/carta-oferta-012', '2026-09-08', '2026-08-24 14:19:40', 'n8n', 1, '2026-08-26 22:14:15');
INSERT INTO contacto_emergencia VALUES (12, 'Contacto de Emilia', '+56 9 9668 1182', 'pareja');
INSERT INTO documento VALUES (52, 12, 'cedula', 'drv_8b3314518d', '2026-08-24 14:20:29', '2026-08-26 23:21:17');
INSERT INTO documento VALUES (53, 12, 'salud_afiliacion', 'drv_8a03f941ff', '2026-08-24 14:20:29', '2026-08-26 22:14:15');
INSERT INTO documento VALUES (54, 12, 'foto_personal', 'drv_dafd642051', '2026-08-24 14:20:29', '2026-08-27 05:07:00');
INSERT INTO contrato VALUES (12, 12, '2026-08-27 18:02:33', '2026-08-29 19:52:01', 'firmado');
INSERT INTO notificacion VALUES (41, 12, 'recordatorio_lider', '2026-08-24 14:21:18', 'enviado');
INSERT INTO notificacion VALUES (42, 12, 'bienvenida_correo', '2026-08-24 14:20:58', 'enviado');
INSERT INTO notificacion VALUES (43, 12, 'aviso_accesos', '2026-08-24 14:20:55', 'enviado');
INSERT INTO notificacion VALUES (44, 12, 'datos_primer_dia', '2026-08-24 14:20:56', 'enviado');
INSERT INTO notificacion VALUES (45, 12, 'anuncio_equipo', '2026-08-24 14:20:27', 'enviado');
INSERT INTO notificacion VALUES (46, 12, 'reunion_buddy', '2026-08-24 14:20:04', 'enviado');
INSERT INTO reunion VALUES (7, 12, 'evt_cbc15bc3', '2026-09-08 10:00:00', '2026-09-08 11:00:00', '2026-08-24 14:20:04');
INSERT INTO notificacion VALUES (47, 12, 'bienvenida_dia1', '2026-09-08 11:00:00', 'enviado');
INSERT INTO notificacion VALUES (48, 12, 'indicaciones_buddy', '2026-08-24 14:21:18', 'enviado');

-- Onboarding 13: Sebastián Vargas (contratado, flujo n8n)
INSERT INTO onboarding VALUES (13, 'sebastianvargas@gmail.com-20260907', 'Sebastián Vargas', 'sebastianvargas@gmail.com', 'sebastian.vargas@yom-demo.cl', '20582677-7', 'Analista de Operaciones', 'contratado', 5, 4, 'https://drive.google.com/carta-oferta-013', '2026-09-24', '2026-09-07 12:53:50', 'n8n', 1, '2026-09-09 20:46:31');
INSERT INTO contacto_emergencia VALUES (13, 'Contacto de Sebastián', '+56 9 5708 9403', 'padre');
INSERT INTO documento VALUES (55, 13, 'afp_afiliacion', 'drv_c85a84d0ed', '2026-09-07 12:54:59', '2026-09-10 01:09:06');
INSERT INTO documento VALUES (56, 13, 'afp_cotizaciones', 'drv_9b3f364f7f', '2026-09-07 12:54:59', '2026-09-09 20:46:31');
INSERT INTO documento VALUES (57, 13, 'salud_afiliacion', 'drv_b83b3295ba', '2026-09-07 12:54:59', '2026-09-09 23:32:35');
INSERT INTO documento VALUES (58, 13, 'cedula', 'drv_2d1d4177a4', '2026-09-07 12:54:59', '2026-09-10 04:14:58');
INSERT INTO documento VALUES (59, 13, 'antecedentes', 'drv_4354467607', '2026-09-07 12:54:59', '2026-09-10 00:37:38');
INSERT INTO documento VALUES (60, 13, 'foto_personal', 'drv_dc9fd1068a', '2026-09-07 12:54:59', '2026-09-10 00:48:15');
INSERT INTO contrato VALUES (13, 13, '2026-09-10 13:31:15', '2026-09-14 13:50:43', 'firmado');
INSERT INTO notificacion VALUES (49, 13, 'recordatorio_lider', '2026-09-07 12:55:28', 'enviado');
INSERT INTO notificacion VALUES (50, 13, 'bienvenida_correo', '2026-09-07 12:54:25', 'enviado');
INSERT INTO notificacion VALUES (51, 13, 'aviso_accesos', '2026-09-07 12:55:17', 'enviado');
INSERT INTO notificacion VALUES (52, 13, 'datos_primer_dia', '2026-09-07 12:54:17', 'enviado');
INSERT INTO notificacion VALUES (53, 13, 'anuncio_equipo', '2026-09-07 12:55:23', 'enviado');
INSERT INTO notificacion VALUES (54, 13, 'reunion_buddy', '2026-09-07 12:54:18', 'enviado');
INSERT INTO reunion VALUES (8, 13, 'evt_a9e958c3', '2026-09-24 10:00:00', '2026-09-24 11:00:00', '2026-09-07 12:54:18');
INSERT INTO notificacion VALUES (55, 13, 'bienvenida_dia1', '2026-09-24 11:00:00', 'enviado');
INSERT INTO notificacion VALUES (56, 13, 'indicaciones_buddy', '2026-09-07 12:54:18', 'enviado');

-- Onboarding 14: Josefa Tapia (practicante, flujo n8n)
INSERT INTO onboarding VALUES (14, 'josefatapia@gmail.com-20260914', 'Josefa Tapia', 'josefatapia@gmail.com', 'josefa.tapia@yom-demo.cl', '20619806-0', 'Practicante Comercial', 'practicante', 3, 6, 'https://drive.google.com/carta-oferta-014', '2026-10-06', '2026-09-14 13:25:22', 'n8n', 1, '2026-09-16 14:32:44');
INSERT INTO contacto_emergencia VALUES (14, 'Contacto de Josefa', '+56 9 4386 1971', 'pareja');
INSERT INTO documento VALUES (61, 14, 'cedula', 'drv_44969c678c', '2026-09-14 13:26:01', '2026-09-16 16:31:36');
INSERT INTO documento VALUES (62, 14, 'salud_afiliacion', 'drv_2897fb237f', '2026-09-14 13:26:01', '2026-09-16 14:32:44');
INSERT INTO documento VALUES (63, 14, 'foto_personal', 'drv_4548a0a549', '2026-09-14 13:26:01', '2026-09-18 20:58:05');
INSERT INTO contrato VALUES (14, 14, '2026-09-18 23:58:22', '2026-09-20 17:02:14', 'firmado');
INSERT INTO notificacion VALUES (57, 14, 'recordatorio_lider', '2026-09-14 13:25:56', 'enviado');
INSERT INTO notificacion VALUES (58, 14, 'bienvenida_correo', '2026-09-14 13:26:38', 'enviado');
INSERT INTO notificacion VALUES (59, 14, 'aviso_accesos', '2026-09-14 13:27:01', 'enviado');
INSERT INTO notificacion VALUES (60, 14, 'datos_primer_dia', '2026-09-14 13:26:45', 'enviado');
INSERT INTO notificacion VALUES (61, 14, 'anuncio_equipo', '2026-09-14 13:26:34', 'enviado');
INSERT INTO notificacion VALUES (62, 14, 'reunion_buddy', '2026-09-14 13:26:48', 'enviado');
INSERT INTO reunion VALUES (9, 14, 'evt_01d03325', '2026-10-06 10:00:00', '2026-10-06 11:00:00', '2026-09-14 13:26:48');
INSERT INTO notificacion VALUES (63, 14, 'bienvenida_dia1', '2026-10-06 11:00:00', 'enviado');
INSERT INTO notificacion VALUES (64, 14, 'indicaciones_buddy', '2026-09-14 13:26:26', 'enviado');

-- Onboarding 15: Tomás Olivares (practicante, flujo n8n)
INSERT INTO onboarding VALUES (15, 'tomasolivares@gmail.com-20260928', 'Tomás Olivares', 'tomasolivares@gmail.com', 'tomas.olivares@yom-demo.cl', '20656935-2', 'Practicante de Desarrollo', 'practicante', 1, 7, 'https://drive.google.com/carta-oferta-015', '2026-10-14', '2026-09-28 09:44:01', 'n8n', 1, '2026-09-30 16:32:22');
INSERT INTO contacto_emergencia VALUES (15, 'Contacto de Tomás', '+56 9 4091 5919', 'madre');
INSERT INTO documento VALUES (64, 15, 'cedula', 'drv_934235c7c3', '2026-09-28 09:45:06', '2026-09-30 23:37:09');
INSERT INTO documento VALUES (65, 15, 'salud_afiliacion', 'drv_9e668dadac', '2026-09-28 09:45:06', '2026-09-30 22:19:13');
INSERT INTO documento VALUES (66, 15, 'foto_personal', 'drv_c413331f18', '2026-09-28 09:45:06', '2026-09-30 16:32:22');
INSERT INTO contrato VALUES (15, 15, '2026-10-01 15:51:11', '2026-10-02 15:07:39', 'firmado');
INSERT INTO notificacion VALUES (65, 15, 'recordatorio_lider', '2026-09-28 09:45:17', 'enviado');
INSERT INTO notificacion VALUES (66, 15, 'bienvenida_correo', '2026-09-28 09:45:31', 'enviado');
INSERT INTO notificacion VALUES (67, 15, 'aviso_accesos', '2026-09-28 09:45:10', 'enviado');
INSERT INTO notificacion VALUES (68, 15, 'datos_primer_dia', '2026-09-28 09:45:34', 'enviado');
INSERT INTO notificacion VALUES (69, 15, 'anuncio_equipo', '2026-09-28 09:44:37', 'enviado');
INSERT INTO notificacion VALUES (70, 15, 'reunion_buddy', '2026-09-28 09:44:39', 'enviado');
INSERT INTO reunion VALUES (10, 15, 'evt_2d56636d', '2026-10-14 10:00:00', '2026-10-14 11:00:00', '2026-09-28 09:44:39');
INSERT INTO notificacion VALUES (71, 15, 'bienvenida_dia1', '2026-10-14 11:00:00', 'enviado');
INSERT INTO notificacion VALUES (72, 15, 'indicaciones_buddy', '2026-09-28 09:45:41', 'enviado');

-- Onboarding 16: Trinidad Lagos (contratado, flujo n8n)
INSERT INTO onboarding VALUES (16, 'trinidadlagos@gmail.com-20261005', 'Trinidad Lagos', 'trinidadlagos@gmail.com', 'trinidad.lagos@yom-demo.cl', '20694064-6', 'Ejecutiva de Customer Success', 'contratado', 4, 6, 'https://drive.google.com/carta-oferta-016', '2026-10-27', '2026-10-05 13:12:52', 'n8n', 1, '2026-10-07 15:10:14');
INSERT INTO contacto_emergencia VALUES (16, 'Contacto de Trinidad', '+56 9 7600 6363', 'pareja');
INSERT INTO documento VALUES (67, 16, 'afp_afiliacion', 'drv_f9e4c419c3', '2026-10-05 13:13:22', '2026-10-09 06:53:02');
INSERT INTO documento VALUES (68, 16, 'afp_cotizaciones', 'drv_722240a9a', '2026-10-05 13:13:22', '2026-10-07 20:26:01');
INSERT INTO documento VALUES (69, 16, 'salud_afiliacion', 'drv_3316fedab1', '2026-10-05 13:13:22', '2026-10-07 17:15:41');
INSERT INTO documento VALUES (70, 16, 'cedula', 'drv_a8b25b19a5', '2026-10-05 13:13:22', '2026-10-07 15:10:14');
INSERT INTO documento VALUES (71, 16, 'antecedentes', 'drv_fe5966e54', '2026-10-05 13:13:22', '2026-10-07 20:04:42');
INSERT INTO documento VALUES (72, 16, 'foto_personal', 'drv_745ed9247e', '2026-10-05 13:13:22', '2026-10-07 17:18:53');
INSERT INTO contrato VALUES (16, 16, '2026-10-09 14:01:52', '2026-10-16 02:20:51', 'firmado');
INSERT INTO notificacion VALUES (73, 16, 'recordatorio_lider', '2026-10-05 13:14:03', 'enviado');
INSERT INTO notificacion VALUES (74, 16, 'bienvenida_correo', '2026-10-05 13:13:37', 'enviado');
INSERT INTO notificacion VALUES (75, 16, 'aviso_accesos', '2026-10-05 13:14:10', 'enviado');
INSERT INTO notificacion VALUES (76, 16, 'datos_primer_dia', '2026-10-05 13:14:24', 'enviado');
INSERT INTO notificacion VALUES (77, 16, 'anuncio_equipo', '2026-10-05 13:14:30', 'fallido');
INSERT INTO notificacion VALUES (78, 16, 'reunion_buddy', '2026-10-05 13:13:55', 'enviado');
INSERT INTO reunion VALUES (11, 16, 'evt_46794c24', '2026-10-27 10:00:00', '2026-10-27 11:00:00', '2026-10-05 13:13:55');
INSERT INTO notificacion VALUES (79, 16, 'bienvenida_dia1', '2026-10-27 11:00:00', 'enviado');
INSERT INTO notificacion VALUES (80, 16, 'indicaciones_buddy', '2026-10-05 13:14:01', 'enviado');

-- Onboarding 17: Cristóbal Molina (contratado, flujo n8n)
INSERT INTO onboarding VALUES (17, 'cristobalmolina@gmail.com-20261013', 'Cristóbal Molina', 'cristobalmolina@gmail.com', 'cristobal.molina@yom-demo.cl', '20731193-6', 'Analista de Datos', 'contratado', 2, 9, 'https://drive.google.com/carta-oferta-017', '2026-11-02', '2026-10-13 16:42:30', 'n8n', 1, '2026-10-15 04:32:12');
INSERT INTO contacto_emergencia VALUES (17, 'Contacto de Cristóbal', '+56 9 5512 7115', 'madre');
INSERT INTO documento VALUES (73, 17, 'afp_afiliacion', 'drv_3b5c7e09ee', '2026-10-13 16:43:05', '2026-10-15 06:38:13');
INSERT INTO documento VALUES (74, 17, 'afp_cotizaciones', 'drv_378758843c', '2026-10-13 16:43:05', '2026-10-15 04:32:12');
INSERT INTO documento VALUES (75, 17, 'salud_afiliacion', 'drv_576430d86c', '2026-10-13 16:43:05', '2026-10-15 10:21:07');
INSERT INTO documento VALUES (76, 17, 'cedula', 'drv_da56599a2', '2026-10-13 16:43:05', '2026-10-15 06:26:55');
INSERT INTO documento VALUES (77, 17, 'antecedentes', 'drv_67bb3599cb', '2026-10-13 16:43:05', '2026-10-15 06:22:10');
INSERT INTO documento VALUES (78, 17, 'foto_personal', 'drv_f3f31dc393', '2026-10-13 16:43:05', '2026-10-15 04:38:12');
INSERT INTO contrato VALUES (17, 17, '2026-10-15 22:24:13', '2026-10-20 17:21:16', 'firmado');
INSERT INTO notificacion VALUES (81, 17, 'recordatorio_lider', '2026-10-13 16:43:27', 'enviado');
INSERT INTO notificacion VALUES (82, 17, 'bienvenida_correo', '2026-10-13 16:43:51', 'enviado');
INSERT INTO notificacion VALUES (83, 17, 'aviso_accesos', '2026-10-13 16:43:59', 'enviado');
INSERT INTO notificacion VALUES (84, 17, 'datos_primer_dia', '2026-10-13 16:43:31', 'enviado');
INSERT INTO notificacion VALUES (85, 17, 'anuncio_equipo', '2026-10-13 16:43:35', 'enviado');
INSERT INTO notificacion VALUES (86, 17, 'reunion_buddy', '2026-10-13 16:43:18', 'enviado');
INSERT INTO reunion VALUES (12, 17, 'evt_69000fee', '2026-11-02 10:00:00', '2026-11-02 11:00:00', '2026-10-13 16:43:18');
INSERT INTO notificacion VALUES (87, 17, 'bienvenida_dia1', '2026-11-02 11:00:00', 'enviado');
INSERT INTO notificacion VALUES (88, 17, 'indicaciones_buddy', '2026-10-13 16:43:55', 'enviado');

-- Onboarding 18: Amanda Salinas (practicante, flujo n8n)
INSERT INTO onboarding VALUES (18, 'amandasalinas@gmail.com-20261019', 'Amanda Salinas', 'amandasalinas@gmail.com', 'amanda.salinas@yom-demo.cl', '20768322-1', 'Practicante de Operaciones', 'practicante', 5, 8, 'https://drive.google.com/carta-oferta-018', '2026-11-10', '2026-10-19 10:37:53', 'n8n', 1, '2026-10-21 20:51:06');
INSERT INTO contacto_emergencia VALUES (18, 'Contacto de Amanda', '+56 9 5944 6369', 'madre');
INSERT INTO documento VALUES (79, 18, 'cedula', 'drv_9544685dbf', '2026-10-19 10:38:35', '2026-10-21 20:51:06');
INSERT INTO documento VALUES (80, 18, 'salud_afiliacion', 'drv_8be79e4470', '2026-10-19 10:38:35', '2026-10-22 02:08:03');
INSERT INTO documento VALUES (81, 18, 'foto_personal', 'drv_fd9c075ca1', '2026-10-19 10:38:35', '2026-10-22 00:53:11');
INSERT INTO contrato VALUES (18, 18, '2026-10-22 19:40:55', '2026-10-23 15:46:22', 'firmado');
INSERT INTO notificacion VALUES (89, 18, 'recordatorio_lider', '2026-10-19 10:38:13', 'enviado');
INSERT INTO notificacion VALUES (90, 18, 'bienvenida_correo', '2026-10-19 10:38:15', 'enviado');
INSERT INTO notificacion VALUES (91, 18, 'aviso_accesos', '2026-10-19 10:38:55', 'enviado');
INSERT INTO notificacion VALUES (92, 18, 'datos_primer_dia', '2026-10-19 10:38:34', 'enviado');
INSERT INTO notificacion VALUES (93, 18, 'anuncio_equipo', '2026-10-19 10:39:02', 'enviado');
INSERT INTO notificacion VALUES (94, 18, 'reunion_buddy', '2026-10-19 10:38:56', 'enviado');
INSERT INTO reunion VALUES (13, 18, 'evt_33711f84', '2026-11-10 10:00:00', '2026-11-10 11:00:00', '2026-10-19 10:38:56');
INSERT INTO notificacion VALUES (95, 18, 'indicaciones_buddy', '2026-10-19 10:39:26', 'enviado');

-- Onboarding 19: Nicolás Paredes (contratado, flujo n8n)
INSERT INTO onboarding VALUES (19, 'nicolasparedes@gmail.com-20261028', 'Nicolás Paredes', 'nicolasparedes@gmail.com', 'nicolas.paredes@yom-demo.cl', '20805451-1', 'Desarrolladora Frontend', 'contratado', 1, 7, 'https://drive.google.com/carta-oferta-019', '2026-11-19', '2026-10-28 15:43:48', 'n8n', 1, '2026-10-30 02:26:25');
INSERT INTO contacto_emergencia VALUES (19, 'Contacto de Nicolás', '+56 9 9193 7420', 'hermano/a');
INSERT INTO documento VALUES (82, 19, 'afp_afiliacion', 'drv_81fa4d94f7', '2026-10-28 15:45:22', '2026-10-30 08:38:51');
INSERT INTO documento VALUES (83, 19, 'afp_cotizaciones', 'drv_6f24758887', '2026-10-28 15:45:22', '2026-10-30 02:26:25');
INSERT INTO documento VALUES (84, 19, 'salud_afiliacion', 'drv_dd22c4eef7', '2026-10-28 15:45:22', '2026-10-30 09:12:18');
INSERT INTO documento VALUES (85, 19, 'cedula', 'drv_a812059565', '2026-10-28 15:45:22', '2026-10-30 04:29:11');
INSERT INTO documento VALUES (86, 19, 'antecedentes', NULL, '2026-10-28 15:45:22', NULL);
INSERT INTO documento VALUES (87, 19, 'foto_personal', 'drv_6f7cceaaa', '2026-10-28 15:45:22', '2026-10-30 03:34:46');
INSERT INTO notificacion VALUES (96, 19, 'recordatorio_lider', '2026-10-28 15:45:28', 'enviado');
INSERT INTO notificacion VALUES (97, 19, 'bienvenida_correo', '2026-10-28 15:45:21', 'enviado');
INSERT INTO notificacion VALUES (98, 19, 'aviso_accesos', '2026-10-28 15:44:30', 'enviado');
INSERT INTO notificacion VALUES (99, 19, 'datos_primer_dia', '2026-10-28 15:44:45', 'enviado');
INSERT INTO notificacion VALUES (100, 19, 'anuncio_equipo', '2026-10-28 15:45:13', 'enviado');
INSERT INTO notificacion VALUES (101, 19, 'reunion_buddy', '2026-10-28 15:44:55', 'enviado');
INSERT INTO reunion VALUES (14, 19, 'evt_9ae4326b', '2026-11-19 10:00:00', '2026-11-19 11:00:00', '2026-10-28 15:44:55');
INSERT INTO notificacion VALUES (102, 19, 'indicaciones_buddy', '2026-10-28 15:44:46', 'enviado');

-- Onboarding 20: Rocío Cáceres (practicante, flujo n8n)
INSERT INTO onboarding VALUES (20, 'rociocaceres@gmail.com-20261104', 'Rocío Cáceres', 'rociocaceres@gmail.com', 'rocio.caceres@yom-demo.cl', NULL, 'Practicante Comercial', 'practicante', 3, 4, 'https://drive.google.com/carta-oferta-020', '2026-11-18', '2026-11-04 12:43:01', 'n8n', 0, NULL);
INSERT INTO documento VALUES (88, 20, 'cedula', NULL, '2026-11-04 12:44:08', NULL);
INSERT INTO documento VALUES (89, 20, 'salud_afiliacion', NULL, '2026-11-04 12:44:08', NULL);
INSERT INTO documento VALUES (90, 20, 'foto_personal', NULL, '2026-11-04 12:44:08', NULL);
INSERT INTO notificacion VALUES (103, 20, 'recordatorio_lider', '2026-11-04 12:44:34', 'enviado');
INSERT INTO notificacion VALUES (104, 20, 'bienvenida_correo', '2026-11-04 12:44:17', 'enviado');
INSERT INTO notificacion VALUES (105, 20, 'aviso_accesos', '2026-11-04 12:43:51', 'enviado');
INSERT INTO notificacion VALUES (106, 20, 'datos_primer_dia', '2026-11-04 12:44:34', 'enviado');
INSERT INTO notificacion VALUES (107, 20, 'anuncio_equipo', '2026-11-04 12:44:09', 'enviado');
INSERT INTO notificacion VALUES (108, 20, 'reunion_buddy', '2026-11-04 12:43:23', 'enviado');
INSERT INTO reunion VALUES (15, 20, 'evt_9a93aaaf', '2026-11-18 10:00:00', '2026-11-18 11:00:00', '2026-11-04 12:43:23');
INSERT INTO notificacion VALUES (109, 20, 'indicaciones_buddy', '2026-11-04 12:44:21', 'enviado');

COMMIT;
