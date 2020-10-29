#UNION vs UNION ALL

# UNION ALL --> used to combine a few SELECT statments in a single output = like a tool to unify tables

# SELECT N columns 
# FROM table_1
# UNION ALL SELECT N columns
# FROM table_2;                     #temos de escolher o mesmo número de colunas e com o mesmo nome, na mesma ordem e mesmo tipos de dados


# UNION  --> devolve só os valores distintos. o UNION ALL devolve esses e os duplicados

# SELECT N columns
# FROM table_1
# UNION SELECT N columns
# FROM table_2;


 SELECT

    *

FROM

    (SELECT

        e.emp_no,

            e.first_name,

            e.last_name,

            NULL AS dept_no,

            NULL AS from_date

    FROM

        employees e

    WHERE

        last_name = 'Denis' UNION SELECT

        NULL AS emp_no,

            NULL AS first_name,

            NULL AS last_name,

            dm.dept_no,

            dm.from_date

    FROM

        dept_manager dm) as a

ORDER BY -a.emp_no DESC;