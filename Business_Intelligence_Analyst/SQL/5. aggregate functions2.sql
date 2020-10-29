#Aggregate functions --> junta dados de várias linhas (input) e agregam num valor único (output)

# Count(Distinct ) --> diz-nos o número de vezes que valores únicos estão representados numa coluna

# Count(*) --> retorna os valores de todas as linhas, incluindo as NULAS 

select count(distinct dept_no)
from dept_emp;

select sum(salary)
from salaries;

#Sum(*) não funciona! o * só funciona bem com a função count()

#What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?
select * from salaries;
select sum(salary)
from salaries
where from_date >= '1997-01-01';

select * from employees;
select max(emp_no) as max, min(emp_no) as min 
from employees;

select avg(salary)
from salaries
where from_date >= '1997-01-01';

## round(#,casas decimais)
select round(avg(salary),2) from salaries;

#Round the average amount of money spent on salaries for all contracts that started after the 1st of January 1997 to a precision of cents.
select round(avg(salary),2) as média_salários
from salaries
where from_date > '1997-01-01';
