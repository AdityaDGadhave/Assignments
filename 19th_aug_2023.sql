-- Active: 1702879898477@@127.0.0.1@3306
##Q1. Query all columns for all American cities in the CITY table with populations larger than
## 100000.The CountryCode for America is USA.The CITY table is described as follows:

#Ans

use mysql;
SELECT *
FROM CITY
WHERE CountryCode = 'USA' AND Population > 100000;


##Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
##The CountryCode for America is USA.
##The CITY table is described as follows:

##Answer:>
SELECT NAME
FROM CITY
WHERE CountryCode = 'USA' AND Population > 120000;


##Q3. Query all columns (attributes) for every row in the CITY table.

##Answer
SELECT *
FROM CITY;

##Q4. Query all columns for a city in CITY with the ID 1661.

##Answer
SELECT *
FROM CITY
WHERE ID = 1661;

##Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is
##JPN.

##Answer:
SELECT *
FROM CITY
WHERE CountryCode = 'JPN';

##Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is
#JPN.

##Answer
SELECT NAME
FROM CITY
WHERE CountryCode = 'JPN';


##Q7. Query a list of CITY and STATE from the STATION table.
##The STATION table is described as follows:

##Answer
SELECT CITY, STATE
FROM STATION;

##Q8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order,
## but exclude duplicates from the answer. 

##Answer
SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2 = 0;

##Q9. Find the difference between the total number of CITY entries in the table and the number of
##distinct CITY entries in the table.

##Answer
SELECT COUNT(*) - COUNT(DISTINCT CITY) AS city_count_diff
FROM STATION;

##Q10. Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city,
## choose the one that comes first when ordered alphabetically.

##Answer
WITH smallest_city AS (
    SELECT CITY, LENGTH(CITY) AS city_length
    FROM STATION
    ORDER BY city_length
    LIMIT 1
)
, largest_city AS (
    SELECT CITY, LENGTH(CITY) AS city_length
    FROM STATION
    ORDER BY city_length DESC
    LIMIT 1
)
SELECT
    smallest_city.CITY AS smallest_city_name,
    smallest_city.city_length AS smallest_city_length,
    largest_city.CITY AS largest_city_name,
    largest_city.city_length AS largest_city_length
FROM smallest_city
JOIN largest_city ON smallest_city.city_length < largest_city.city_length;

##Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
##Your result cannot contain duplicates. Input Format The STATION table is described as follows:

#Answer:->
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[aeiou]';

##Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
##contain duplicates.Input Format The STATION table is described as follows:

##Answer
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '[aeiou]$';

##Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates. Input Format The 
 ##table is described as follows:

##Answer:->
SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '^[aeiou]';

##Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates. 
##Input Format The STATION table is described as follows:

##Answer
SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '[aeiou]$';

##Q15. Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. 
##Your result cannot contain duplicates. Input Format The STATION table is described as follows:

##Answer

SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '^[aeiou]'
AND CITY NOT REGEXP '[aeiou]$';


##Q16. Query the list of CITY names from STATION that start with vowels and do not end with vowels. Your result cannot 
##contain duplicates. Input Format The STATION table is described as follows:

##Answer
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[aeiou]'
AND CITY NOT REGEXP '[aeiou]$';



#Q17
##Answer
SELECT product_id, 
       product_name 
FROM   product 
WHERE  product_id NOT IN (SELECT product_id 
                          FROM   sales 
                          WHERE  sale_date NOT BETWEEN 
                                 '2019-01-01' AND '2019-03-31'); 


select p.product_id, p.product_name
from Product p
left join Sales s
on p.product_id = s.product_id
group by p.product_id
having sum(s.sale_date between '2019-01-01' and '2019-03-31') = count(s.sale_date)


SELECT product_id, 
       product_name 
FROM   product 
WHERE  product_id NOT IN (SELECT product_id 
                          FROM   sales 
                          WHERE  sale_date NOT BETWEEN 
                                 '2019-01-01' AND '2019-03-31'); 


#Q18
##Answer
select author_id as id
from Views
where author_id = viewer_id
group by author_id
order by author_id asc



select distinct author_id as id
from Views
where author_id = viewer_id
order by author_id asc

#Q19
##Answer
select count(*)*100.0/b.total as immdediate_percentage from Delivery a, 
(select count(*) as total from Delivery) b
where a.order_date = a.customer_pref_delivery_date;

Website:https://www.jdoodle.com/execute-sql-online/

create table calc(order_date date,customer_pref_delivery_date date);

insert into calc values( '2019-08-02', '2019-08-02');
insert into calc values( '2019-08-01', '2019-08-02');
select count(*) *100/b.total as immediate_percentage from calc a, 
(select count(*) as total from calc) b
where a.order_date = a.customer_pref_delivery_date;


#Q21
#Answer
select e.employee_id, (select count(team_id) from Employee where e.team_id = team_id) as team_size
from Employee e

OR

SELECT employee_id, COUNT(team_id) OVER (PARTITION BY team_id) team_size
FROM Employee

#Q22
#Answer
SELECT
c.country_name,
CASE (
    WHEN AVG(w.weather_state) <= 15 THEN 'Cold'
    WHEN AVG(w.weather_state) >= 25 THEN 'Hot' 
    'Warm' END ) AS weather_type
FROM
Weather w
INNER JOIN 
Countries c
ON 
w.country_id = c.country_id
WHERE
LEFT(w.day, 7) = '2019-11'
GROUP BY c.country_name;


select country_name, case when avg(weather_state) <= 15 then "Cold"
                          when avg(weather_state) >= 25 then "Hot"
                          else "Warm" end as weather_type
from Countries inner join Weather
on Countries.country_id = Weather.country_id
where left(day, 7) = '2019-11'
group by country_name


SELECT c.country_name,
       CASE
           WHEN AVG(w.weather_state * 1.0) <= 15.0 THEN 'Cold'
           WHEN AVG(w.weather_state * 1.0) >= 25.0 THEN 'Hot'
           ELSE 'Warm'
       END AS weather_type
FROM Countries AS c
INNER JOIN Weather AS w ON c.country_id = w.country_id
WHERE w.day BETWEEN '2019-11-01' AND '2019-11-30'
GROUP BY c.country_id;

#Q23
#Answer
SELECT a.product_id
	, round(SUM(a.units * b.price) / SUM(a.units), 2) AS average_price
FROM UnitsSold a
	JOIN Prices b
	ON (a.product_id = b.product_id
		AND a.purchase_date >= b.start_date
		AND a.purchase_date <= b.end_date)
group by product_id

WITH cte1 AS
  (SELECT p.product_id,
          u.purchase_date,
          u.units,
          p.price
   FROM Prices p
   INNER JOIN UnitsSold u ON p.product_id = u.product_id
   WHERE u.purchase_date <= p.end_date
     AND u.purchase_date >= p.start_date )
SELECT product_id,
       ROUND(SUM(units * price) / sum(units), 2) AS average_price
FROM cte1
GROUP BY product_id;


select UnitsSold.product_id, round(sum(units*price)/sum(units), 2) as average_price
from UnitsSold inner join Prices
on UnitsSold.product_id = Prices.product_id
and UnitsSold.purchase_date between Prices.start_date and Prices.end_date
group by UnitsSold.product_id


select product_id,round(sum(a)/sum(units),2) as average_price from(
    select 
        p.product_id as product_id,
        price,units,
        price*units as a
    from Prices p 
    left join UnitsSold u
    on p.product_id=u.product_id and (purchase_date<=end_date and purchase_date>=start_date))t
    group by product_id


SELECT a.product_id
	, round(SUM(a.units * b.price) / SUM(a.units), 2) AS average_price
FROM UnitsSold a
	JOIN Prices b
	ON (a.product_id = b.product_id
		AND a.purchase_date >= b.start_date
		AND a.purchase_date <= b.end_date)
group by product_id


SELECT b.product_id, 
       ROUND(SUM(a.units * b.price) / SUM(a.units), 2) AS average_price 
FROM   UnitsSold AS a 
       INNER JOIN Prices AS b 
               ON a.product_id = b.product_id 
WHERE  a.purchase_date BETWEEN b.start_date AND b.end_date 
GROUP  BY product_id




#Q24
#Answer
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

#Q25
#Answer
SELECT player_id, device_id
FROM Activity
WHERE (player_id, event_date) IN (
    SELECT player_id, MIN(event_date)
    FROM Activity
    GROUP BY player_id
);

#Q26
#Answer
SELECT p.product_name, SUM(o.unit) AS unit
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date <= '2020-02-29'
GROUP BY p.product_id
HAVING SUM(o.unit) >= 100
ORDER BY unit DESC;

#Q27
#Answer
SELECT user_id, name, mail
FROM Users
WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode.com$';


#Q28
#Answer
WITH Monthly_Totals AS (
    SELECT customer_id, MONTH(order_date) AS order_month, SUM(quantity * price) AS monthly_total
    FROM Orders
    JOIN Product USING (product_id)
    GROUP BY customer_id, MONTH(order_date)
)
SELECT c.customer_id, c.name
FROM Customers c
JOIN Monthly_Totals mt1 ON c.customer_id = mt1.customer_id AND mt1.order_month = 6 AND mt1.monthly_total >= 100
JOIN Monthly_Totals mt2 ON c.customer_id = mt2.customer_id AND mt2.order_month = 7 AND mt2.monthly_total >= 100;


#Q29
#Answer
SELECT DISTINCT c.title
FROM TVProgram tp
JOIN Content c ON tp.content_id = c.content_id
WHERE MONTH(tp.program_date) = 6 AND YEAR(tp.program_date) = 2020
  AND c.Kids_content = 'Y' AND c.content_type = 'Movies';

#Q30
#Answer
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv
FROM Queries q
LEFT JOIN NPV n ON q.id = n.id AND q.year = n.year;

#Q31
#Answer
SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv
FROM Queries q
LEFT JOIN NPV n ON q.id = n.id AND q.year = n.year;


#Q32
#Answer
SELECT COALESCE(eu.unique_id, NULL) AS unique_id, e.name
FROM Employees e
LEFT JOIN EmployeeUNI eu ON e.id = eu.id;

#Q33
#Answer
SELECT u.name, COALESCE(SUM(r.distance), 0) AS travelled_distance
FROM Users u
LEFT JOIN Rides r ON u.id = r.user_id
GROUP BY u.id
ORDER BY travelled_distance DESC, u.name ASC;

#Q34
#Answer
SELECT p.product_name, SUM(o.unit) AS total_units
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE MONTH(o.order_date) = 2 AND YEAR(o.order_date) = 2020
GROUP BY p.product_id
HAVING total_units >= 100;

#Q35
#Answer
WITH UserRatingCounts AS (
    SELECT u.user_id, u.name, COUNT(*) AS rating_count
    FROM Users u
    JOIN MovieRating mr ON u.user_id = mr.user_id
    GROUP BY u.user_id
), MovieAverageRatings AS (
    SELECT m.movie_id, m.title, AVG(rating) AS avg_rating
    FROM Movies m
    JOIN MovieRating mr ON m.movie_id = mr.movie_id
    WHERE MONTH(created_at) = 2 AND YEAR(created_at) = 2020
    GROUP BY m.movie_id
)
SELECT
    (SELECT name FROM UserRatingCounts ORDER BY rating_count DESC, name ASC LIMIT 1) AS most_active_user,
    (SELECT title FROM MovieAverageRatings ORDER BY avg_rating DESC, title ASC LIMIT 1) AS highest_rated_movie
;

#Q36
#Answer
SELECT u.name, COALESCE(SUM(r.distance), 0) AS travelled_distance
FROM Users u
LEFT JOIN Rides r ON u.id = r.user_id
GROUP BY u.id
ORDER BY travelled_distance DESC, u.name ASC;

#Q37
#Answer
SELECT COALESCE(eu.unique_id, NULL) AS unique_id, e.name
FROM Employees e
LEFT JOIN EmployeeUNI eu ON e.id = eu.id;

#Q38
#Answer
SELECT s.id, s.name
FROM Students s
LEFT JOIN Departments d ON s.department_id = d.id
WHERE d.id IS NULL;

#Q39
#Answer
SELECT
    LEAST(from_id, to_id) AS person1,
    GREATEST(from_id, to_id) AS person2,
    COUNT(*) AS call_count,
    SUM(duration) AS total_duration
FROM Calls
GROUP BY person1, person2
ORDER BY person1, person2;

#Q40
#Answer
SELECT
    p.product_id,
    ROUND(SUM(p.price * us.units) / SUM(us.units), 2) AS average_price
FROM Prices p
JOIN UnitsSold us ON p.product_id = us.product_id AND us.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;

#Q41
#Answer
SELECT
    w.name AS warehouse_name,
    SUM(w.units * p.Width * p.Length * p.Height) AS volume
FROM Warehouse w
JOIN Products p ON w.product_id = p.product_id
GROUP BY w.name;


#Q42
#Answer
SELECT
    sale_date,
    (apples - oranges) AS diff
FROM (
    SELECT
        sale_date,
        SUM(CASE WHEN fruit = 'apples' THEN sold_num ELSE 0 END) AS apples,
        SUM(CASE WHEN fruit = 'oranges' THEN sold_num ELSE 0 END) AS oranges
    FROM Sales
    GROUP BY sale_date
) AS fruit_sales
ORDER BY sale_date;

#Q43
#Answer
SELECT ROUND(COUNT(DISTINCT c.player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction
FROM (
    SELECT player_id, MIN(event_date) AS event_start_date
    FROM Activity
    GROUP BY player_id
) c
JOIN Activity a ON c.player_id = a.player_id AND datediff(c.event_start_date, a.event_date) = -1;

#Q44
#Answer
SELECT m.name
FROM Employee m
JOIN Employee e ON m.id = e.managerId
GROUP BY m.id
HAVING COUNT(e.id) >= 5;

#45
#Answer
SELECT d.dept_name, COUNT(s.student_id) AS student_number
FROM Department d
LEFT JOIN Student s ON d.dept_id = s.dept_id
GROUP BY d.dept_id
ORDER BY student_number DESC, d.dept_name ASC;

#46
#Answer
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);

#47
#Answer
SELECT p.project_id, e.employee_id
FROM Project p
JOIN Employee e ON p.employee_id = e.employee_id
WHERE (p.project_id, e.experience_years) IN (
    SELECT project_id, MAX(experience_years)
    FROM Project p
    JOIN Employee e ON p.employee_id = e.employee_id
    GROUP BY project_id
);

#Q48
#Answer
SELECT b.book_id, b.name
FROM Books b
LEFT JOIN Orders o ON b.book_id = o.book_id
WHERE
    b.available_from <= '2019-05-23' 
    AND (
        o.book_id IS NULL 
        OR o.dispatch_date < '2018-06-23' 
    )
GROUP BY b.book_id
HAVING SUM(o.quantity) < 10; 

#Q49
#Answer
SELECT student_id, MIN(course_id) AS course_id, MAX(grade) AS grade
FROM Enrollments
GROUP BY student_id
ORDER BY student_id;

#Q50
#Answer
WITH TotalScores AS (
    SELECT player_id, group_id, SUM(CASE WHEN player_id = first_player THEN first_score ELSE second_score END) AS total_score
    FROM Matches m
    JOIN Players p ON m.first_player = p.player_id OR m.second_player = p.player_id
    GROUP BY player_id, group_id
)
SELECT group_id, MIN(player_id) AS player_id
FROM TotalScores
GROUP BY group_id
HAVING total_score = MAX(total_score)
ORDER BY group_id;
