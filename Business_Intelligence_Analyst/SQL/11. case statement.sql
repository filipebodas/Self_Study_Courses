SELECT	emp_no, first_name, last_name
CASE gender
WHEN 'M' THEN 'Male' ELSE 'Female'
END AS gender
FROM employees;
    

    SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;
    
SELECT
    dm.emp_no,  
    e.first_name,  
    e.last_name,  
    MAX(s.salary) - MIN(s.salary) AS salary_difference,  
    CASE  
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'  
        ELSE 'Salary was NOT raised by more then $30,000'  
    END AS salary_raise  
FROM  
    dept_manager dm  
        JOIN  
    employees e ON e.emp_no = dm.emp_no  
        JOIN  
    salaries s ON s.emp_no = dm.emp_no  
GROUP BY s.emp_no;


SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;