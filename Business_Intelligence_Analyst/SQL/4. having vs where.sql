#WHERE VS HAVING

#extrai uma lista de nomes que são encontrados menos de 200 vezes.   FUNÇÃO COUNT() --> AGREG --> HAVING
#tem que ser referentes a pessoas contratadas depois de 1 janeiro de 1999   REFERE-SE A TODAS AS LINHAS --> WHERE

select first_name, count(first_name) as name_count
from employees
where hire_date > '1999-01-01'
group by first_name
having count(first_name)<200
order by first_name desc;

select *
from dept_emp;

select emp_no, count(dept_no) as number_contracts
from dept_emp
where from_date>'2000-01-01'
group by emp_no
having number_contracts > 1;

SELECT emp_no
FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

select *
from dept_emp
limit 100;