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

-- Question 2 part 1
SELECT email_domain FROM users ORDER BY email_domain LIMIT 25; #to show top 25 schools in alphabetical order
SELECT email_domain, COUNT(*) as frequency FROM users GROUP BY email_domain ORDER BY frequency DESC LIMIT 25; #to show top 25 schools based on number of learners in the data

-- Question 2 part 2
SELECT * FROM users WHERE city IN ('New York'); #to show the learners located in New York

-- Question 2 part 3 
SELECT * FROM users WHERE mobile_app != ''; #to exclude the learners that are not using mobile app
SELECT * FROM users WHERE mobile_app = 'mobile-user'; #to show the learners that are using mobile app


-- Question 3
SELECT sign_up_at,
   date_format(sign_up_at, '%h') as hour_count
FROM users
GROUP BY 1
LIMIT 20;
-- the date_format(column, format) in SQL version 8 is equivalent to strftime(format, column) in SQLite


-- Question 4 part 1
SELECT u.email_domain, 
COUNT(CASE WHEN p.learn_cpp != '' then 1 END) as 'CPP',
COUNT(CASE WHEN p.learn_html != '' then 1 END) as 'HTML',
COUNT(CASE WHEN p.learn_java != '' then 1 END) as 'JAVA',
COUNT(CASE WHEN p.learn_javascript != '' then 1 END) as 'JS',
COUNT(CASE WHEN p.learn_sql != '' then 1 END) as 'SQL',
COUNT(u.user_id) as 'Number Of Learners'
FROM users u
JOIN progress p
ON u.user_id = p.user_id
GROUP BY u.email_domain
ORDER BY u.email_domain;
#Ans: Yes, from the result shown, different schools (.edu domains) prefer different courses.

-- Question 4 part 2
SELECT u.user_id, u.city, 
p.learn_cpp as 'CPP', 
p.learn_html as 'HTML', 
p.learn_java as 'JAVA', 
p.learn_javascript as 'JS', 
p.learn_sql as 'SQL'
FROM users u
JOIN progress p
ON u.user_id = p.user_id
WHERE u.city IN ('New York');
#Ans: New Yorkers students are taking all the courses including cpp, html, java, javascript and sql.

-- Question 4 part 3
SELECT u.user_id, u.city, 
p.learn_cpp as 'CPP', 
p.learn_html as 'HTML', 
p.learn_java as 'JAVA', 
p.learn_javascript as 'JS', 
p.learn_sql as 'SQL'
FROM users u
JOIN progress p
ON u.user_id = p.user_id
WHERE u.city IN ('Chicago');
#Ans: New Yorkers students are taking all the courses including cpp, html, java, javascript and sql.