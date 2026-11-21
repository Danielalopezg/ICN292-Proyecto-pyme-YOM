"""
Crea automatizacion/onboarding_yom.json a partir del export original de n8n, reemplazando
identificadores internos de YOM (planillas, canal y usuario de Slack, calendario, enlaces) por
marcadores. El export original NO se sube al repo público.
Uso: python scripts/sanitizar_n8n.py <export_original.json>
"""
import json
import re
import sys
from pathlib import Path

REEMPLAZOS = {
    "1q3U5Vsjxt4amxhXKFglf7uEZXIATLhzicpn7rCiEI00": "ID_PLANILLA_FORMULARIO_DATOS_GENERALES",
    "1F4u_f6tw5eY-dP4wKB2cNE4gwsNZh9UXZAghPWNBauw": "ID_PLANILLA_ONBOARDING_MASTER",
    "C046741G9T4": "ID_CANAL_SLACK_GENERAL",
    "U065UR52FFV": "ID_USUARIO_SLACK_CHIEF_OF_STAFF",
    "cultura@yom.ai": "calendario-cultura@empresa.cl",
    "https://forms.gle/GDbQeTnSqJNzPpPk8": "https://forms.gle/FORMULARIO_TRABAJADOR",
}
PATRONES = [(r"https://docs\.google\.com/presentation/d/[A-Za-z0-9_-]+[^\"\s<\\]*",
             "https://docs.google.com/presentation/d/PRESENTACION_CULTURA")]

txt = Path(sys.argv[1]).read_text(encoding="utf-8")
for a, b in REEMPLAZOS.items():
    txt = txt.replace(a, b)
for pat, rep in PATRONES:
    txt = re.sub(pat, rep, txt)
d = json.loads(txt)
d.get("meta", {}).pop("instanceId", None)
for n in d["nodes"]:
    for cred in n.get("credentials", {}).values():
        cred["id"] = "REEMPLAZAR_AL_IMPORTAR"
d["name"] = "Automatización Proceso de Onboarding (YOM)"
out = Path(__file__).resolve().parent.parent / "automatizacion" / "onboarding_yom.json"
out.write_text(json.dumps(d, ensure_ascii=False, indent=2), encoding="utf-8")
print("ok ->", out)
