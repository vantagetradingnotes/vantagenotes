# Trading Journal MVP PRD

## 1. Problem Statement
Traders currently rely on incomplete, manual methods (e.g., spreadsheets, paper) to track activity because professional-grade analytical tools (e.g., TradeZella) are too expensive. This cost barrier leads to fragmented data, missed insights, and a reduced capacity for performance improvement.

## 2. Evidence
*   **Assumption** — Validate via survey/interview: Traders abandon expensive tools when costs outweigh perceived immediate value.
*   **Assumption** — Validate via user feedback: Traders desire professional analytics and AI-driven coaching but are unwilling to pay recurring monthly subscriptions for them.

## 3. Thesis
An affordable, automated trading journal platform that bridges the gap between manual spreadsheets and paid professional tools will empower budget-conscious traders to improve by providing accessible, actionable analytics and AI-driven coaching.

## 4. Hypothesis
We believe that providing a free, automated trading journal with visual trade mapping and AI performance coaching will cause budget-conscious traders to switch from manual tracking, resulting in consistent logging and actionable performance review.

*   **We'll know we're RIGHT if:** At least 100 users log trades consistently for 30 days.
*   **We'll know we're WRONG if:** Users abandon the tool within the first 3 days because the manual import/setup process is too complex or time-consuming.

## 5. Target User & JTBD
*   **Primary User:** Budget-conscious, intermediate traders who are disciplined about tracking but limited by cost.
*   **JTBD:** "When I finish my trading day, I want to log my trade context, stats, and feelings in one place, so I can review my performance and get actionable coaching without paying a monthly subscription."
*   **Non-users:** High-frequency, institutional traders requiring millisecond-latency data or automated execution integration.

## 6. MVP
The thinnest slice that proves the hypothesis end-to-end:
1.  **Brokerage CSV Import:** Flexible entry point for historical trade data.
2.  **The Journal:** CRUD for trade details, including fields for feelings, trade setup, and mistakes.
3.  **Core Performance Dashboard:** Automated calculation of Win/Loss Ratio, Net PnL, and Average Trade.
4.  **Visual Trade Mapping:** Static graph overlay showing entries/exits/stop-losses.
5.  **AI Performance Coach:** Behavioral analysis (pattern detection in logs) and statistical coaching (data-driven advice based on user history).

## 7. Success Metrics
*   **Consistency:** % of users with >10 trades logged in the first 30 days.
*   **Retention:** 30-day user retention rate.
*   **Engagement:** Average number of AI coaching insights reviewed/acted upon per user per week.

## 8. Non-goals
*   Real-time market data streaming.
*   Automated tax report generation.
*   Social sharing features.
*   Predictive AI market forecasting (focus is on *behavioral coaching*, not *market prediction*).

## 9. Open Questions
*   [ ] How will we handle the variance in CSV formats across major brokerages without manual mapping?
*   [ ] What is the most effective way to validate trade visualization accuracy post-import?
*   [ ] How do we ensure data privacy for sensitive trade logs without using centralized cloud storage initially?
*   [ ] What is the optimal frequency/trigger for the AI Performance Coach to provide feedback?
