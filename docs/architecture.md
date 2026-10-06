# Architecture — Trading Journal & Analytics (MVP)

## Problem & goals
Costruire un Trading OS modulare, performante e a costo €0 per aspiranti trader funded (Futures NQ/ES). L'obiettivo è fornire feedback matematico oggettivo (MAE/MFE/R-Multiple) per eliminare i leak emotivi (es. FOMO).

## Approaches considered
*   **Analytics:** Abbiamo scelto l'approccio **Server-Side Driven** (PostgreSQL/Supabase). La logica di calcolo risiede nel backend per garantire integrità dei dati e singola fonte di verità.
*   **Data Model:** Abbiamo scelto un modello **Normalizzato** (`trades` + `executions`). Fondamentale per calcolare correttamente MAE, MFE ed efficienza d'ingresso.
*   **Data Provider:** Implementazione di un'interfaccia `MarketDataProvider` per astrarre la fonte dati. Permette di passare da CSV a feed professionali (Massive/Databento) in futuro senza toccare il core engine.

## Recommended approach
Architettura basata su **Next.js (Frontend)** e **Supabase (PostgreSQL Backend)**. L'intera logica di trading (P&L engine, Analytics, Backtest) è astratta dal frontend e gestita a livello di servizio backend, utilizzando le edge functions di Supabase o chiamate API dedicate.

## Key decisions
- **Stack:** Next.js, TypeScript, Tailwind CSS, shadcn/ui.
- **Data model:**
    - `users`: Identità e preferenze.
    - `trading_accounts`: Definizione account (es. Apex, Topstep).
    - `instruments`: Specifiche contratti (NQ, ES, tick value, multiplier).
    - `trades`: Record padre (id, account_id, instrument_id, strategy_id, status).
    - `executions`: Record figli (trade_id, timestamp, side, quantity, price, commission).
- **Boundaries:** API basata su TypeScript con validazione stretta dei dati in entrata (Zod). Separazione netta tra `MarketDataLayer` (astrazione) e `AnalyticsEngine` (logica deterministica).
- **Security:** Autenticazione tramite Supabase Auth (Row Level Security su PostgreSQL).

## Missing pieces
- Implementazione del parser CSV generico (in grado di mappare colonne variabili di diversi broker su standard interno).
- Engine matematico deterministico (P&L, R, MAE, MFE).

## Spikes & experiments
- **Spike 1:** Test del parser CSV per verificare la robustezza della mappatura colonne sui CSV standard di NinjaTrader/Tradovate.
- **Spike 2:** Validazione calcoli MAE/MFE su dataset di test (candele 1m) per confermare l'accuratezza dei calcoli.

## Open questions
- Come gestire il "rollover" dei futures nella V1? (Deciso: ogni contratto è uno strumento indipendente per ora).
- Limiti di calcolo dell'Analytics engine su serie storiche molto lunghe in un'unica query? (Da monitorare).
