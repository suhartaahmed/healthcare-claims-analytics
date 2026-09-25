SELECT procedure_code,
       COUNT(*) AS total_claims,
       COUNT(*) FILTER (WHERE claim_status='Denied') AS denied_claims,
       ROUND(COUNT(*) FILTER (WHERE claim_status='Denied')*100.0/COUNT(*),2) AS denial_rate,
       ROUND(SUM(expected_amount) FILTER (WHERE claim_status='Denied'),2) AS denied_expected_amount
FROM healthcare_claims
GROUP BY procedure_code;

-- Provider-procedure combinations with a 50-claim minimum
SELECT provider_id, procedure_code, COUNT(*) AS total_claims,
       COUNT(*) FILTER (WHERE claim_status='Denied') AS denied_claims,
       ROUND(COUNT(*) FILTER (WHERE claim_status='Denied')*100.0/COUNT(*),2) AS denial_rate,
       ROUND(SUM(expected_amount) FILTER (WHERE claim_status='Denied'),2) AS denied_expected_amount
FROM healthcare_claims
GROUP BY provider_id, procedure_code
HAVING COUNT(*) >= 50
ORDER BY denial_rate DESC
LIMIT 20;
