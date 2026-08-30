-- 1.1 Headline KPIs
SELECT
  COUNT(*) AS total_tickets,
  COUNT(CASE WHEN status IN ('Resolved','Closed') THEN 1 END) AS resolved_tickets,
  ROUND(AVG(time_to_resolution_hours), 2) AS avg_resolution_hrs,
  ROUND(AVG(satisfaction_rating), 2) AS avg_satisfaction,
  ROUND(MIN(time_to_resolution_hours), 2) AS fastest_hrs,
  ROUND(MAX(time_to_resolution_hours), 2) AS slowest_hrs
FROM tickets;

-- 1.2 Ticket volume by category
SELECT
  category,
  COUNT(*) AS total_tickets,
  ROUND(AVG(time_to_resolution_hours), 2) AS avg_resolution_hrs,
  ROUND(AVG(satisfaction_rating), 2) AS avg_satisfaction
FROM tickets
GROUP BY category
ORDER BY avg_resolution_hrs DESC;