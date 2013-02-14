
USE census_dw;

DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
_id	VARCHAR	(500),
action	VARCHAR	(500),
batch_id	VARCHAR	(500),
controller	VARCHAR	(500),
gold_standards	VARCHAR	(500),
created_at DATE,
first_name VARCHAR(500),
first_name_correct	VARCHAR	(500),
last_name	VARCHAR	(500),
last_name_correct VARCHAR(500),
middle_initials	VARCHAR	(500),
middle_initials_correct VARCHAR(500),
age1	VARCHAR(500),
age_correct VARCHAR(500),
names_reversed	VARCHAR	(500),
image_url	VARCHAR	(500),
result_id	VARCHAR	(500),
reviewer	VARCHAR	(500),
task_id	VARCHAR	(500),
updated_at	DATE
);

INSERT INTO reviews
(
_id,
action,
batch_id,
controller,
gold_standards,
created_at,
first_name,
first_name_correct,
last_name,
last_name_correct,
middle_initials,
middle_initials_correct,
age1,
age_correct,
names_reversed,
image_url,
result_id,
reviewer,
task_id,
updated_at
)


SELECT 
_id,
action,
batch_id,
controller,
gold_standards,
CONVERT(created_at , DATETIME) AS created_at,
REPLACE(REPLACE(REPLACE(SUBSTRING(gold_standards, INSTR(gold_standards,'"')+1,INSTR(gold_standards,',')-2),'"',''),',',''),'first_name : ','') AS first_name, 
first_name AS first_name_correct,
REPLACE(REPLACE(REPLACE( substring(gold_standards, locate('"last_name"', gold_standards),INSTR(gold_standards,'middle_initials')-INSTR(gold_standards,'"last_name"')),'"last_name" : ' ,''),
'"',''),',','') AS last_name,

last_name AS last_name_correct,
REPLACE(REPLACE(REPLACE( substring(gold_standards, locate('"middle_initials"', gold_standards),INSTR(gold_standards,'age')-INSTR(gold_standards,'"middle_initials"')),
'"middle_initials" : ' ,''),'"',''),',','') AS middle_initials,

middle_initials as middle_initials_correct,
LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(SUBSTRING(gold_standards, locate('"age"', gold_standards),INSTR(gold_standards,'"task_id"')-INSTR(gold_standards,'"age"')),',','')
,'"',''),':',''),'age',''))) AS age1,

age AS age_correct,
names_reversed,
image_url,
result_id,
reviewer,
task_id,
CONVERT(updated_at , DATETIME ) as updated_at
FROM
	reviews_raw;
