# IT Service Analytics

**Business question:** What drives resolution time and low satisfaction — 
and which ticket types need the most process improvement?

## Live Dashboard
[View on Tableau Public](https://public.tableau.com/app/profile/neha.nataraj/viz/ITServiceAnalytics_17881381180580/Dashboard1)

## What makes this project different
Built a Groq Llama (allam-2-7b) classifier that reads ticket descriptions 
and classifies urgency — with 3-gate validation on every output:
1. Valid JSON structure
2. All required fields present  
3. Urgency value is one of four expected options

No AI output is accepted without passing all three gates. Failed outputs 
are flagged for human review, never silently used.

## Key Findings
1. **Critical tickets resolve in 4.26 hrs. Low priority in 87.54 hrs.** 
   A 20x difference — but avg satisfaction is flat at 3.28 across all 
   four priority levels. Speed alone does not drive satisfaction.
2. **Access/Permissions** is the slowest category at 45.4 hrs avg 
   resolution — nearly 2x faster than Security (27.2 hrs avg)
3. **Email/Communication** has the lowest satisfaction at 3.22 avg 
   with only 30.2% of users satisfied
4. **Human Resources** has the highest dissatisfaction rate at 22.8% 
   despite not being the slowest department (38.97 hrs avg)
5. **Cisco AnyConnect** has the lowest product satisfaction at 3.15 — 
   VPN issues are the most frustrating ticket type
6. **Zoom** generates the most tickets (239) and has the slowest 
   resolution at 46.80 hrs — highest volume + highest wait time

## Recommendations
- Prioritise process improvement for Access/Permissions tickets — 
  slowest category by 13+ hours vs the company average of 40.13 hrs
- Investigate what drives dissatisfaction in Email/Communication — 
  resolution speed is average but satisfaction is the lowest category
- Audit HR department's ticket handling — highest dissatisfaction rate 
  (22.8%) signals a process or communication gap, not just a speed issue
- Review Cisco AnyConnect support playbook — lowest satisfaction score 
  of any product, suggests resolution quality is the issue

## AI Classification Results
- **200 tickets** classified using Groq API (allam-2-7b model)
- **3-gate validation** on every output — JSON structure, required 
  fields, valid urgency values
- AI correctly identified Critical tickets as urgent with relevant 
  context (e.g. "Dangerous USB or infected file", "Locked out due to 
  cached password")
- Disagreements between AI and human priority surface potentially 
  mis-prioritised tickets for review

## Stack
- **PostgreSQL** — SQL analysis (GROUP BY, PERCENTILE_CONT, CASE WHEN, 
  window functions with RANK() OVER PARTITION BY)
- **Python** (pandas, matplotlib, seaborn) — EDA, box plots, heatmap, 
  scatter plots, CSV exports
- **Groq API** (allam-2-7b) — ticket urgency classification with 
  3-gate output validation
- **Tableau Public** — resolution time and satisfaction dashboard

## SQL Concepts Used
- `PERCENTILE_CONT(0.5)` — median vs average for resolution times
- `RANK() OVER (PARTITION BY priority ORDER BY ...)` — slowest category 
  per priority level simultaneously
- `CASE WHEN` — custom priority sort order and complexity banding
- `::NUMERIC` casting — handling PostgreSQL type requirements for ROUND
- `UPDATE ... SET ... WHERE` — cleaning NaN values from satisfaction column

