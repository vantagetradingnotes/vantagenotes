# Architecture — Trading Journal MVP

## Problem & goals
Create an affordable, automated trading journal platform that bridges the gap between manual spreadsheets and paid professional tools. The goal is to empower budget-conscious traders with accessible analytics and AI-driven coaching, without the recurring monthly cost of existing market solutions.

## Approaches considered
1.  **Next.js/Supabase:** Fast, integrated, but higher scaling costs later.
2.  **Python/FastAPI/React (Recommended):** Strong data-science ecosystem for AI/analysis evolution, clean separation of concerns, manageable cost.
3.  **Lean Monolith:** Simplest infra, but harder to evolve the AI/analysis capabilities over time.

**Recommendation:** We are proceeding with **Option 2 (Python/FastAPI/React)** because it maximizes our ability to build custom statistical analysis and AI-driven insights, which are the core differentiators of the tool.

## Recommended approach
A decoupled architecture using a **FastAPI backend** for data processing and AI logic, and a **React frontend** for the dashboard and user experience. **PostgreSQL** will handle data storage, accessed through **SQLAlchemy (ORM)** for robust and maintainable data modeling.

## Key decisions
- **Stack & libraries:**
    - **Backend:** FastAPI (Python) for high performance and native data-science/AI integration.
    - **Frontend:** React (SPA) for a responsive, interactive dashboard.
    - **Database:** PostgreSQL for robust data integrity.
    - **ORM:** SQLAlchemy for efficient, type-safe data interactions.
- **Data model:**
    - `User`: Auth, settings, preferences.
    - `Trade`: Core entity (ID, Date, Asset, Entry/Exit Price, PnL, etc.).
    - `TradeContext`: Feelings, notes, mistakes, linked to `Trade`.
    - `TradeAnalysis`: AI-generated feedback and pattern flags, linked to `Trade`.
    - `Statistics`: Computed daily/weekly summaries for dashboards.
- **Boundaries & contracts:**
    - **Auth:** JWT-based auth (FastAPI Users).
    - **CSV Parser:** Abstracted service layer to handle varied brokerage exports.
    - **AI Service:** Layered AI service (OpenAI integration) hidden behind a clean interface to allow for future model swaps.

## Missing pieces
- A robust, configurable CSV mapping system to handle brokerage variance.
- AI prompt engineering workflows specifically tuned for behavioral and performance coaching.

## Spikes & experiments
- **CSV Ingestion Spike:** Build a parser to map data from two different brokerage formats into our internal `Trade` object.
    - **Decision rule:** If parsing takes > 1 hour per broker, switch to a UI-based mapper instead of hardcoded parsers.

## Open questions
- How to ensure data privacy if we keep logs centralized (cloud storage vs. local).
- Optimal trigger frequency for AI feedback to avoid "AI fatigue" for the user.
- Handling data synchronization if users use multiple brokerages.
