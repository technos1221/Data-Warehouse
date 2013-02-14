USE census_dw;

# Pass 1 -> Creates a temporary table where skill_before , count of perfect / imperfect score is seen
# This Shows a matrix where frequency of accurate works for particular/ all  skill value is seen. Use this matrix outcome to give weight to the simple Naive Bayes model..


#############################################################################################################################################################################
DROP TABLE IF EXISTS  pass1;
#############################################################################################################################################################################


CREATE TEMPORARY TABLE pass1 AS 
SELECT 
a.id AS assignment_id, 
a.worker_id, 
s.type AS skill_type, 
s.id AS skill_id, 
s_parent.value AS skill_before,
s.value AS skill_after, 
a.score AS score,
a.score=1 AS perfect,
NULL as work_duration, 
a.created_at AS created_at
FROM 
	workflow_prod.assignments a
	
INNER JOIN 
	workflow_prod.skills s 
ON 
	a.id=s.assignment_id
	
INNER JOIN 
	workflow_prod.skills s_parent 
ON 
	s.parent_id = s_parent.id
WHERE 
	a.score IS NOT NULL
	
ORDER BY created_at DESC;


#############################################################################################################################################################################
DROP TABLE IF EXISTS pass2;
#############################################################################################################################################################################


CREATE  TABLE pass2 AS 
SELECT 
worker_id,
skill_type, 
skill_before,
perfect,
count(1) AS frequency 
FROM 
	pass1
GROUP BY worker_id,skill_before , skill_type , perfect
ORDER BY skill_before DESC;



#############################################################################################################################################################################
DROP TABLE IF EXISTS pass3;
#############################################################################################################################################################################



CREATE TEMPORARY TABLE pass3 as
SELECT we.*
FROM pass2 we
INNER JOIN(
    SELECT skill_type, skill_before,perfect,max(frequency) frequency
    FROM pass2
    GROUP BY skill_type ,skill_before
) ss ON  we.frequency = ss.frequency AND we.skill_before=ss.skill_before ;



#############################################################################################################################################################################
DROP TABLE IF EXISTS skill_range;
#############################################################################################################################################################################


CREATE TEMPORARY TABLE skill_range AS 
		SELECT 
			worker_id,
			skill_type,
			CASE WHEN skill_before BETWEEN 0.9 AND 0.93 THEN '0.9 - 0.93' 
			WHEN skill_before BETWEEN 0.8 AND 0.9 THEN '0.8 - 0.9' 
			WHEN skill_before BETWEEN 0.7 AND 0.8 THEN '0.7 - 0.8' 
			WHEN skill_before BETWEEN 0.6 AND 0.7 THEN '0.6 - 0.7' 
			WHEN skill_before BETWEEN 0.5 AND 0.6 THEN '0.5 - 0.6' 
			WHEN skill_before BETWEEN 0.4 AND 0.5 THEN '0.4 - 0.5' 
			WHEN skill_before BETWEEN 0.3 AND 0.4 THEN '0.3 - 0.4' 
			WHEN skill_before BETWEEN 0.2 AND 0.3 THEN '0.2 - 0.3' 
			WHEN skill_before BETWEEN 0.1 AND 0.2 THEN '0.1 - 0.2' 
			ELSE '0' END AS skill_range  , perfect , frequency
			
			FROM pass3 ;
			
############################################################################################################################################################################# 			
DROP TABLE IF EXISTS skill_matrix;
############################################################################################################################################################################# 


CREATE TABLE skill_matrix AS
SELECT
	worker_id, 
	skill_type,
	skill_range,
	perfect,
	sum(frequency) as total
FROM 
	skill_range
GROUP BY worker_id,skill_type,skill_range , perfect  
ORDER BY skill_type,skill_range , perfect;	


############################################################################################################################################################################# 			
DROP TABLE IF EXISTS pass1;
DROP TABLE IF EXISTS pass2;
DROP TABLE IF EXISTS pass3;
############################################################################################################################################################################# 

