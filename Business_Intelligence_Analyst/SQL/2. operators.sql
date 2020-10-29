-- SELECT column_1, column_2, ... column_n
-- FROM table_name
-- WHERE condition;

-- OPERADORES que são usados com a WHERE clause
## AND;  OR;  IN;  NOT IN;  LIKE;  NOT LIKE;  BETWEEN..AND..;  
## EXISTS;  NOT EXISTS;  IS NULL;  IS NOT NULL;  Comparison operators;  etc..  

SELECT *
from employees
where first_name = 'Denis';

SELECT *
FROM employees
WHERE first_name = 'Elvis';

select *
from employees
where first_name = 'Denis' and gender = 'M';

## AND - condições em diferentes colunas
## OR - condições na mesma coluna

select *
from employees
where first_name = 'Kellie' or first_name = 'Aruna';

##SQL LOGICAL OPERATOR PRECEDENCE
## SQL will always run the operator AND over the operator OR
## AND > OR

select * from employees
where first_name = 'Denins' AND gender = 'M' or gender = 'F';  #segue a lógica de precedência. Corrigir com ()

select * 
from employees
where first_name = 'Denis' AND (gender = 'M' or gender = 'F'); #aqui já defino 2 condições simultâneas condição 1 AND (condição 2); 

select *
from employees
where gender='F' AND (first_name = 'Kellie' or first_name = 'Aruna');

## Operador IN permite tirar mais do que 2 objetos de uma coluna, solução mais elegante do que pôr muitos OR
select *
from employees
where first_name in ('Cathie', 'Mark', 'Nathan');

select *
from employees
where first_name in ('Denis', 'Elvis');

select * 
from employees
where first_name not in ('Jacob', 'John', 'Mark');

select *
from employees
where first_name like ('mark%');   #o % indica que pode vir uma sucessão de caracteres quaisquer

select * 
from employees
where hire_date like ('%2000%');

select *
from employees
where emp_no like ('1000_');  #aqui só estou a admitir um só número depois do 1000

select * 
from employees
where hire_date between '1990-01-01' and '2000-01-01';  #um intervalo

select * 
from employees
where hire_date between '1990-01-01' and '2000-01-01';  #dois intervalos - antes de 1990 e depois de 2000

select *
from salaries;

select * 
from salaries
where salary between 66000 and 70000;

select *
from salaries
where emp_no not between '10004' and '10012';

select *
from departments;

select * 
from departments
where dept_no between 'd003' and 'd006';

# IS NOT NULL - para extrair valores que não são nulos

select *
from departments
where dept_no is not null;

select *
from employees
where gender = 'F' and hire_date >= '2000-01-01';

select *
from salaries
where salary > 150000;

#DISTINCT só mostrar os valores distintos numa coluna
select distinct gender
from employees;

select distinct hire_date
from employees;


 

