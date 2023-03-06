--SQL CHALLENGE
--Create a table schema for each of the six CSV files. 
--Specify the data types, primary keys, foreign keys, and other constraints.
--For the primary keys, verify that the column is unique. Otherwise, create a composite keyLinks to an external site., which takes two primary keys to uniquely identify a row.
--Create the tables in the correct order to handle the foreign keys.

CREATE TABLE employees(
	emp_no INTEGER PRIMARY KEY,
	emp_title_id VARCHAR,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE
);

CREATE TABLE titles(
	title_id VARCHAR PRIMARY KEY,
	title VARCHAR
);

CREATE TABLE salaries(
	emp_no INTEGER PRIMARY KEY,
	salary INTEGER
);

CREATE TABLE departments(
	dept_no VARCHAR PRIMARY KEY,
	dept_name VARCHAR
);

CREATE TABLE dept_emp(
	emp_no INTEGER,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR,
	emp_no INTEGER PRIMARY KEY
);

--Import each CSV file into its corresponding SQL table.

--Data Analysis
--1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary FROM employees as e
INNER JOIN salaries as s
ON e.emp_no = s.emp_no;

--2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--3.List the [[[[manager of each department???]]] along with their department number, department name, 
--employee number, last name, and first name.
SELECT employees.emp_title_id, dept_manager.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM employees
INNER JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
INNER JOIN departments ON departments.dept_no = dept_manager.dept_no;

--4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT dept_manager.dept_no, dept_manager.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_manager
INNER JOIN employees ON employees.emp_no = dept_manager.emp_no
INNER JOIN departments ON departments.dept_no = dept_manager.dept_no;

--5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6. List each employee in the Sales department, including their employee number, last name, and first name. *** DISCUSS DIFF BETW DEPT TABLES
SELECT e.emp_no, e.last_name, e.first_name FROM employees as e
INNER JOIN dept_emp ON dept_emp.emp_no = e.emp_no
WHERE dept_emp.dept_no = 'd007';

--7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, departments.dept_name FROM employees as e
INNER JOIN dept_emp ON dept_emp.emp_no = e.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE (dept_emp.dept_no = 'd007') or (dept_emp.dept_no = 'd005');

--8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name as "Last Name", 
	COUNT(last_name) as "Count of Last Name"
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

---------DELETE BELOW THIS LINE -------
-- One to one
-- Simpson table
CREATE TABLE simpsons(
  id SERIAL,
  name VARCHAR,
  "Social Security" INTEGER
);

INSERT INTO simpsons (name, "Social Security")
VALUES
  ('Homer', 111111111),
  ('Marge', 222222222),
  ('Lisa', 333333333),
  ('Bart', 444444444),
  ('Maggie', 555555555);

-- One to Many
-- Address Table
CREATE TABLE address (
  id INTEGER PRIMARY KEY,
  address VARCHAR
);

-- Insertion query for address table
INSERT INTO address (id, address)
VALUES
  (11, '742 Evergreen Terrace'),
  (12, '221b Baker Streer');

-- People Table
CREATE TABLE people (
  id INTEGER PRIMARY KEY,
  name VARCHAR,
  social_security INTEGER,
  address_id INTEGER
);

-- Insertion query for people table
INSERT INTO people (id, name, social_security)
VALUES
  (1, 'Homer', 111111111),
  (2, 'Marge', 222222222),
  (3, 'Lisa', 333333333),
  (4, 'Bart', 444444444),
  (5, 'Maggie', 555555555),
  (6, 'Sherlock', 666666666),
  (7, 'Watson', 777777777);

-- Many to Many
-- Table schema for the Simpsons children
CREATE TABLE children(
  child_id SERIAL,
  child_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (child_id)
);

-- Insertion queries for the Simpsons children
INSERT INTO children (child_name)
VALUES
  ('Bart'),
  ('Lisa'),
  ('Maggie');

-- Table schema for the Simpsons parents
CREATE TABLE parents(
  parent_id INTEGER NOT NULL,
  parent_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (parent_id)
);

-- Insertion queries for the Simpsons parents
INSERT INTO parents (parent_id, parent_name)
VALUES
  (11, 'Homer'),
  (12, 'Marge');

-- Table schema for the junction table
CREATE TABLE child_parent (
  child_id INTEGER NOT NULL,
  FOREIGN KEY (child_id) REFERENCES children(child_id),
  parent_id INTEGER NOT NULL,
  FOREIGN KEY (parent_id) REFERENCES parents(parent_id),
  PRIMARY KEY (child_id, parent_id)
);

-- Insertion queries for the junction table
INSERT INTO child_parent (child_id, parent_id)
VALUES
  (1, 11),
  (1, 12),
  (2, 11),
  (2, 12),
  (3, 11),
  (3, 12);
  
 SELECT * FROM child_parent;