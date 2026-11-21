"""
YOM · Onboarding SIG — visor OPCIONAL de la base (Streamlit). No es necesario para la prueba de oro
del README (que usa solo sqlite3). Ejecutar desde la raíz:   streamlit run app/app.py
"""
import re
import sqlite3
from pathlib import Path

import pandas as pd
import streamlit as st

ROOT = Path(__file__).resolve().parent.parent
DB = ROOT / "db" / "yom.db"
st.set_page_config(page_title="YOM · Onboarding SIG", page_icon="🧭", layout="wide")


def conectar():
    nueva = not DB.exists()
    con = sqlite3.connect(DB, check_same_thread=False)
    con.execute("PRAGMA foreign_keys = ON")
    if nueva:  # misma carga que el README: schema.sql + seed.sql
        con.executescript((ROOT / "db" / "schema.sql").read_text(encoding="utf-8"))
        con.executescript((ROOT / "db" / "seed.sql").read_text(encoding="utf-8"))
    return con


def q(sql):
    return pd.read_sql(sql, conectar())


def consultas():
    texto = (ROOT / "db" / "queries.sql").read_text(encoding="utf-8")
    for b in re.split(r"\n(?=-- Q\d)", texto):
        m = re.match(r"-- (Q\d+) · (.*)", b)
        if m:
            sql = "\n".join(l for l in b.splitlines() if not l.strip().startswith("--")).strip().rstrip(";")
            yield m.group(1), m.group(2), sql


st.title("🧭 YOM · Onboarding SIG")
st.caption("ICN-292 · Entrega 2 — flujo manual (AS-IS) vs. flujo n8n (TO-BE). Datos sintéticos, corte 09-11-2026.")
t1, t2, t3 = st.tabs(["📊 Indicadores", "📋 Seguimiento", "🔎 Consultas SQL"])

with t1:
    res = {qid: q(sql) for qid, _, sql in consultas()}
    q1 = res["Q1"].set_index("flujo")["minutos_promedio"]
    q2 = res["Q2"]
    q3 = res["Q3"].set_index("flujo")["dias_promedio"]
    q5 = res["Q5"].query("tipo_vinculo == 'contratado'").set_index("flujo")["dias_promedio"]
    q6 = res["Q6"].set_index("flujo")["pct_dia_1"]
    cob = (q2.cobertura_pct * q2.incorporaciones).groupby(q2.flujo).sum() / q2.incorporaciones.groupby(q2.flujo).sum()
    c = st.columns(5)
    c[0].metric("Minutos hasta cada aviso", f"{q1['n8n']:.1f}", f"{q1['n8n'] - q1['manual']:+.0f} vs. manual", delta_color="inverse")
    c[1].metric("Cobertura de las 8 acciones", f"{cob['n8n']:.1f} %", f"{cob['n8n'] - cob['manual']:+.1f} pp")
    c[2].metric("Días para documentación completa", f"{q3['n8n']:.1f}", f"{q3['n8n'] - q3['manual']:+.1f}", delta_color="inverse")
    c[3].metric("Días a contrato firmado (contratados)", f"{q5['n8n']:.1f}", f"{q5['n8n'] - q5['manual']:+.1f}", delta_color="inverse")
    c[4].metric("Reunión con buddy el día 1", f"{q6['n8n']:.0f} %", f"{q6['n8n'] - q6['manual']:+.0f} pp")
    g1, g2 = st.columns(2)
    g1.markdown("**Cobertura de acciones por tipo de vínculo (%)**")
    g1.bar_chart(q2.pivot(index="tipo_vinculo", columns="flujo", values="cobertura_pct"), stack=False)
    g2.markdown("**Carga por colaborador (veces como buddy / líder)**")
    g2.bar_chart(res["Q7"].set_index("nombre")[["veces_buddy", "veces_lider"]])

with t2:
    st.subheader("Estado de cada incorporación (derivado, no escrito a mano)")
    d = q("SELECT nombre, cargo, tipo_vinculo, flujo, fecha_ingreso, lider, buddy, acciones_enviadas, "
          "acciones_fallidas, documentos_pendientes, contrato, estado FROM v_estado_onboarding ORDER BY fecha_ingreso DESC")
    st.dataframe(d, use_container_width=True, hide_index=True)
    st.caption("Sin RUT ni contacto de emergencia en pantalla (minimización de datos, Ley 21.719).")

with t3:
    for qid, titulo, sql in consultas():
        with st.expander(f"{qid} · {titulo}"):
            st.code(sql, language="sql")
            st.dataframe(q(sql), use_container_width=True, hide_index=True)
