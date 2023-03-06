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
