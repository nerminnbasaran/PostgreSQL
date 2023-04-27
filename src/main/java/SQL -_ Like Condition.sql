CREATE TABLE employees 
(  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  salary SMALLINT,
  company VARCHAR(20)
);

INSERT INTO employees VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO employees VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO employees VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO employees VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO employees VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO employees VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO employees VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM employees;

CREATE TABLE companies 
(  
  company_id CHAR(9), 
  company VARCHAR(20),
  number_of_employees SMALLINT
);

INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);

SELECT * FROM companies;

--Find the employee and company names whose company has more than 15000 employees
SELECT name, company
FROM employees
WHERE company IN(SELECT company FROM companies WHERE number_of_employees > 15000);

--Find the company ids and company names which are in Florida

SELECT company_id, company
FROM companies
WHERE company IN(SELECT company FROM employees WHERE state = 'Florida');

--Find the employee name and state which has companies whose company ids are greater than 100

SELECT name, state
FROM employees
WHERE company IN ('GOOGLE', 'MICROSOFT', 'APPLE');

SELECT company FROM companies WHERE company_id > '100';

--Find the company name, number of employees and average salary for every company
SELECT company, number_of_employees, (SELECT AVG(salary) 
									  FROM employees WHERE employees.company = companies.company)
									  AS avg_salary_per_company
FROM companies;


--Find the name of the companies, company ids, maximum and minimum salaries per company.
SELECT company, company_id, (SELECT MIN(salary) FROM employees WHERE employees.company = companies.company)AS min_salary_per_company,
							(SELECT MAX(salary) FROM employees WHERE employees.company = companies.company)AS max_salary_per_company
FROM companies;


--LIKE Condition: It is used with WildCard

--1) % WildCard: It represents zore or more characters

--Select employee names which start with 'E'
SELECT name
FROM employees
WHERE name LIKE 'E%';

--Select employee names which end with 'e'
SELECT name
FROM employees
WHERE name LIKE '%e';

--Select employee names which start with B, end with 't'
SELECT name
FROM employees
WHERE name LIKE 'B%t';

--Select employee names which has 'a' in any position
SELECT name
FROM employees
WHERE name LIKE '%a%';

--Select employee names which has 'u' and 'r' in any position
SELECT name
FROM employees
WHERE name LIKE '%r%u%' OR name LIKE '%u%r%';

--2) _ WildCard: It represents a single character

--Select state whose second character is 'e' and forth character is 'n'
SELECT state
FROM employees
WHERE state LIKE '_e_n%';

--Select state whose last second character is 'i'
SELECT state
FROM employees
WHERE state LIKE '%i_';

--Select 'states' whose second character is 'e' and it has at least 6 characters
SELECT state
FROM employees
WHERE state LIKE '_e____%';

--Select states which has 'i' in any position after second character
SELECT state
FROM employees
WHERE state LIKE '__%i%';

CREATE TABLE words
( 
  word_id CHAR(10) UNIQUE,
  word VARCHAR(50) NOT NULL,
  number_of_letters SMALLINT
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selena', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);

SELECT * FROM words;

--NOT LIKE Condition:

--Select words which do not have 'h' in any position
SELECT word
FROM words
WHERE word NOT LIKE '%h%';

--Select words which do not end with 't' and do not end 'f'
SELECT word
FROM words
WHERE word NOT LIKE '%t' AND word NOT LIKE '%f';--be carefull about using AND, because of the logic rules.

--Select words which start with any character, not followed by 'a', not followed by 'e'
SELECT word
FROM words
WHERE word NOT LIKE '_a%' AND word NOT LIKE '_e%';

--REGEXP_LIKE Condition: You can use Regular Expession with REGEXP_LIKE Condition

--Select words whose first character is 'h', last character is 't' and second character is 'o', or 'a' or 'i'
--1st Way:
SELECT word
FROM words
WHERE word LIKE 'ho%t' OR word LIKE 'ha%t' OR word LIKE 'hi%t';

--2nd Way: BY using REGEXP_LIKE
SELECT word
FROM words
WHERE REGEXP_LIKE(word, 'h[oai](.*)t'  ); 

--OR use ~

SELECT word
FROM words
WHERE word ~ 'h[oai](.*)t'; 

--Select words whose first character is 'h', last character is 't' and second character is from 'a' to 'e'
SELECT word
FROM words
WHERE word ~ 'h[a-e](.*)t'; --[a-e] ==> a,b,c,d,e

--Select words whose first character is 's' or 'a' or 'y'
SELECT word
FROM words
WHERE word ~ '^[say](.*)';--> ^ means first character when you use it before the brackets.

--Select words whose last character is 'm' or 'a' or 'f'
SELECT word
FROM words
WHERE word ~ '(.*)[maf]$';--> $ means last character when you use it after the brackets.


--Select words which have 'a' in any position
SELECT word
FROM words
WHERE word ~ '(.*)a(.*)';

SELECT word
FROM words
WHERE word ~ 'a';--> 'a' --> '(.*)a(.*)' ==> '%a%'


--Select words which have characters from 'd' to 't' at the beginning followed by any character then 'l'
SELECT word
FROM words
WHERE word ~ '^[d-t].l';--> . means one single character


--Select words which have characters from 'd' to 't' at the beginning followed by any 2 characters then 'e'
SELECT word
FROM words
WHERE word ~ '^[d-t]..e';


CREATE TABLE workers
(  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  salary SMALLINT,
  company VARCHAR(20)
);

INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');


SELECT * FROM workers;

--Select employee names which do not start with 'E' and do not end with 'y'
--1st Way:
SELECT name
FROM workers
WHERE name NOT LIKE 'E%y';

--2nd Way:
SELECT name
FROM workers
WHERE name ~ '^[^E](.*)[^y]$'; --> If you use ^ inside the brackets it means 'NOT'/'Different From'

--Select states whose third character is 'o' or 'x'
SELECT state
FROM workers
WHERE state ~ '..[ox]';

--Select states whose third character from the end is not 'n' or 'x'
SELECT state
FROM workers
WHERE state ~ '[^nx]..$';