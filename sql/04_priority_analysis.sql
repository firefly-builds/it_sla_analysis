-- 4.1 Top products by ticket volume
SELECT
  product_service,
  COUNT(*) AS tickets,
  ROUND(AVG(time_to_resolution_hours)::NUMERIC, 2) AS avg_resolution_hrs,
  ROUND(AVG(satisfaction_rating)::NUMERIC, 2) AS avg_satisfaction,
  COUNT(CASE WHEN priority = 'Critical' THEN 1 END) AS critical_count
FROM tickets
GROUP BY product_service
ORDER BY tickets DESC
LIMIT 10;

-- 4.2 Slowest category per priority (window function)
SELECT
  category, priority,
  ROUND(AVG(time_to_resolution_hours)::NUMERIC, 2) AS avg_hrs,
  ROUND(AVG(satisfaction_rating)::NUMERIC, 2) AS avg_sat,
  COUNT(*) AS tickets,
  RANK() OVER (
    PARTITION BY priority
    ORDER BY AVG(time_to_resolution_hours) DESC
  ) AS slowest_rank_in_priority
FROM tickets
GROUP BY category, priority
ORDER BY priority, slowest_rank_in_priority;