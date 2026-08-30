-- 5.1 Export summary for Tableau
COPY (
  SELECT department, category, priority,
  COUNT(*) as tickets,
  ROUND(AVG(time_to_resolution_hours)::NUMERIC, 2) as avg_hrs,
  ROUND(AVG(satisfaction_rating)::NUMERIC, 2) as avg_satisfaction
  FROM tickets
  GROUP BY department, category, priority
  ORDER BY avg_satisfaction ASC
) TO '/workspaces/it_sla_analysis/exports/dept_summary.csv' CSV HEADER;