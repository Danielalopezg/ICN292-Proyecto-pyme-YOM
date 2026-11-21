# Automatización n8n

| Archivo | Contenido |
|---|---|
| `onboarding_yom.json` | Flujo exportado desde n8n, con identificadores internos de YOM reemplazados por marcadores (`scripts/sanitizar_n8n.py`). El export original no se publica. |
| `canvas.jpeg` | Captura del flujo completo en el editor de n8n (los quince nodos). |

**Para importarlo:** n8n → *Workflows* → *Import from File* → asociar credenciales propias de Google Sheets,
Gmail, Slack y Google Calendar → reemplazar los marcadores `ID_…` por los de la cuenta propia.
Documentación nodo por nodo: [`docs/05-automatizacion-n8n.md`](../docs/05-automatizacion-n8n.md).
