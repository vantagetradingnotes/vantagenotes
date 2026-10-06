# Trading Journal & Analytics (MVP)

## 1. Problem Statement
Aspirant funded traders using standard journaling tools or spreadsheets lack immediate, objective feedback on their performance. They struggle to identify the statistical root causes of their failures—specifically emotional trading (e.g., FOMO) vs. edge validity. The cost of not solving this is repeated failure in prop firm evaluations and continued capital loss.

## 2. Evidence
*   **Assumption (to be validated):** Traders cannot correlate emotional tags with P&L impact in real-time, leading to repeated pattern failures in evaluations.
*   **Observation:** Generic CSV journals exist, but lack the deterministic math engine (MAE/MFE/R-Multiple analysis) required to prove edge validity to the trader.

## 3. Thesis (Why build it)
By building a deterministic math engine specifically for NQ/ES futures that correlates behavioral tags (FOMO, Overtrading) with R-Multiple performance, we can provide traders with objective "mathematical feedback." This beats current spreadsheet-based "cope" by showing traders exactly how much money they lose by deviating from their playbook.

## 4. Hypothesis
*   **We believe** that providing aspirational funded traders with objective statistical feedback on their performance (MAE/MFE/R-Multiple analysis) vs. their emotional tags will cause them to identify and reduce emotional trading patterns, resulting in higher consistency and increased likelihood of passing prop firm evaluations.
*   **We'll know we're RIGHT if:** Users who regularly utilize the Analytics engine show a reduction in variance of their daily Net P&L and an improvement in their Profit Factor over a 30-day period.
*   **We'll know we're WRONG if:** Users stop importing data after one week, or if statistical feedback provided by the AI is ignored systematically without leading to adjustments in trading behavior.

## 5. Target User & JTBD
*   **Primary User:** Aspirant Funded Trader (Futures, NQ/ES).
*   **JTBD:** When I am in a prop firm evaluation, I want to accurately identify my biggest money-leaking patterns, so I can pass the evaluation and get funded.
*   **Non-users:** Crypto/FX traders, casual traders, or those seeking auto-trading bot solutions.

## 6. MVP (Thinnest line)
*   **Data Ingestion:** Generic CSV parser for NQ/ES trades.
*   **Core Engine:** Deterministic math engine (P&L, R-Multiple, MAE, MFE, Win Rate, Profit Factor).
*   **AI (Deterministic):** Statistical engine comparing tagged trades (e.g., FOMO) vs. untagged trades to show P&L impact.
*   **Dashboard:** KPI display + Equity Curve specifically for NQ/ES.

## 7. Success Metrics
*   **Metric:** User Retention (Active daily/weekly imports).
*   **Target:** 60% of users who import data in week 1 return in week 4.
*   **How Measured:** Internal database logs tracking "Last import date" per user.

## 8. Non-goals
*   Crypto or FX market support.
*   Broker API auto-sync (manual CSV only).
*   Level II/Tick-by-tick professional market data (manual OHLC/CSV only).
*   Spaces/Community features.

## 9. Open Questions
*   [ ] Does the generic CSV import handle all major futures platforms (NinjaTrader/Tradovate)? Needs testing.
*   [ ] Is the MAE/MFE calculation reliable based on standard minute-bar CSVs? Needs validation.
