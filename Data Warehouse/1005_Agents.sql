



USE census_dw;

CREATE TABLE agents (

_id VARCHAR(500),
assignment_duration FLOAT,
assignment_id INT,
created_at DATETIME,
rejected VARCHAR(500),
skip_count INT,
status VARCHAR(500),
task_id VARCHAR(500),
updated_at DATETIME,
work_duration FLOAT,
worker_confidence FLOAT,
worker_id VARCHAR(500)

);



INSERT INTO agents
(
_id ,
assignment_duration ,
assignment_id ,
created_at ,
rejected ,
skip_count ,
status ,
task_id ,
updated_at ,
work_duration ,
worker_confidence ,
worker_id 

)

SELECT 
_id ,
CAST(assignment_duration AS SIGNED) ,
CAST(assignment_id AS SIGNED),
CAST(created_at AS DATETIME),
rejected ,
CAST(skip_count AS SIGNED),
status ,
task_id ,
CAST(updated_at AS DATETIME),
CAST(work_duration AS SIGNED),
CAST(worker_confidence AS SIGNED),
worker_id 

FROM 
	agents_raw;








