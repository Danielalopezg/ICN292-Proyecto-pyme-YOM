"""
Crea db/yom.db desde cero (schema.sql + seed.sql) y ejecuta todas las consultas de db/queries.sql,
imprimiendo cada resultado. Es la forma de comprobar que los resultados del informe son reproducibles.

Uso:  python scripts/correr_consultas.py
"""
import re
import sqlite3
from pathlib import Path

import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
DB = ROOT / "db" / "yom.db"


def crear_bd() -> sqlite3.Connection:
    if DB.exists():
        DB.unlink()
    con = sqlite3.connect(DB)
    con.execute("PRAGMA foreign_keys = ON")
    con.executescript((ROOT / "db" / "schema.sql").read_text(encoding="utf-8"))
    con.executescript((ROOT / "db" / "seed.sql").read_text(encoding="utf-8"))
    return con


def consultas():
    texto = (ROOT / "db" / "queries.sql").read_text(encoding="utf-8")
    bloques = re.split(r"\n(?=-- Q\d)", texto)
    for b in bloques:
        m = re.match(r"-- (Q\d+) · (.*)", b)
        if not m:
            continue
        sql = "\n".join(l for l in b.splitlines() if not l.strip().startswith("--")).strip().rstrip(";")
        yield m.group(1), m.group(2), sql


if __name__ == "__main__":
    con = crear_bd()
    pd.set_option("display.width", 200)
    for qid, titulo, sql in consultas():
        print(f"\n=== {qid} · {titulo}")
        print(pd.read_sql(sql, con).to_string(index=False))
