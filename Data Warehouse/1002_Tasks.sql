

USE census_dw;

DROP TABLE IF EXISTS tasks;

CREATE TABLE tasks (
_id VARCHAR(500),
batch_id  VARCHAR(500),
created_at DATETIME,
current  VARCHAR(500),
gold_standard  VARCHAR(500),
is_reviewing  VARCHAR(500),
received_from_dizitization_at DATETIME,
reporcessed  VARCHAR(500),
resource_id  VARCHAR(500),
skip_count INT,
skipped  VARCHAR(500),
status  VARCHAR(500), 
task_id  VARCHAR(500),
updated_at DATETIME 
);



INSERT INTO tasks (
_id ,
batch_id ,
created_at ,
current ,
gold_standard ,
is_reviewing ,
received_from_dizitization_at ,
reporcessed ,
resource_id ,
skip_count ,
skipped ,
status , 
task_id ,
updated_at  
)


SELECT 
_id ,
batch_id ,
CAST(created_at AS DATETIME),
current ,
gold_standard ,
is_reviewing ,
CAST(received_from_digitization_at AS DATETIME),
reprocessed ,
resource_id ,
CAST(skip_count AS SIGNED),
skipped ,
status , 
task_id ,
CAST(updated_at AS DATETIME)

FROM 
	tasks_raw;
