USE demo

;with mycte as (
select * from  @toys WHERE toy_name NOT IN('My Little Pony')) 

SELECT g.*, t.toy_name
FROM @genders g
LEFT OUTER JOIN mycte t
ON g.gender_id = t.gender_id