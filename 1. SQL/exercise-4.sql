CREATE TABLE `ms_people` (
 `first_name` varchar(16) DEFAULT NULL,
 `last_name` varchar(16) DEFAULT NULL,
 `address` varchar(64) DEFAULT NULL,
 `city` varchar(32) DEFAULT NULL,
 `country` varchar(2) DEFAULT NULL,
 `phone` varchar(16) DEFAULT NULL,
 `email` varchar(64) DEFAULT NULL
)


select *
from ms_people mp 
where address regexp '26';


select *
from ms_people mp 
where regexp_like(first_name , '^Aa', 'i') 


select address, regexp_replace(address, '[0-9]{1,4}', 'XX', 1) 
from ms_people mp 
limit 10


select 
	email,
	regexp_substr(email, '([A-z._]+)') username,
	regexp_substr(email, '(?<=@)[A-z]*') domain,
	regexp_replace(email, '.*@([A-z])*', '') domain
from ms_people mp 

