

USE census_dw;

DROP TABLE IF EXISTS results;

CREATE TABLE results
(
_id VARCHAR(500),
_type VARCHAR(500),
age VARCHAR(500),
age_correct VARCHAR(500),
age_reviewed VARCHAR(500),
created_at DATETIME,
first_name VARCHAR(500),
first_name_correct VARCHAR(500),
first_name_reviewed VARCHAR(500) ,
last_name VARCHAR(500),
last_name_correct VARCHAR(500),
last_name_reviewed VARCHAR(500),
middle_initials VARCHAR(500),
middle_initials_correct VARCHAR(500),
middle_initials_reviewed VARCHAR(500),
task_id VARCHAR(500),
updated_at DATETIME
);

INSERT INTO results
(
_id,
_type,
age,
age_correct,
age_reviewed,
created_at,
first_name,
first_name_correct,
first_name_reviewed,
last_name,
last_name_correct,
last_name_reviewed,
middle_initials,
middle_initials_correct,
middle_initials_reviewed,
task_id,
updated_at
)


SELECT

_id,
_type,
REPLACE(substring(age,4,2),'"','') AS age ,
LTRIM(RTRIM(REPLACE (substring(age,9,INSTR(age,',')),',',''))) AS age_correct ,
LTRIM(RTRIM(REPLACE(REPLACE(substring(age, INSTR(age,'e ,')+2,7),',',''),']',''))) AS age_reviewed,
CONVERT(created_at , DATETIME) as created_at,
REPLACE(REPLACE(substring(first_name, INSTR(first_name,'"')+1,INSTR(first_name,',')-2),'"',''),',','') AS first_name,
SUBSTRING(first_name, INSTR(first_name,',')+1,6) AS first_name_correct,
REPLACE( REPLACE(substring(first_name, INSTR(first_name,'e ,')+2,7),',',''),']','') AS first_name_reviewed,
REPLACE(REPLACE(substring(last_name, INSTR(last_name,'"')+1,INSTR(last_name,',')-2),'"',''),',','') AS last_name,
SUBSTRING(last_name, INSTR(last_name,',')+1,6) AS last_name_correct,
REPLACE( REPLACE(substring(last_name, INSTR(last_name,'e ,')+2,7),',',''),']','') AS last_name_reviewed,
SUBSTRING(middle_initials, INSTR(middle_initials,'"'),INSTR(middle_initials,',')-4) as middle_initials,
SUBSTRING(middle_initials, INSTR(middle_initials,',')+1,6) as middle_initials_correct,
REPLACE( REPLACE(substring(middle_initials, INSTR(middle_initials,'e ,')+2,7),',',''),']','') as middle_initials_reviewed,
task_id,
CONVERT(updated_at , DATETIME) as updated_at

FROM 
	results_raw;



