USE demo

DECLARE @genders TABLE(gender_id INT, gender VARCHAR(20))
DECLARE @toys TABLE(toy_id INT, gender_id INT, toy_name VARCHAR(20))

INSERT INTO @genders(gender_id, gender)
SELECT 1, 'boy'
UNION ALL
SELECT 2, 'girl'
UNION ALL
SELECT 3, 'both'

INSERT INTO @toys(toy_id, gender_id, toy_name)
SELECT 1, 1, 'GI JOE'
UNION ALL
SELECT 2,2, 'My Little Pony'


SELECT g.*
FROM @genders g
LEFT OUTER JOIN @toys t
ON g.gender_id = t.gender_id
WHERE t.toy_name NOT IN(
'My Little Pony'
) 