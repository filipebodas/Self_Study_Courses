#JOINS

# INNER JOIN = JOIN = interseção de dois conjuntos, que vai ter as colunas em comum

select * from dept_manager_dup order by dept_no; #faltam valores relativamentes aos dados do dept_no d001

select * from departments_dup; #faltam dados sobre d002; d010 e d011 não têm nomes

#--------------------------------------------------------------------------------------------------------------------#

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

#INNER JOIN NÃO APRESENTAM NULL VALUES

select e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
from employees e inner join dept_manager dm on e.emp_no = dm.emp_no
order by e.emp_no;  

#ver se há duplicados -- agrupar as joins pela coluna que difere mais entre os registos
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dup d ON m.dept_no = d.dept_no
group by m.emp_no #agrupar pelo número de empregado, porque são os valores que mais diferem, comparado com as outras 2 colunas
ORDER BY m.dept_no;

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
left JOIN departments_dup d ON m.dept_no = d.dept_no
group by m.emp_no 
ORDER BY m.dept_no;

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
left JOIN departments_dup d ON m.dept_no = d.dept_no
where dept_name is null
ORDER BY m.dept_no;

select e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
from employees e left join dept_manager dm on
e.emp_no = dm.emp_no
where e.last_name like('Markovitch')
order by dept_no desc, emp_no;

select e.emp_no, e.first_name, e.last_name, e.hire_date, t.title 
from employees e left join titles t on
	e.emp_no = t.emp_no
where first_name = 'Margareta' and last_name = 'Markovitch'
order by e.emp_no;

# CROSS JOIN liga todos os valores, além dos que correspondem 
# Difere do JOIN que só liga os valores que fazem correspondência entre si
# CROSS JOIN é útil quando as tabelas não estão bem ligadas

# CROSS JOIN = INNER JOIN 
# JOIN + ON clause = CROSS JOIN + WHERE clause

select * from dept_manager;
select * from departments;

select dm.*, d.*
from dept_manager dm
cross join departments d
order by dm.emp_no, d.dept_no;  #LIGOU TODOS OS VALORES DAS DUAS TABELAS ENTRE SI (24 linhas * 9 linhas = 216 linhas)

select dm.*, d.*
from dept_manager dm
join departments d
order by dm.emp_no, d.dept_no;  #MESMO RESULTADO QUE DEU EM CIMA -- 216 linhas (não tem o ON)

# Escrever JOIN SEM	ON não é a melhor prática. 
# Daí o CROSS JOIN ser uma melhor prática de escrita e mais claro no que se pretende

select dm.*, d.*
from departments d
join dept_manager dm
where d.dept_no <> dm.dept_no
order by dm.emp_no, d.dept_no; #ESTE EXEMPLO É IMPORTANTE!!! Retira os managers da lista

select e.*, d.*
from departments d
cross join dept_manager dm
join employees e on dm.emp_no = e.emp_no
order by dm.emp_no, d.dept_no;

#Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9
select dm.*, d.*
from departments d 
cross join dept_manager dm 
where d.dept_no = 'd009'
order by d.dept_name;

select e.*, d.*
from employees e 
cross join departments d 
where e.emp_no < 10011
order by e.emp_no, d.dept_name; 

#Find the average salary of men and women
select e.gender, avg(salary) as average_salary
from employees e join salaries s 
on e.emp_no = s.emp_no
group by e.gender;

#JOIN more than two tables

select e.first_name, e.last_name, e.hire_date, m.from_date, d.dept_name
from employees e 
join dept_manager m on e.emp_no = m.emp_no
join departments d on m.dept_no = d.dept_no;

select e.first_name, e.last_name, e.hire_date, t.title, t.from_date, d.dept_name
from employees e join titles t on e.emp_no = t.emp_no
left join dept_manager dm on e.emp_no = dm.emp_no
join departments d on dm.dept_no = d.dept_no
where t.title = 'Manager'
order by e.first_name, e.last_name;


#TIP
# joins --> one should look for key columns, common betwen tables, but not necessary needed to solve our task
#           these columns do not need to be foreign or private keys

select d.dept_name, avg(salary) as average_salary
from departments d 
join dept_manager m on d.dept_no = m.dept_no
join salaries s on m.emp_no = s.emp_no  #só deu uma linha ---> porque não agrupei com group by abaixo
group by d.dept_name 
order by d.dept_no; #posso ordernar ainda que não esteja no select

select e.gender, count(dm.emp_no)
from employees e 
join dept_manager dm on e.emp_no = dm.emp_no
group by e.gender;