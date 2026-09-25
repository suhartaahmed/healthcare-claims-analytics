-- Prepared follow-up queries. Execute before adding their findings to README.

-- Payment-delay buckets
SELECT CASE
         WHEN payment_date-claim_date <= 30 THEN '0-30 days'
         WHEN payment_date-claim_date <= 60 THEN '31-60 days'
         WHEN payment_date-claim_date <= 90 THEN '61-90 days'
         WHEN payment_date-claim_date <= 180 THEN '91-180 days'
         WHEN payment_date-claim_date <= 365 THEN '181-365 days'
         ELSE '366+ days'
       END AS payment_delay_bucket,
       COUNT(*) AS total_claims,
       ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER (),2) AS percentage_of_claims
FROM healthcare_claims
GROUP BY payment_delay_bucket
ORDER BY MIN(payment_date-claim_date);

-- Provider performance scorecard
SELECT provider_id, COUNT(*) AS total_claims,
       COUNT(*) FILTER (WHERE claim_status='Denied') AS denied_claims,
       COUNT(*) FILTER (WHERE claim_status='Pending') AS pending_claims,
       ROUND(COUNT(*) FILTER (WHERE claim_status='Denied')*100.0/COUNT(*),2) AS denial_rate,
       ROUND(COUNT(*) FILTER (WHERE claim_status='Pending')*100.0/COUNT(*),2) AS pending_rate,
       ROUND(SUM(expected_amount),2) AS total_expected,
       ROUND(SUM(paid_amount),2) AS total_paid,
       ROUND(SUM(expected_amount)-SUM(paid_amount),2) AS reimbursement_gap,
       ROUND(SUM(paid_amount)*100.0/NULLIF(SUM(expected_amount),0),2) AS payment_rate
FROM healthcare_claims
GROUP BY provider_id
ORDER BY reimbursement_gap DESC
LIMIT 20;

-- Procedure performance
SELECT procedure_code, COUNT(*) AS total_claims,
       COUNT(*) FILTER (WHERE claim_status='Denied') AS denied_claims,
       COUNT(*) FILTER (WHERE claim_status='Pending') AS pending_claims,
       ROUND(COUNT(*) FILTER (WHERE claim_status='Denied')*100.0/COUNT(*),2) AS denial_rate,
       ROUND(COUNT(*) FILTER (WHERE claim_status='Pending')*100.0/COUNT(*),2) AS pending_rate,
       ROUND(SUM(expected_amount),2) AS total_expected,
       ROUND(SUM(paid_amount),2) AS total_paid,
       ROUND(SUM(expected_amount)-SUM(paid_amount),2) AS reimbursement_gap,
       ROUND(SUM(paid_amount)*100.0/NULLIF(SUM(expected_amount),0),2) AS payment_rate
FROM healthcare_claims
GROUP BY procedure_code
ORDER BY reimbursement_gap DESC;

-- Data quality
SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT claim_id) AS unique_claim_ids,
       COUNT(*)-COUNT(DISTINCT claim_id) AS duplicate_claim_ids,
       COUNT(*) FILTER (WHERE claim_id IS NULL) AS null_claim_ids,
       COUNT(*) FILTER (WHERE patient_id IS NULL) AS null_patient_ids,
       COUNT(*) FILTER (WHERE provider_id IS NULL) AS null_provider_ids,
       COUNT(*) FILTER (WHERE procedure_code IS NULL) AS null_procedure_codes,
       COUNT(*) FILTER (WHERE claim_date IS NULL) AS null_claim_dates,
       COUNT(*) FILTER (WHERE payment_date IS NULL) AS null_payment_dates,
       COUNT(*) FILTER (WHERE expected_amount IS NULL) AS null_expected_amounts,
       COUNT(*) FILTER (WHERE paid_amount IS NULL) AS null_paid_amounts,
       COUNT(*) FILTER (WHERE claim_status IS NULL) AS null_statuses,
       COUNT(*) FILTER (WHERE expected_amount < 0) AS negative_expected_amounts,
       COUNT(*) FILTER (WHERE paid_amount < 0) AS negative_paid_amounts,
       COUNT(*) FILTER (WHERE paid_amount > expected_amount) AS paid_greater_than_expected
FROM healthcare_claims;

-- Claims over 180 days
SELECT COUNT(*) AS claims_over_180_days,
       ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM healthcare_claims),2) AS percentage_over_180_days,
       ROUND(SUM(expected_amount),2) AS expected_amount_over_180_days,
       ROUND(SUM(paid_amount),2) AS paid_amount_over_180_days
FROM healthcare_claims
WHERE payment_date-claim_date > 180;
