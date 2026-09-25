# Healthcare Claims Payment & Revenue Cycle Analytics

## Overview
Analysis of 50,000 healthcare claims using PostgreSQL/SQL to evaluate reimbursement performance, claim outcomes, provider/procedure patterns, payment turnaround, and data quality.

## Business Problem
Management wants to understand expected vs. paid reimbursement, where the gap is concentrated, denial patterns, payment delays, and data-quality risks.

## Dataset
50,000 claims with: `claim_id`, `patient_id`, `provider_id`, `procedure_code`, `claim_date`, `payment_date`, `expected_amount`, `paid_amount`, `claim_status`.

The raw patient-level dataset is intentionally excluded from this public repository. See `data/README.md`.

## Tools
PostgreSQL | SQL | Python/Pandas | Power BI | GitHub

## Key Findings
- Expected reimbursement: **$127.48M**
- Paid reimbursement: **$86.76M**
- Reimbursement gap: **$40.72M**
- Overall payment rate: **68.06%**
- Denied claims: **10,027 (20.05%)**
- Denied expected reimbursement: **$25.45M**
- Denied claims represent approximately **62.5% of the total reimbursement gap**
- Average payment turnaround: **80.62 days**
- Median payment turnaround: **28 days**
- Maximum observed turnaround: **397 days**
- Average turnaround by status was very similar: Denied 80.69, Paid 80.74, Pending 79.69 days.
- Procedure denial rates were close, approximately **19.88%–20.16%**.

## Business Interpretation
The reimbursement gap is an investigation area, not automatically "lost revenue." It can reflect denials, pending claims, partial reimbursement, timing, and other factors.

The average payment turnaround being much higher than the median indicates a long right tail with some substantially delayed claims.

## Limitations
The dataset does not contain payer, denial reason, diagnosis, authorization, documentation, resubmission, appeal, or detailed workflow timestamps. Therefore, this project identifies patterns and investigation areas rather than proving causal explanations.

## Repository Structure
```text
healthcare-claims-analytics/
├── README.md
├── LINKEDIN_PROJECT.md
├── .gitignore
├── data/README.md
├── sql/
│   ├── 01_financial_performance.sql
│   ├── 02_claim_status_analysis.sql
│   ├── 03_provider_analysis.sql
│   ├── 04_procedure_analysis.sql
│   ├── 05_payment_timing.sql
│   └── 06_additional_investigations.sql
├── insights/analysis_notes.md
├── python/README.md
└── powerbi/README.md
```

## Author
Suharta Ahmed
