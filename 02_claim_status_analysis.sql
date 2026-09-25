SELECT 
    claim_status AS status,
    COUNT(*) AS claims,
    ROUND(SUM(expected_amount), 2) AS total_expected_reimbursement,
    ROUND(SUM(paid_amount), 2) AS total_paid_reimbursement,
    ROUND(SUM(expected_amount) - SUM(paid_amount), 2) AS reimbursement_gap,
    ROUND(SUM(paid_amount) / NULLIF(SUM(expected_amount), 0) * 100, 2) AS payment_rate,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage_of_total_claims
FROM healthcare_claims
GROUP BY claim_status
ORDER BY claims DESC;
