USE employees; 

DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN 
		select *
        from employees
        limit 1000;
END $$

DELIMITER ;

CALL employees.select_employees();

CALL select_employees();

DELIMITER $$
CREATE PROCEDURE avg_salary_employees()
BEGIN 
	select emp_no, avg(salary) as average_salary
    from salaries
    group by emp_no
    order by emp_no;
END$$

call avg_salary_employees();

DELIMITER $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
	SELECT 
		e.first_name, e.last_name, s.salary, s.from_date, s.to_date
	FROM employees e
		JOIN 
		salaries s on e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no;
END$$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary(in p_emp_no INTEGER, out p_avg_salary DECIMAL(10,2))
BEGIN
	SELECT 
		avg(s.salary)
	INTO p_avg_salary FROM						#SEMPRE QUE SE CRIA UM PROCEDURE COM IN E OUT PARAMETERS TEMOS DE USAR A ESTRUTURA SELECT-INTO
		employees e 
			JOIN 
		salaries s on e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no;
END$$

DELIMITER ;

SET @v_emp_no = 0;
CALL emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;


DELIMITER $$

CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)
BEGIN
                DECLARE v_max_from_date date;
    DECLARE v_salary decimal(10,2);
                SELECT
    MAX(from_date)
INTO v_max_from_date FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;
                SELECT
    s.salary
INTO v_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name
        AND s.from_date = v_max_from_date;      
                RETURN v_salary;
END$$

DELIMITER ;

SELECT EMP_INFO('Aruna', 'Journel');

