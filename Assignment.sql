use  ineuron;

## QUETION1:- TO LIST THE CANDIDATE WHICH POSSESS ALL THE REQUIRED SKILLS

#ANSWER
create table technology(id int,technology varchar(20));
insert into technology(id,technology) values
(1,'ds'),
(1,'python'),
(2,'R'),
(1,'SQL'),
(2,'Tableu'),
(2,'powerbi'),
(1,'powerbi'),
(2,'python'),
(3,'power Bi'),
(3,'python');


SELECT id
FROM technology
WHERE technology = 'DS'
AND id IN (
    SELECT id
    FROM technology
    WHERE technology = 'SQL'
    AND id IN (
        SELECT id
        FROM technology
        WHERE technology = 'PYTHON'
    )
);




##QUETION 2:-> WRITE A QUERY TO RETURN IDS OF THE PRODUCT INFO THAT HAVE ZERO LIKES? 


##ANSWER:->


create table product_info(pr_id int,product varchar(20));

insert into product_info(Pr_id,Product) values
(1001,'Blog'),
(1002,'Youtube'),
(1003,'Education');
create table product_info_like(pr_id int,product_info_like varchar(20));
insert into product_info_like(pr_id, product_info_like) values(1001,'Blog'),(1003,'Education');

SELECT product_info.pr_id FROM
product_info
left join  product_info_like on product_info.pr_id =product_info_like.pr_id
WHERE product_info_like.pr_id is null;



























