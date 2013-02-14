
USE census_dw;

 DROP TABLE IF EXISTS assignments_all;

CREATE TABLE assignments_all
(
id VARCHAR(500),
job_id VARCHAR(500),
worker_id VARCHAR(500),
job_type_id VARCHAR(500),
transaction_id VARCHAR(500),
created_at VARCHAR(500),
data  VARCHAR(500), # Replace Data Column by work_duration when normalized table is received or we can use work_duration from census's mongoDB agent table
work_duration VARCHAR(500), # Extracted from agents table of census app's mongoDB. Replace it with work_duration received from workflow 
skill_id VARCHAR(500),
skill_type VARCHAR(500), 
skill_value VARCHAR(500),
skip_count VARCHAR(500),
first_name VARCHAR(500),
first_name_correct VARCHAR(500),
last_name VARCHAR(500),
last_name_correct VARCHAR(500),
middle_initials VARCHAR(500),
middle_initials_correct VARCHAR(500),
batch_id VARCHAR(500)
);

INSERT INTO assignments_all
(
id ,
job_id,
worker_id ,
job_type_id ,
transaction_id ,
created_at ,
data, # Replace Data Column by work_duration when normalized table is received or we can use work_duration from census's mongoDB agent table
work_duration , # Extracted from agents table of census app's mongoDB. Replace it with work_duration received from workflow 
skill_id ,
skill_type , 
skill_value ,
skip_count ,
first_name ,
first_name_correct ,
last_name ,
last_name_correct,
middle_initials ,
middle_initials_correct ,
batch_id
)

SELECT 
a.id,
a.job_id,
a.worker_id,
j.job_type_id,
j.transaction_id,
a.created_at,
df.data, # Replace Data Column by work_duration when normalized table is received or we can use work_duration from census's mongoDB agent table
ag.work_duration, # Extracted from agents table of census app's mongoDB. Replace it with work_duration received from workflow 
s.id,
s.type,
s.value,
j.skip_count,
rev.first_name,
rev.first_name_correct,
rev.last_name,
rev.last_name_correct,
rev.middle_initials,
rev.middle_initials_correct,
rev.batch_id

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
	
WHERE ag.status='Completed';





