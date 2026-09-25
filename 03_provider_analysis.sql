-- Denied volume/exposure
SELECT provider_id, COUNT(*) AS denied_claims,
       ROUND(SUM(expected_amount),2) AS denied_expected_amount
FROM healthcare_claims
WHERE claim_status='Denied'
GROUP BY provider_id
ORDER BY denied_claims DESC;

-- Denial rate
SELECT provider_id, COUNT(*) AS total_claims,
       COUNT(*) FILTER (WHERE claim_status='Denied') AS denied_claims,
       ROUND(COUNT(*) FILTER (WHERE claim_status='Denied')*100.0/COUNT(*),2) AS denial_rate
FROM healthcare_claims
GROUP BY provider_id
ORDER BY denial_rate DESC;

-- Rate + financial exposure
SELECT provider_id, COUNT(*) AS total_claims,
       COUNT(*) FILTER (WHERE claim_status='Denied') AS denied_claims,
       ROUND(COUNT(*) FILTER (WHERE claim_status='Denied')*100.0/COUNT(*),2) AS denial_rate,
       ROUND(SUM(expected_amount) FILTER (WHERE claim_status='Denied'),2) AS denied_expected_amount
FROM healthcare_claims
GROUP BY provider_id
ORDER BY denied_expected_amount DESC
LIMIT 10;
