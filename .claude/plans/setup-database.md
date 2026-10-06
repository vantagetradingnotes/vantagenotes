# Feature: Setup Database

## Feature Description
Creazione dello schema PostgreSQL in Supabase per il Trading Journal & Analytics, basato sul modello normalizzato definito in `architecture.md`.

## User Story
As a trader
I want to store my trades and executions in a structured database
So that I can analyze my performance mathematically

## Problem Statement
Nessuno schema database esistente. Dobbiamo creare le tabelle `users`, `trading_accounts`, `instruments`, `trades`, e `executions` con le relazioni appropriate.

## Solution Statement
Creare lo schema PostgreSQL in Supabase utilizzando il file `db/schema.sql`.

## Out of Scope / Non-Goals
- Non includiamo l'autenticazione (Supabase Auth) in questo ticket.
- Non includiamo l'importazione dei dati (CSV) in questo ticket.

## Feature Metadata
**Feature Type**: New Capability
**Estimated Complexity**: Low
**Primary Systems Affected**: Database
**Dependencies**: Supabase PostgreSQL

## Related Work
**Implements**: TICKET-1

---

## CONTEXT REFERENCES

### Relevant Codebase Files
- `architecture.md`
- `db/schema_v1.sql`

### New Files to Create
- `db/schema.sql` (link/copy of schema_v1.sql)

### Patterns to Follow
- PostgreSQL conventions
- Relational mapping with ON DELETE CASCADE

---

## IMPLEMENTATION PLAN

### Phase 1: Foundation
- **VALIDATE**: Audit del DB remoto eseguito con successo.

### Phase 2: Implementation
- **CREATE/UPDATE**: Ensure `db/schema.sql` contains the definitive schema.

### Phase 3: Testing & Validation
- **VALIDATE**: Verify tables via `psql`.

---

## STEP-BY-STEP TASKS

### Task 1: Create definitive schema file
- **CREATE** `db/schema.sql`
- **IMPLEMENT**: Copy `db/schema_v1.sql` content to `db/schema.sql`.
- **VALIDATE**: `ls db/schema.sql`
- **SATISFIES**: AC #1

### Task 2: Final Verification
- **VALIDATE**: Ensure tables exist in remote DB.
- **SATISFIES**: AC #2, AC #3, AC #4
