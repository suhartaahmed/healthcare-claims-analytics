-- Payment days
SELECT claim_id, claim_date, payment_date,
       payment_date - claim_date AS payment_days
FROM healthcare_claims;

-- Average and median
SELECT ROUND(AVG(payment_date-claim_date),2) AS average_payment_days,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY payment_date-claim_date) AS median_payment_days
FROM healthcare_claims;

-- Longest delays
SELECT claim_id, provider_id, procedure_code, claim_status,
       claim_date, payment_date, payment_date-claim_date AS payment_days
FROM healthcare_claims
ORDER BY payment_days DESC
LIMIT 20;

-- By status
SELECT claim_status, COUNT(*) AS total_claims,
       ROUND(AVG(payment_date-claim_date),2) AS avg_payment_days,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY payment_date-claim_date) AS median_payment_days,
       MAX(payment_date-claim_date) AS max_payment_days
FROM healthcare_claims
GROUP BY claim_status
ORDER BY claim_status;
