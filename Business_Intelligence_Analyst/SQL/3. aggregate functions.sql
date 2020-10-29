#Aggregate functions

select count(emp_no)
from employees;

select count(distinct first_name)    #conta o número de nomes distintos na tabela
from employees;
#função count não inclue os NULL values

select * from salaries;

select count(*)
from salaries
where salary >= 100000;

select count(*)
from dept_manager;

select *
from employees
order by first_name desc;

select *
from employees
order by emp_no;

select *
from employees
order  by first_name, last_name ASC;  #ordenar as pessoas por 1º nome e depois por apelido

select *
from employees
order by hire_date desc;


#GROUP BY tem de estar imediatamente DEPOIS das WHERE conditions e, caso haja, ANTES das ORDER BY clauses!!!
# SELECT column_name(s)
# FROM table_name 
# WHERE conditions
# GROUP BY column_name(s)
# ORDER BY column_name(s);

select first_name, count(first_name) as name_count
from employees
group by first_name
order by first_name desc;

#Salários maiores do que $80.000 e o número de empregados que ganham o mesmo salário
select salary, count(emp_no) as emp_with_same_salary
from salaries
where salary >80000
group by salary
order by salary;

# HAVING tem de estar entre o GROUP BY e o ORDER BY
# HAVING = WHERE mas para o GROUP BY. Depois do having posso ter funções de agregação

select first_name, count(first_name) as name_count
from employees
# where count(first_name)>250 # isto está mal, não posso ter where e depois uma agregação 
group by first_name
having count(first_name)>250 #assim corrijo a linha acima
order by first_name desc;  

select emp_no, avg(salary)
from salaries
group by emp_no
having avg(salary)>120000;
