"""
Genera db/seed.sql con datos SINTÉTICOS (ninguna persona es real) coherentes con YOM.

Calibración:
  * Entrevista a la Chief of Staff (27-08-2026) para el flujo MANUAL (AS-IS, feb-jul 2026):
    formularios que se reenvían y demoran más de un día, documentos faltantes pedidos por
    WhatsApp/correo sin plazo, avisos que dependen de que RRHH se acuerde, practicantes con un
    proceso más informal y contratos firmados vía Buk en ~1,5 semanas.
  * Flujo n8n real (automatizacion/onboarding_yom.json) para el flujo N8N (TO-BE, ago-nov 2026):
    el trigger revisa la planilla cada 1 minuto; las acciones salen en paralelo; la reunión con el
    buddy se agenda el día de ingreso de 10:00 a 11:00 (hora de Chile) y el nodo Wait publica el
    mensaje de bienvenida en Slack cuando termina la reunión.

Uso:  python scripts/generar_seed.py      (semilla fija => siempre el mismo seed.sql)
"""
import random
from datetime import datetime, timedelta, date
from pathlib import Path

random.seed(292)
OUT = Path(__file__).resolve().parent.parent / "db" / "seed.sql"
CORTE = datetime(2026, 11, 9, 18, 0)          # fecha de corte de los datos
DOMINIO = "yom-demo.cl"                        # dominio ficticio


def dv(num):
    s, m = 0, 2
    for d in reversed(str(num)):
        s += int(d) * m
        m = 2 if m == 7 else m + 1
    r = 11 - s % 11
    return "0" if r == 11 else "K" if r == 10 else str(r)


def q(v):
    if v is None:
        return "NULL"
    if isinstance(v, (int, float)):
        return str(v)
    return "'" + str(v).replace("'", "''") + "'"


def ts(d):
    return d.strftime("%Y-%m-%d %H:%M:%S")


def habil(d):
    while d.weekday() >= 5:
        d += timedelta(days=1)
    return d


def slug(nombre):
    s = nombre.lower()
    for a, b in zip("áéíóúñ", "aeioun"):
        s = s.replace(a, b)
    p = s.split()
    return f"{p[0]}.{p[1]}"


ACCIONES = [  # (codigo, nodo_n8n, canal, destinatario, diferida)
    ("recordatorio_lider", "Envío recordatorio a líder", "correo", "lider", 0),
    ("bienvenida_correo", "Bienvenida a Yom", "correo", "trabajador", 0),
    ("aviso_accesos", "Aviso a Sofi: creación de accesos", "slack", "chief_of_staff", 0),
    ("datos_primer_dia", "Datos importantes a nuevo Yomer", "correo", "trabajador", 0),
    ("anuncio_equipo", "Aviso de bienvenida al team de Yom", "slack", "equipo", 0),
    ("reunion_buddy", "Reunión entre Nuevo Yomer y Onboarding Buddy", "calendario", "trabajador_y_buddy", 0),
    ("bienvenida_dia1", "Mensaje de bienvenida automatizado", "slack", "equipo", 1),
    ("indicaciones_buddy", "Indicaciones Onboarding Buddy", "correo", "buddy", 0),
]
# Probabilidad de que RRHH hiciera a mano cada acción en el AS-IS (según la entrevista)
PROB_MANUAL = {"recordatorio_lider": 0.5, "bienvenida_correo": 0.9, "aviso_accesos": 0.3,
               "datos_primer_dia": 0.4, "anuncio_equipo": 0.2, "reunion_buddy": 0.6,
               "bienvenida_dia1": 0.9, "indicaciones_buddy": 0.0}

colaboradores = [  # id, nombre, telefono
    (1, "Matías Fuentes", None), (2, "Carolina Vega", None), (3, "Rodrigo Pizarro", None),
    (4, "Valentina Rojas", None), (5, "Andrés Muñoz", None),
    (6, "Ignacio Torres", "+56 9 6123 4501"), (7, "Fernanda Castro", "+56 9 6123 4502"),
    (8, "Diego Herrera", "+56 9 6123 4503"), (9, "Camila Soto", "+56 9 6123 4504"),
]
# Valentina (id 4) es líder y también buddy: con la tabla colaborador se guarda una sola vez.
BUDDIES = [6, 7, 8, 9, 4]

plan = [  # fecha registro, cargo, tipo, flujo, id_lider
    ("2026-02-02", "Desarrollador Backend", "contratado", "manual", 1),
    ("2026-02-16", "Practicante Comercial", "practicante", "manual", 3),
    ("2026-03-02", "Analista de Datos", "contratado", "manual", 2),
    ("2026-03-23", "Practicante de Desarrollo", "practicante", "manual", 1),
    ("2026-04-06", "Ejecutiva de Customer Success", "contratado", "manual", 4),
    ("2026-04-27", "Practicante de Operaciones", "practicante", "manual", 5),
    ("2026-05-11", "Desarrolladora Frontend", "contratado", "manual", 1),
    ("2026-06-01", "Practicante de Datos", "practicante", "manual", 2),
    ("2026-06-22", "Ejecutivo Comercial", "contratado", "manual", 3),
    ("2026-07-06", "Practicante de Customer Success", "practicante", "manual", 4),
    ("2026-08-10", "Desarrollador Backend", "contratado", "n8n", 1),
    ("2026-08-24", "Practicante de Datos", "practicante", "n8n", 2),
    ("2026-09-07", "Analista de Operaciones", "contratado", "n8n", 5),
    ("2026-09-14", "Practicante Comercial", "practicante", "n8n", 3),
    ("2026-09-28", "Practicante de Desarrollo", "practicante", "n8n", 1),
    ("2026-10-05", "Ejecutiva de Customer Success", "contratado", "n8n", 4),
    ("2026-10-13", "Analista de Datos", "contratado", "n8n", 2),
    ("2026-10-19", "Practicante de Operaciones", "practicante", "n8n", 5),
    ("2026-10-28", "Desarrolladora Frontend", "contratado", "n8n", 1),   # en curso
    ("2026-11-04", "Practicante Comercial", "practicante", "n8n", 3),    # en curso
]
nombres = ["Benjamín Araya", "Isidora Contreras", "Joaquín Sepúlveda", "Antonia Espinoza",
           "Vicente Navarro", "Martina Valenzuela", "Agustín Carrasco", "Florencia Gutiérrez",
           "Maximiliano Bravo", "Catalina Figueroa", "Lucas Riquelme", "Emilia Cortés",
           "Sebastián Vargas", "Josefa Tapia", "Tomás Olivares", "Trinidad Lagos",
           "Cristóbal Molina", "Amanda Salinas", "Nicolás Paredes", "Rocío Cáceres"]
DOCS = {"contratado": ["afp_afiliacion", "afp_cotizaciones", "salud_afiliacion", "cedula", "antecedentes", "foto_personal"],
        "practicante": ["cedula", "salud_afiliacion", "foto_personal"]}

L = ["-- seed.sql — datos SINTÉTICOS generados por scripts/generar_seed.py (semilla 292).",
     "-- Ninguna persona es real. Calibrados con la entrevista a YOM (27-08-2026) y con el flujo n8n real.",
     f"-- Fecha de corte de los datos: {CORTE:%Y-%m-%d}.",
     "PRAGMA foreign_keys = ON;", "BEGIN TRANSACTION;", "", "-- Catálogo de acciones = nodos de acción del flujo n8n"]
for a in ACCIONES:
    L.append("INSERT INTO accion VALUES (" + ", ".join(q(v) for v in a) + ");")
L.append("")
for i, n, t in colaboradores:
    L.append(f"INSERT INTO colaborador VALUES ({i}, {q(n)}, {q(slug(n) + '@' + DOMINIO)}, {q(t)});")
L.append("")

ids = {"doc": 0, "not": 0, "con": 0, "reu": 0}
contadores_buddy = {b: 0 for b in BUDDIES}
for k, (f_reg, cargo, tipo, flujo, lider) in enumerate(plan, start=1):
    nombre = nombres[k - 1]
    registro = datetime.fromisoformat(f_reg) + timedelta(hours=random.randint(9, 16), minutes=random.randint(0, 59),
                                                          seconds=random.randint(0, 59))
    ingreso = habil(registro + timedelta(days=random.randint(10, 24))).date()
    # buddy: el menos cargado, distinto del líder
    buddy = min((b for b in BUDDIES if b != lider), key=lambda b: (contadores_buddy[b], random.random()))
    contadores_buddy[buddy] += 1
    email_p = slug(nombre).replace(".", "") + "@gmail.com"
    codigo = f"{email_p}-{registro:%Y%m%d}"

    # ---------- documentos (formulario del trabajador)
    if flujo == "n8n":
        f_sol = registro + timedelta(seconds=random.randint(25, 95))          # va en el correo de bienvenida
        base = random.uniform(0.3, 2.5)
    else:
        f_sol = registro + timedelta(hours=random.uniform(2, 30))             # RRHH envía el formulario a mano
        base = random.uniform(1.5, 4.0) if random.random() < 0.6 else random.uniform(0.3, 1.2)
    recepciones = {}
    for td in DOCS[tipo]:
        extra = 0.0
        if random.random() < (0.3 if flujo == "manual" else 0.15):
            extra = random.uniform(2, 4) if flujo == "manual" else random.uniform(1, 3)
        rec = f_sol + timedelta(days=base + random.uniform(0, 0.4) + extra)
        recepciones[td] = rec if rec <= CORTE else None
    if k == 19:                                    # en curso: falta un documento
        recepciones["antecedentes"] = None
    if k == 20:                                    # en curso: aún no completa el formulario
        recepciones = {td: None for td in DOCS[tipo]}
    recibido_algo = any(recepciones.values())
    primer_doc = min((r for r in recepciones.values() if r), default=None)

    rut = f"{20100000 + k * 37129}-{dv(20100000 + k * 37129)}" if recibido_algo else None
    consent = 1 if (flujo == "n8n" and recibido_algo) else 0
    L.append(f"-- Onboarding {k}: {nombre} ({tipo}, flujo {flujo})")
    L.append("INSERT INTO onboarding VALUES (" + ", ".join(q(v) for v in [
        k, codigo, nombre, email_p, slug(nombre) + "@" + DOMINIO, rut, cargo, tipo, lider, buddy,
        f"https://drive.google.com/carta-oferta-{k:03d}", ingreso.isoformat(), ts(registro), flujo,
        consent, ts(primer_doc) if consent else None]) + ");")
    if recibido_algo:
        L.append(f"INSERT INTO contacto_emergencia VALUES ({k}, {q('Contacto de ' + nombre.split()[0])}, "
                 f"{q('+56 9 ' + str(random.randint(4000, 9999)) + ' ' + str(random.randint(1000, 9999)))}, "
                 f"{q(random.choice(['madre', 'padre', 'pareja', 'hermano/a']))});")
    for td, rec in recepciones.items():
        ids["doc"] += 1
        L.append(f"INSERT INTO documento VALUES ({ids['doc']}, {k}, {q(td)}, "
                 f"{q('drv_' + format(random.getrandbits(40), 'x')) if rec else 'NULL'}, {q(ts(f_sol))}, {q(ts(rec)) if rec else 'NULL'});")

    # ---------- contrato
    if all(recepciones.values()):
        ultimo = max(recepciones.values())
        sol = ultimo + timedelta(hours=random.uniform(2, 20))
        firma = sol + (timedelta(days=random.uniform(4, 7)) if tipo == "contratado"
                       else timedelta(days=random.uniform(0.5, 3) if flujo == "n8n" else random.uniform(1, 8)))
        ids["con"] += 1
        if firma <= CORTE:
            L.append(f"INSERT INTO contrato VALUES ({ids['con']}, {k}, {q(ts(sol))}, {q(ts(firma))}, 'firmado');")
        else:
            L.append(f"INSERT INTO contrato VALUES ({ids['con']}, {k}, {q(ts(sol))}, NULL, 'enviado_firma');")

    # ---------- acciones (notificaciones) y reunión
    inicio = datetime.combine(ingreso, datetime.min.time()) + timedelta(hours=10)
    fin = inicio + timedelta(hours=1)
    for cod, _, _, _, diferida in ACCIONES:
        if flujo == "n8n":
            if diferida:
                if fin > CORTE:
                    continue                                   # el Wait aún no se cumple
                env = fin
            else:
                env = registro + timedelta(seconds=random.randint(20, 100))
            estado = "fallido" if (k == 16 and cod == "anuncio_equipo") else "enviado"
        else:
            prob = PROB_MANUAL[cod] * (0.6 if tipo == "practicante" else 1.0)
            if random.random() > prob:
                continue
            if diferida:
                env = inicio + timedelta(hours=random.uniform(0, 30))   # anuncio el día 1 o el siguiente
            else:
                env = registro + timedelta(hours=random.uniform(4, 72))
            estado = "enviado"
        ids["not"] += 1
        L.append(f"INSERT INTO notificacion VALUES ({ids['not']}, {k}, {q(cod)}, {q(ts(env))}, {q(estado)});")
        if cod == "reunion_buddy":
            ids["reu"] += 1
            r_ini, r_fin = inicio, fin
            if flujo == "manual" and random.random() < 0.4:            # a veces quedaba después del día 1
                r_ini += timedelta(days=random.randint(1, 4)); r_fin = r_ini + timedelta(hours=1)
            ev = f"evt_{random.getrandbits(32):08x}" if flujo == "n8n" else None
            L.append(f"INSERT INTO reunion VALUES ({ids['reu']}, {k}, {q(ev)}, {q(ts(r_ini))}, {q(ts(r_fin))}, {q(ts(env))});")
    L.append("")

L.append("COMMIT;")
OUT.write_text("\n".join(L) + "\n", encoding="utf-8")
print(f"seed.sql: {len(plan)} onboardings, {ids['not']} notificaciones, {ids['doc']} documentos, "
      f"{ids['con']} contratos, {ids['reu']} reuniones")
