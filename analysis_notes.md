# Analysis Notes — Healthcare Claims Payment & Revenue Cycle Analytics

## Q1 — Overall reimbursement
Expected: **$127,483,848.54** | Paid: **$86,762,820.42** | Gap: **$40,721,028.12** | Payment rate: **68.06%**.

The gap is an investigation area, not automatically lost revenue.

## Q2 — Claim status
Paid: 34,978 claims, $89.26M expected, $75.91M paid, 85.05% payment rate.
Pending: 4,995 claims, $12.78M expected, $10.85M paid, 84.95% payment rate.
Denied: 10,027 claims, $25.45M expected, $0 paid, 0% payment rate.

Denied claims are 20.05% of claims and approximately 62.5% of the total reimbursement gap.

## Q3 — Provider denial analysis
Provider 438 had a 29.41% denial rate in the analyzed output. Provider 413 had 54 denied claims and a 29.35% denial rate. Provider 353 had the highest denied expected exposure in the top-10 exposure output: $142,826.88.

Claim count, denial rate, and financial exposure are different dimensions.

## Q4 — Procedure analysis
Denial rates were:
- PROC_A: 20.12%
- PROC_B: 20.16%
- PROC_C: 19.88%
- PROC_D: 20.05%

Procedure-only analysis did not show one procedure overwhelmingly dominating denial rate.

After applying a project-level minimum of 50 claims to provider-procedure combinations, examples included Provider 456 + PROC_B at 34.62% and Provider 413 + PROC_B at 34.55%. Small groups can produce unstable rates.

## Q5 — Payment turnaround
Average: **80.62 days**
Median: **28 days**
Maximum observed: **397 days**

The large average-versus-median difference indicates a long right tail.

By status:
- Denied: 80.69 average, 28 median, 396 maximum
- Paid: 80.74 average, 28 median, 397 maximum
- Pending: 79.69 average, 28 median, 379 maximum

Turnaround was remarkably similar across statuses, so status alone does not explain the long-delay tail.

## Limitations
The dataset does not include payer, denial reason, diagnosis, authorization, documentation, resubmission, appeal, or detailed workflow timestamps. The analysis therefore identifies patterns and investigation areas rather than proving causes.
