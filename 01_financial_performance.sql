SELECT 
    ROUND(SUM(expected_amount), 2) AS total_expected_reimbursement,
    ROUND(SUM(paid_amount), 2) AS total_paid_reimbursement,
    ROUND(SUM(expected_amount) - SUM(paid_amount), 2) AS reimbursement_gap,
    ROUND(SUM(paid_amount) / NULLIF(SUM(expected_amount), 0) * 100, 2) AS overall_payment_rate
FROM healthcare_claims;
