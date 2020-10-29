#SUBQUERIES

# Seleccionar o primerio e último nome da tabela "Employees", para os mesmos números de emregados
# que podemos encontrar na tabela "Department Managers"
# ou seja, o emp_no têm de corresponder nas duas tabelas

select e.first_name, e.last_name 
from employees e 
where  									#esta clause do where diz-nos que os emp_no têm de ser iguais nas duas tabelas
	e.emp_no in (select
				dm.emp_no
				from dept_manager dm);           

#The outer query is the entire code, starting from select first_name and last_name until the IN operator
#The subquery or inner query begins from (SELECT dm.emp_no until...dept_manager dm)
#The subquery têm de estar sempre entre ()

#1) The SQL começa sempre por correr a inner query 
#2) Depois, utiliza o output para executar a outer query


#Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');
            

#EXITS --> verifica se determinadas linhas se encontram numa subquery. Devolve um Boolean value
# Se a linha existe no subquery, devolve true e extrair o valor da query; Caso contrário devolve False e não extrai nada

select e.first_name, e.last_name 
from employees e 
where
exists( select *
from dept_manager dm
where dm.emp_no	= e.emp_no);

#Quais são as diferenças entre o IN e o EXISTS??
# EXISTS teste se existem valores nas linhas  |  IN procura entre os valores
# EXITS mais rápido a extrair quantidades maiores de dados  |  IN mais rápido com subsets mais pequenos

#Select the entire information for all employees whose job title is “Assistant Engineer”.
select *
from employees e
where exists( 
select *
from titles t
where e.emp_no = t.emp_no and t.title = 'Assistant Engineer'); 

#Assign employee number 110022 as a manager to all employees from 10001 to 10020, and employee number 110039 as a manager to all 
# employees from 10021 to 10040. 

#employees 10001-10020 = subsetA  |   employees 10021-10040 = subsetB  |  subsetA UNION subset B 
#Vamos começar pelo innerquery mais "profundo"

select dept_no from dept_manager
where emp_no = '110022';          # agora vamos juntar isto ao SELECT do outer query
---------------------------------------------------------------------------------------------------
select subsetA.* from
(select e.emp_no as employee_ID, min(de.dept_no) as department_code,  #o min garante que só se usa um dept_no por empregado, porque há repetidos
	(select dept_no from dept_manager
	where emp_no = '110022') as manager_ID
from employees e
join dept_emp de on e.emp_no = de.emp_no
where e.emp_no <= 10020
group by e.emp_no
order by e.emp_no) as subsetA;      #pôr () no outer query e chamar-lhe subsetA e fazer um select all a esse subset = criar subset A  
---------------------------------------------------------------------------------------------------
SELECT 
    subsetA.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
		MIN(de.dept_no) AS department_code,
            (SELECT 
                    dept_no
                FROM
                    dept_manager
                WHERE
                    emp_no = '110022') AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS subsetA
UNION SELECT 
    subsetB.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
		MIN(de.dept_no) AS department_code,
            (SELECT 
                    dept_no
                FROM
                    dept_manager
                WHERE
                    emp_no = '110039') AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no >= 10021
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS subsetB;


DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager (

   emp_no INT(11) NOT NULL,

   dept_no CHAR(4) NULL,

   manager_no INT(11) NOT NULL

);

#EXERCÍCIO FINAL - Fill emp_manager with data about employees, the number of the department they are working in, and their managers.
INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;

select *
from emp_manager
order by emp_no;