-- 3.1 Satisfaction by category
SELECT
  category,
  COUNT(*) AS tickets,
  ROUND(AVG(satisfaction_rating)::NUMERIC, 2) AS avg_satisfaction,
  COUNT(CASE WHEN satisfaction_rating >= 4 THEN 1 END) AS satisfied,
  COUNT(CASE WHEN satisfaction_rating <= 2 THEN 1 END) AS dissatisfied,
  ROUND(100.0 *
    COUNT(CASE WHEN satisfaction_rating >= 4 THEN 1 END)
    / COUNT(*), 1) AS pct_satisfied
FROM tickets
GROUP BY category
ORDER BY avg_satisfaction ASC;

-- 3.2 Ticket complexity vs satisfaction
SELECT
  CASE
    WHEN text_length < 100 THEN 'Short (under 100)'
    WHEN text_length < 300 THEN 'Medium (100-300)'
    WHEN text_length < 600 THEN 'Long (300-600)'
    ELSE 'Very long (600+)'
  END AS complexity_band,
  COUNT(*) AS tickets,
  ROUND(AVG(time_to_resolution_hours)::NUMERIC, 2) AS avg_resolution_hrs,
  ROUND(AVG(satisfaction_rating)::NUMERIC, 2) AS avg_satisfaction
FROM tickets
GROUP BY complexity_band
ORDER BY MIN(text_length);