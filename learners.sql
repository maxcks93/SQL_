-- Script is run with MySQL_Workbench version 8.0.34 

CREATE DATABASE learnersdb;

USE learnersdb;

CREATE TABLE users(
user_id TEXT,
email_domain TEXT,
country TEXT,
city TEXT,
postal INTEGER,
mobile_app TEXT,
sign_up_at DATETIME
);

CREATE TABLE progress(
user_id TEXT,
learn_cpp TEXT,
learn_sql TEXT,
learn_html TEXT,
learn_javascript TEXT,
learn_java TEXT
);

-- import correspond csv file into the tables created 

-- Question 1
SELECT u.user_id, u.email_domain, p.learn_cpp, p.learn_html, p.learn_java, p.learn_javascript, p.learn_sql 
FROM users u
JOIN progress p
ON u.user_id = p.user_id
ORDER BY u.email_domain;


-- Question 2 part 1
SELECT email_domain, COUNT(*) as 'Number of students'
FROM users 
GROUP BY email_domain 
ORDER BY COUNT(*) DESC 
LIMIT 25;
-- to show top 25 schools based on number of learners in the data

-- Question 2 part 2 
SELECT city, COUNT(*) AS "Number of students"
FROM users 
WHERE city LIKE '%New York%'
GROUP BY city
ORDER BY COUNT(*) DESC;
-- to show the learners located in New York

-- Question 2 part 3 
SELECT COUNT(*) AS "Number of mobile users"
FROM users 
WHERE mobile_app != ''; 
-- to exclude the learners that are not using mobile app

SELECT COUNT(*) AS "Number of mobile users" 
FROM users 
WHERE mobile_app IN('mobile-user');
-- to show the learners that are using mobile app


-- Question 3
SELECT COUNT(sign_up_at), DATE_FORMAT(sign_up_at, '%h') as "Hour" 
FROM USERS
GROUP BY DATE_FORMAT(sign_up_at, '%h');
-- the date_format(column, format) in SQL version 8 is equivalent to strftime(format, column) in SQLite


-- Question 4 part 1 (method 1)
SELECT u.email_domain, 
SUM(CASE WHEN p.learn_cpp != '' THEN 1 ELSE 0 END) as 'CPP',
SUM(CASE WHEN p.learn_html != '' THEN 1 ELSE 0 END) as 'HTML',
SUM(CASE WHEN p.learn_java != '' THEN 1 ELSE 0 END) as 'JAVA',
SUM(CASE WHEN p.learn_javascript != '' THEN 1 ELSE 0 END) as 'JS',
SUM(CASE WHEN p.learn_sql != '' THEN 1 ELSE 0 END) as 'SQL',
COUNT(u.user_id) as 'Number Of Learners'
FROM users u
JOIN progress p
ON u.user_id = p.user_id
GROUP BY u.email_domain
ORDER BY u.email_domain ASC;

-- Question 4 part 1 (method 2, only works in mySQL)
SELECT u.email_domain, 
SUM(IF(p.learn_cpp NOT IN(''), 1, 0)) AS "C++",
SUM(IF(p.learn_html NOT IN(''), 1, 0)) AS "HTML",
SUM(IF(p.learn_java NOT IN(''), 1, 0)) AS "JAVA",
SUM(IF(p.learn_javascript NOT IN(''), 1, 0)) AS "JS",
SUM(IF(p.learn_sql NOT IN(''), 1, 0)) AS "SQL",
COUNT(u.user_id) as 'Number Of Learners'
FROM users u
JOIN progress p
ON u.user_id = p.user_id
GROUP BY u.email_domain
ORDER BY u.email_domain ASC;

-- Question 4 part 2
SELECT 
SUM(CASE WHEN learn_cpp != '' THEN 1 ELSE 0 END) AS "New Yorkers taking C++",
SUM(CASE WHEN learn_html != '' THEN 1 ELSE 0 END) AS "New Yorkers taking HTML",
SUM(CASE WHEN learn_java != '' THEN 1 ELSE 0 END) AS "New Yorkers taking JAVA",
SUM(CASE WHEN learn_javascript != '' THEN 1 ELSE 0 END) AS "New Yorkers taking JS",
SUM(CASE WHEN learn_sql != '' THEN 1 ELSE 0 END) AS "New Yorkers taking SQL"
FROM progress
JOIN users ON progress.user_id = users.user_id
WHERE users.city = "New York";

-- Question 4 part 3
SELECT 
SUM(CASE WHEN learn_cpp != '' THEN 1 ELSE 0 END) AS "Chicago learners taking C++",
SUM(CASE WHEN learn_html != '' THEN 1 ELSE 0 END) AS "Chicago learners taking HTML",
SUM(CASE WHEN learn_java != '' THEN 1 ELSE 0 END) AS "Chicago learners taking JAVA",
SUM(CASE WHEN learn_javascript != '' THEN 1 ELSE 0 END) AS "Chicago learners taking JS",
SUM(CASE WHEN learn_sql != '' THEN 1 ELSE 0 END) AS "Chicago learners taking SQL"
FROM progress
JOIN users ON progress.user_id = users.user_id
WHERE users.city = "Chicago";