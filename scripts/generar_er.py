"""Genera assets/er_3fn.png (requiere Graphviz instalado: comando `dot`)."""
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
T = {
    "COLABORADOR": ["PK id_colaborador", "nombre", "email (UQ)", "telefono"],
    "ONBOARDING": ["PK id_onboarding", "codigo (UQ)", "nombre", "email_personal", "correo_corporativo (UQ)",
                   "rut (UQ)", "cargo", "tipo_vinculo", "FK id_lider", "FK id_buddy", "link_carta_oferta",
                   "fecha_ingreso", "fecha_registro", "flujo", "consentimiento_datos", "fecha_consentimiento"],
    "CONTACTO_EMERGENCIA": ["PK/FK id_onboarding", "nombre", "telefono", "relacion"],
    "CONTRATO": ["PK id_contrato", "FK id_onboarding (UQ)", "fecha_solicitud", "fecha_firma", "estado"],
    "DOCUMENTO": ["PK id_documento", "FK id_onboarding", "tipo", "drive_file_id", "fecha_solicitud",
                  "fecha_recepcion"],
    "NOTIFICACION": ["PK id_notificacion", "FK id_onboarding", "FK codigo_accion", "fecha_envio", "estado"],
    "ACCION": ["PK codigo", "nodo_n8n (UQ)", "canal", "destinatario_rol", "diferida"],
    "REUNION": ["PK id_reunion", "FK id_onboarding (UQ)", "event_id", "inicio", "fin", "fecha_agendada"],
}
R = [("COLABORADOR", "ONBOARDING", "1", "N", "lidera"), ("COLABORADOR", "ONBOARDING", "1", "N", "acompaña (buddy)"),
     ("ONBOARDING", "CONTACTO_EMERGENCIA", "1", "1", "declara"), ("ONBOARDING", "CONTRATO", "1", "1", "genera"),
     ("ONBOARDING", "DOCUMENTO", "1", "N", "requiere"), ("ONBOARDING", "NOTIFICACION", "1", "N", "dispara"),
     ("ACCION", "NOTIFICACION", "1", "N", "tipifica"), ("ONBOARDING", "REUNION", "1", "1", "agenda")]


def tabla(n, attrs):
    filas = "".join(
        '<TR><TD ALIGN="LEFT"><FONT POINT-SIZE="10">'
        + (f"<B><U>{a}</U></B>" if a.startswith("PK") else a) + "</FONT></TD></TR>" for a in attrs)
    return (f'{n} [label=<<TABLE BORDER="1" CELLBORDER="0" CELLSPACING="0" CELLPADDING="4" COLOR="#1B3A6B">'
            f'<TR><TD BGCOLOR="#1B3A6B"><FONT COLOR="white"><B>{n}</B></FONT></TD></TR>{filas}</TABLE>>];')


dot = ["digraph ER {", 'graph [rankdir=LR, nodesep=0.5, ranksep=1.1, fontname="Helvetica", bgcolor="white"];',
       'node [shape=plaintext, fontname="Helvetica"];',
       'edge [arrowhead=none, color="#455A64", fontname="Helvetica", fontsize=10];']
dot += [tabla(n, a) for n, a in T.items()]
dot += [f'{a} -> {b} [taillabel="{ca}", headlabel="{cb}", label=<<I>{v}</I>>, labeldistance=1.6];'
        for a, b, ca, cb, v in R]
dot.append("}")

src = ROOT / "assets" / "er_3fn.dot"
src.write_text("\n".join(dot), encoding="utf-8")
subprocess.run(["dot", "-Tpng", "-Gdpi=170", str(src), "-o", str(ROOT / "assets" / "er_3fn.png")], check=True)
print("assets/er_3fn.png generado")
