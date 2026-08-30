-- 2.1 Resolution time by priority with median
SELECT
  priority,
  COUNT(*) AS tickets,
  ROUND(AVG(time_to_resolution_hours), 2) AS avg_hrs,
  ROUND(MIN(time_to_resolution_hours), 2) AS fastest_hrs,
  ROUND(MAX(time_to_resolution_hours), 2) AS slowest_hrs,
  ROUND(PERCENTILE_CONT(0.5)
    WITHIN GROUP (ORDER BY time_to_resolution_hours), 2) AS median_hrs
FROM tickets
GROUP BY priority
ORDER BY CASE priority
  WHEN 'Critical' THEN 1
  WHEN 'High' THEN 2
  WHEN 'Medium' THEN 3
  ELSE 4
END;

-- 2.2 Department performance
SELECT
  department,
  COUNT(*) AS tickets,
  ROUND(AVG(time_to_resolution_hours), 2) AS avg_resolution_hrs,
  ROUND(AVG(satisfaction_rating), 2) AS avg_satisfaction,
  COUNT(CASE WHEN satisfaction_rating <= 2 THEN 1 END) AS low_sat_count,
  ROUND(100.0 *
    COUNT(CASE WHEN satisfaction_rating <= 2 THEN 1 END)
    / COUNT(*), 1) AS pct_dissatisfied
FROM tickets
GROUP BY department
ORDER BY avg_resolution_hrs DESC;