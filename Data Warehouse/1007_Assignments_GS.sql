
# @Date : 2013, February 4
# @Author : Sanjiv Upadhyaya
# @Revised by : 


USE census_dw;

DROP TABLE IF EXISTS assignments_gs;

CREATE TABLE assignments_gs
(
assignment_id VARCHAR(500),
gs_id VARCHAR(500),
worker_id VARCHAR(500),
created_at VARCHAR(500),
data  VARCHAR(500), # Replace Data Column by work_duration when normalized table is received or we can use work_duration from census's mongoDB agent table
work_duration VARCHAR(500), # Extracted from agents table of census app's mongoDB. Replace it with work_duration received from workflow 
skill_id VARCHAR(500),
skill_type VARCHAR(500), 
skill_value VARCHAR(500),
skip_count VARCHAR(500),
correct_first_name VARCHAR(500),
entered_first_name VARCHAR(500),
entered_first_name_correct VARCHAR(500),
correct_last_name VARCHAR(500),
entered_last_name VARCHAR(500),
entered_last_name_correct VARCHAR(500),
correct_middle_initials VARCHAR(500),
entered_middle_initials VARCHAR(500),
entered_middle_initials_correct VARCHAR(500),
fields_correct VARCHAR(500),
score FLOAT,
perfect VARCHAR(500)

);

INSERT INTO assignments_gs
(
assignment_id ,
gs_id,
worker_id ,
created_at ,
data, # Replace Data Column by work_duration when normalized table is received or we can use work_duration from census's mongoDB agent table
work_duration , # Extracted from agents table of census app's mongoDB. Replace it with work_duration received from workflow 
skill_id ,
skill_type , 
skill_value ,
correct_first_name,
entered_first_name ,
entered_first_name_correct ,
correct_last_name ,
entered_last_name,
entered_last_name_correct,
correct_middle_initials ,
entered_middle_initials,
entered_middle_initials_correct ,
fields_correct,
score,
perfect
)

SELECT 
a.id,
gsam.gold_standard_id,
a.worker_id,
a.created_at,
df.data, # Replace Data Column by work_duration when normalized table is received or we can use work_duration from census's mongoDB agent table
ag.work_duration, # Extracted from agents table of census app's mongoDB. Replace it with work_duration received from workflow 
s.id,
s.type,
s.value,

NULL AS correct_first_name,

rev.first_name as entered_first_name,
rev.first_name_correct,
NULL AS correct_last_name,
rev.last_name,
rev.last_name_correct,
NULL AS correct_middle_initials,
rev.middle_initials,
rev.middle_initials_correct,
NULL AS fields_correct,
a.score,
a.score=1 as perfect

FROM 
	workflow_prod.assignments a 
	
INNER JOIN 
	workflow_prod.jobs j
ON a.job_id=j.id

INNER JOIN 
	workflow_prod.data_flows df
ON
	a.id=df.assignment_id
	
INNER JOIN 
	agents ag
ON 
	a.id=ag.assignment_id

INNER JOIN 
	workflow_prod.skills s
ON
	a.id=s.assignment_id

INNER JOIN 
	reviews rev
ON
	rev.task_id=ag.task_id
	
INNER JOIN 
	workflow_prod.gold_standard_assignment_maps gsam
ON
	gsam.assignment_id=a.id

WHERE ag.status='Completed';






