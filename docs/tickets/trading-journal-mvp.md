# Ticket Breakdown — Trading Journal MVP

## Epic summary
Build a free, automated trading journal and AI performance coach.
Core value: Bridge the gap between manual spreadsheets and paid professional tools by automating data ingestion, visualizing trade performance, and providing actionable behavioral/statistical AI coaching.

## Tickets

### TICKET-1 — Project Setup and Authentication
- **Scope:** Initialize FastAPI (backend) and React (frontend) skeleton. Configure PostgreSQL/SQLAlchemy. Implement JWT-based auth via FastAPI Users.
- **Per-ticket context:** Reference `architecture.md` for tech stack choices.
- **Files touched:** Backend/Frontend root directories, `docker-compose.yml` (optional), Auth middleware/models.
- **Size:** ~600 lines
- **Depends on:** None

### TICKET-2 — Data Model Foundation
- **Scope:** Define SQLAlchemy models for `User`, `Trade`, and `TradeContext`.
- **Per-ticket context:** `architecture.md` (Data Model section).
- **Files touched:** `backend/models/*.py`
- **Size:** ~400 lines
- **Depends on:** TICKET-1

### TICKET-3 — Brokerage CSV Ingestion Service
- **Scope:** Build the CSV parsing service (the SPIKE from architecture). Handle 2 brokerage formats mapping to internal `Trade` model.
- **Per-ticket context:** `architecture.md` (Spikes/CSV Parser contract).
- **Files touched:** `backend/services/csv_parser.py`, `backend/api/endpoints/ingestion.py`
- **Size:** ~700 lines
- **Depends on:** TICKET-2

### TICKET-4 — Journal API and Frontend Table
- **Scope:** CRUD API endpoints for Trades/Context. React frontend table view to display, add, edit, delete trade logs.
- **Per-ticket context:** PRD (The Journal section).
- **Files touched:** `backend/api/endpoints/trades.py`, `frontend/src/components/JournalTable.jsx`
- **Size:** ~1000 lines
- **Depends on:** TICKET-2

### TICKET-5 — Performance Dashboard and Visual Mapping
- **Scope:** Backend metrics calculation endpoints (PnL, WinRate). Frontend dashboard UI with Chart.js mapping trade points (Entry/Exit).
- **Per-ticket context:** PRD (Core Performance Dashboard / Visual Trade Mapping).
- **Files touched:** `backend/services/analytics.py`, `frontend/src/components/Dashboard.jsx`
- **Size:** ~900 lines
- **Depends on:** TICKET-4

### TICKET-6 — AI Performance Coach
- **Scope:** Integrate OpenAI API. Build service layer for behavioral and statistical analysis based on `Trade` data.
- **Per-ticket context:** PRD (AI Performance Coach).
- **Files touched:** `backend/services/ai_coach.py`, `backend/api/endpoints/coaching.py`
- **Size:** ~800 lines
- **Depends on:** TICKET-4

## Dependency graph
TICKET-1 (Root) -> TICKET-2
TICKET-2 -> TICKET-3, TICKET-4
TICKET-4 -> TICKET-5, TICKET-6

## Suggested execution order
Wave 1: TICKET-1
Wave 2: TICKET-2
Wave 3: TICKET-3, TICKET-4
Wave 4: TICKET-5, TICKET-6
