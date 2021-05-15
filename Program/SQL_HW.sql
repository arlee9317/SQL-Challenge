create table departments(
dept_no varchar (25),
dept_name varchar (25)
)


create table dept_emp(
emp_no integer,
dept_no varchar (25),
from_date date NOT NULL,
to_date date NOT NULL
)


create table dept_manager(
dept_no varchar (25),
Manager_no integer,
from_date date NOT NULL,
to_date date NOT NULL
)


create table employees(
emp_no integer,
birth_date date NOT NULL,
first_name varchar(15),
last_name varchar(25),
gender varchar(1),
hire_date date NOT NULL	
)


create table salaries(
emp_no integer,
salary integer,
from_date date NOT NULL,
to_date date NOT NULL
)


create table titles(
emp_no integer,
title varchar(30),
from_date date NOT NULL,
to_date date NOT NULL	
)


--details of each employee: employee number, last name, first name, sex, and salary
SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary FROM employees e
JOIN salaries s
USING (emp_no)

--first name, last name, and hire date for employees who were hired in 1986
SELECT e.first_name, e.last_name, e.gender, e.hire_date FROM employees e
WHERE e.hire_date BETWEEN '1986-01-01' AND '1986-12-31'

-- manager of each department with the following information: department number, department name, the manager's employee number, last name, first name
SELECT DISTINCT ON(dm.manager_no) dm.manager_no, dm.dept_no, d.dept_name, e.last_name, e.first_name FROM employees e
JOIN dept_emp de
USING (emp_no)
JOIN dept_manager dm
USING (dept_no)
JOIN departments d
USING (dept_no)
GROUP BY (dm.dept_no, d.dept_name, dm.manager_no, e.last_name, e.first_name)

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name FROM employees e
JOIN dept_emp de
USING (emp_no)
JOIN departments d
USING (dept_no)
GROUP BY (e.emp_no, d.dept_name)

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, gender FROM employees
WHERE first_name = 'Hercules' AND last_name like 'B%'

--List all employees in the Sales department, including their employee number, last name, first name, and department name
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.last_name, e.first_name, d.dept_name FROM employees e
JOIN dept_emp de
USING (emp_no)
JOIN departments d
USING (dept_no)
WHERE d.dept_name = 'Sales'

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.last_name, e.first_name, d.dept_name FROM employees e
JOIN dept_emp de
USING (emp_no)
JOIN departments d
USING (dept_no)
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name

SELECT COUNT(last_name), last_name FROM employees
GROUP BY last_name
ORDER BY last_name DESC

