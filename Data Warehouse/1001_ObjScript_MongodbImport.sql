


USE census_dw;

## After Creating the tables import xls files using Import / Export Utility of RazorSQL


DROP TABLE IF EXISTS reviews_raw;

CREATE TABLE reviews_raw (
_id	VARCHAR	(500),
action	VARCHAR	(500),
age	VARCHAR	(500),
batch_id	VARCHAR	(500),
controller	VARCHAR	(500),
created_at	VARCHAR (500)	,
first_name	VARCHAR	(500),
gold_standards	VARCHAR	(500),
image_url	VARCHAR	(500),
last_name	VARCHAR	(500),
middle_initials	VARCHAR	(500),
names_reversed	VARCHAR	(500),
result_id	VARCHAR	(500),
reviewer	VARCHAR	(500),
task_id	VARCHAR	(500),
updated_at	VARCHAR	(500)
);


DROP TABLE IF EXISTS tasks_raw;

CREATE TABLE tasks (

_id	VARCHAR	(500)	,
created_at	VARCHAR(500)		,
current	VARCHAR(500)		,
gold_standard	VARCHAR(500)	,
is_reviewing	VARCHAR(500)	,
received_from_digitization_at	VARCHAR(500),
reprocessed	VARCHAR	(500)	,
resource_id	VARCHAR	(500)	,
skip_count	VARCHAR(500)	,
skipped	VARCHAR	(500)	,
status	VARCHAR (500),
task_id	VARCHAR	(500)	,
updated_at	VARCHAR	(500)
) ;

DROP TABLE IF EXISTS agents_raw;

CREATE TABLE agents (
_id	VARCHAR	(500)	,
assignment_duration	VARCHAR	(500)	,
assignment_id	VARCHAR	(500)	,
created_at	VARCHAR	(500)	,
rejected	VARCHAR	(500)	,
skip_count	VARCHAR	(500)	,
status	VARCHAR	(500)	,
task_id	VARCHAR	(500)	,
updated_at	 VARCHAR	(500)	,
work_duration	VARCHAR	(500)	,
worker_confidence	VARCHAR	(500)	,
worker_id	VARCHAR	(500)	
);


DROP TABLE IF EXISTS results_raw ;

CREATE TABLE results_raw
(
_id	VARCHAR	(500)	,
_type	VARCHAR	(500)	,
age	VARCHAR	(500)	,
created_at	VARCHAR	(500)	,
first_name	VARCHAR (500)		,
last_name	VARCHAR	(500)	,
middle_initials	VARCHAR	(500)	,
task_id	VARCHAR	(500)	,
updated_at	VARCHAR	(500)	
);





