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
Creare lo schema PostgreSQL in Supabase utilizzando il file `db/schema.sql` generato in base al modello normalizzato.

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
**Epic**: trading-journal-mvp.md

---

## CONTEXT REFERENCES

### Relevant Codebase Files
- `architecture.md` (lines 1-50) - Why: Definisce il modello dati normalizzato
- `db/schema.sql` - Why: Contiene lo schema da implementare

### New Files to Create
- `db/schema.sql` - Schema PostgreSQL

### Relevant Documentation
- [Supabase PostgreSQL Docs](https://supabase.com/docs/guides/database/postgresql)
  - Specific section: Table creation
  - Why: Guida alla creazione di tabelle in PostgreSQL

### Patterns to Follow
**Naming Conventions**:
- Tabelle in minuscolo, singolare (es. `users`)
- Relazioni con `ON DELETE CASCADE`

**Error Handling**:
- Utilizzare `CHECK` constraints per valori validi (es. `side IN ('buy', 'sell')`)

**Logging Pattern**:
- Non applicabile per lo schema database

---

## IMPLEMENTATION PLAN

### Phase 1: Foundation

**Tasks:**

- **CREATE** `db/schema.sql`
  - **IMPLEMENT**: Creare lo schema PostgreSQL basato su `architecture.md`
  - **PATTERN**: `architecture.md` (lines 1-50)
  - **VALIDATE**: `SELECT * FROM information_schema.tables WHERE table_schema = 'public'`
  - **SATISFIES**: Schema creato correttamente

### Phase 2: Core Implementation

**Tasks:**

- **EXECUTE** `schema.sql` in Supabase
  - **IMPLEMENT**: Eseguire lo schema in PostgreSQL di Supabase
  - **PATTERN**: [Supabase PostgreSQL Docs](https://supabase.com/docs/guides/database/postgresql)
  - **VALIDATE**: `SELECT * FROM users LIMIT 1`
  - **SATISFIES**: Tabella `users` creata correttamente

### Phase 3: Testing & Validation

**Tasks:**

- **INSERT** record di test
  - **IMPLEMENT**: Inserire un record di test in ogni tabella
  - **VALIDATE**: `SELECT * FROM trades LIMIT 1`
  - **SATISFIES**: Dati inseriti correttamente

---

## STEP-BY-STEP TASKS

### Task 1: CREATE db/schema.sql

- **CREATE** `db/schema.sql`
  - **IMPLEMENT**: Creare lo schema PostgreSQL basato su `architecture.md`
  - **PATTERN**: `architecture.md` (lines 1-50)
  - **VALIDATE**: `SELECT * FROM information_schema.tables WHERE table_schema = 'public'`
  - **SATISFIES**: Schema creato correttamente

### Task 2: EXECUTE schema.sql in Supabase

- **EXECUTE** `schema.sql` in Supabase
  - **IMPLEMENT**: Eseguire lo schema in PostgreSQL di Supabase
  - **PATTERN**: [Supabase PostgreSQL Docs](https://supabase.com/docs/guides/database/postgresql)
  - **VALIDATE**: `SELECT * FROM users LIMIT 1`
  - **SATISFIES**: Tabella `users` creata correttamente

### Task 3: INSERT record di test

- **INSERT** record di test
  - **IMPLEMENT**: Inserire un record di test in ogni tabella
  - **VALIDATE**: `SELECT * FROM trades LIMIT 1`
  - **SATISFIES**: Dati inseriti correttamente

---

## TESTING STRATEGY

### Unit Tests

- Verificare che ogni tabella sia stata creata correttamente
- Verificare che le relazioni tra tabelle siano valide

### Integration Tests

- Verificare che i dati possano essere inseriti e recuperati correttamente

### Edge Cases

- Verificare che i CHECK constraints funzionino correttamente

---

## VALIDATION COMMANDS

### Level 1: Syntax & Style

- `psql -f db/schema.sql` (eseguire in Supabase)

### Level 2: Unit Tests

- `SELECT * FROM users LIMIT 1`
- `SELECT * FROM trading_accounts LIMIT 1`
- `SELECT * FROM instruments LIMIT 1`
- `SELECT * FROM trades LIMIT 1`
- `SELECT * FROM executions LIMIT 1`

### Level 3: Integration Tests

- Inserire un record di test in ogni tabella e verificare che sia recuperabile

### Level 4: Manual Validation

- Verificare che le tabelle siano visibili in Supabase Dashboard

---

## ACCEPTANCE CRITERIA

- [ ] Schema creato correttamente
- [ ] Tabella `users` creata correttamente
- [ ] Dati inseriti correttamente
- [ ] CHECK constraints funzionano correttamente

---

## COMPLETION CHECKLIST

- [ ] Schema creato correttamente
- [ ] Tabella `users` creata correttamente
- [ ] Dati inseriti correttamente
- [ ] CHECK constraints funzionano correttamente

---

## OPEN QUESTIONS / ASSUMPTIONS

- Assumed — Supabase Auth è configurato separatamente (confirm before execution)

## NOTES

- Lo schema è basato sul modello normalizzato definito in `architecture.md`
- Le tabelle sono create con relazioni appropriate
- I CHECK constraints garantiscono la validità dei dati

## AMENDMENTS

- <ISO date> — <what changed and why, e.g. "scope cut: deferred bulk-import to a follow-up ticket after AC review">
