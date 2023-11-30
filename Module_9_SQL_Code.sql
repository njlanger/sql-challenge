-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/

--Creating 'departments'table
CREATE TABLE "departments" (
    "dept_no" varchar(255)   NOT NULL,
    "dept_name" TEXT   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

--Creating 'dept_emp'table
CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" varchar(255)   NOT NULL,
     PRIMARY KEY (
        "emp_no"
     )
);

--Creating 'dept_manager'table
CREATE TABLE "dept_manager" (
    "dept_no" varchar(255)   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

--Creating 'employees'table
CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" varchar(255)   NOT NULL,
    "bith_date" DATE   NOT NULL,
    "first_name" TEXT   NOT NULL,
    "last_name" TEXT   NOT NULL,
    "sex" varchar(255)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

--Creating 'salaries'table
CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

--Creating 'titles'table
CREATE TABLE "titles" (
    "emp_title_id" varchar(255)   NOT NULL,
    "title" TEXT   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "emp_title_id"
     )
);

--All data was imported to the respective tables via the 'Imort/Export Data' tool

-- Creating a new table containing all 6 tables
CREATE TABLE combined_table AS
SELECT
    e.emp_no,
    e.birth_date,
    e.first_name,
    e.last_name,
    e.sex,
    e.hire_date,
    d.dept_no AS department_no,
    d.dept_name AS department_name,
    s.salary,
    t.emp_title_id,  
    t.title
FROM
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
JOIN
    departments d ON de.dept_no = d.dept_no
LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no AND de.dept_no = dm.dept_no
LEFT JOIN
    salaries s ON e.emp_no = s.emp_no
LEFT JOIN
    titles t ON e.emp_title_id = t.emp_title_id;


--View the data in the newly created 'combined_table' sorting by emp_no
SELECT * FROM combined_table
ORDER BY emp_no

--List the employee number, last name, first name, sex, and salary of each employee.
SELECT 
	emp_no,
	last_name,
	first_name,
	sex,
	salary
FROM combined_table
--Results: 268,445 employees.
	
--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT 
	first_name,
	last_name,
	hire_date	
FROM 
	combined_table
WHERE 
	EXTRACT(YEAR FROM hire_date) = 1986	
--Results: 32,295 employees hired in 1986

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT 
	department_no,
	department_name,
	emp_no,
	last_name,
	first_name	
FROM 
	combined_table
WHERE 
	title = 'Manager'
ORDER BY department_no
--Results: 24 managers listed, some departments had more than one manager.

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT
	department_no,
	emp_no,
	last_name,
	first_name,	
	department_name
FROM 
	combined_table
--Results: 268,445 employees.	
	
--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT
	first_name,
	last_name, 
	sex
FROM 
	combined_table
WHERE
first_name = 'Hercules' 
AND last_name LIKE 'B%'
--Results: 18 employees match this requirement.

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT
	emp_no,
	last_name,
	first_name
FROM 
	combined_table
WHERE
department_name = 'Sales' 
--Results: 45,146 employees in the sales department.

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
	emp_no,
	last_name,
	first_name,
	department_name
FROM 
	combined_table
WHERE
department_name IN ('Sales', 'Development')
--Results: 119,446 employees are in eitherthe sales or Development departments.

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT
	last_name,
	COUNT(*) AS frequency
FROM 
	combined_table
GROUP BY
	last_name
ORDER BY
	frequency DESC,last_name
----Results: 1,638 unique last names.