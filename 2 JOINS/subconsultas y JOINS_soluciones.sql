------------------------------------------------------------------------------------------------
-- SELECT con suncolsultas y JOINS
------------------------------------------------------------------------------------------------
-- 1
-- Nombre y apellido del empleado que más gana.
select first_name, last_name
from employees
where salary = (
    select max(salary) 
    from employees);
-- 2
-- Nombre, apellido y salario de los empleados que ganan más que la media de salarios.
select first_name, last_name, salary
from employees
where salary > (
    select avg(salary) 
    from employees);
-- 3
-- Nombre y apellido del jefe del departamento de Marketing
select first_name, last_name
from employees
where employee_id = (
    select manager_id 
    from departments 
    where department_name='Marketing');
-- 4
-- Nombre y apellido  de los empleados del departamento de Marketing
select first_name, last_name
from employees
where department_id = (
    select department_id 
    from departments 
    where department_name = 'Marketing');
--
select 
    first_name, 
    last_name
from 
    employees
    join departments on employees.department_id = departments.department_id
where
    department_name = 'Marketing');
-- 5
-- Nombre, apellido, salario, nombre del departamento y ciudad
-- del empleado que gana más y el que menos
select 
    first_name, 
    last_name, 
    salary, 
    department_name, 
    city
from 
    employees
    join departments on employees.department_id = departments.department_id
    join locations on departments.location_id = locations.location_id
where 
    salary = (select max(salary) from employees)
    or salary = (select min(salary) from employees);
-- 6
-- Número de empleados y número de departamentos por ciudad (nombre)
select 
    locations.city,
    count(employee_id) count_employees,
    count(distinct departments.department_id) count_departments
from
    employees
    join departments on employees.department_id = departments.department_id
    join locations on departments.location_id = locations.location_id
group by
    locations.city;
-- 7
-- Número de empleados y número de departamentos de todas las ciudades (nombre)
-- ordenado por número de empleados descendentemente
select 
    locations.city,
    count(employee_id) count_employees,
    count(distinct departments.department_id) count_departments
from
    employees
    right join departments on employees.department_id = departments.department_id
    right join locations on departments.location_id = locations.location_id
group by
    locations.city
order by
    2 desc;
-- 8
-- Mostrar el número de empleado, nombre y apellido de los empleados
-- que sean jefes tanto como de departamento como de otro empleado
-- indicando en una sola columna con un literal 'DEP' si es jefe de departamento
-- y 'EMP' si es jefe de otro empleado. Ordenados por número de empleado.
select employee_id, first_name, last_name,'DEP' "Jefe"
from employees
where employee_id in (select manager_id from departments)
union
select employee_id, first_name, last_name, 'EMP' "Jefe"
from employees e
where employee_id in (select manager_id from employees)
order by 1;
-- 9
-- Listar el nombre, apellido y salario de los tres empleados que ganan más
select first_name, last_name, salary
from (select first_name, last_name, salary 
    from employees 
    order by salary desc)
where rownum < 4;
-- 10
-- Imaginad que queremos crear nombres de usuario para direcciones de correo.
-- Cuyo formato es la primera letra del nombre más el apellido.
-- Queremos saber si del listado de nombres y apellidos alguien coinciden
select 
    employees.first_name, 
    employees.last_name
from 
    employees 
    join 
        (select substr(first_name,1,1) first_letter, last_name
        from employees
        group by substr(first_name,1,1), last_name
        having count(*) > 1) morethanone  
    on(employees.last_name = morethanone.last_name 
        and morethanone.first_letter = substr(first_name,1,1));
-- 11
-- Listar nombre, apellido y un literal que indique el salario.
-- 'BAJO' si el salario es menor a la mediabaja (media entre el salario mínimo y la media de salarios)
-- 'ALTO' si el salario es mayor a la mediaalta (media entre el salario máximo y la media de salarios)
-- 'MEDIO' si el salario está entre la mediabaja y medialata.
select 
    first_name,
    last_name, 
    case  
        when salary < mediabaja then 'BAJO'
        when salary between mediabaja and mediaalta then 'MEDIO'
        else 'ALTO'
    end salary
from 
    employees 
    join (
        select department_id, 
            trunc((avg(salary)+min(salary))/2) mediabaja, 
            trunc((avg(salary)+max(salary))/2) mediaalta
        from employees
        group by department_id) medias
    on(employees.department_id = medias.department_id);
-- 12
-- Número de empleados dados de alta por día
-- entre dos fechas. Ej: entre 1997-10-10 y 1998-03-07
-- y para una o varias ciudades. Ej: Seattle, Rome
-- (Pensad que es una consulta que se va adaptar a variables
-- es decir, que las ciudades o el rango de fechas varia
-- en la parte visual de la aplicación se muestran desplegables
-- para escoger los valores, pero luego eso se reemplaza en la consulta)
-- Aquí usamos valores fijos de ejemplo.
select 
    count(employees.employee_id) count_employees,
    to_char(hire_date,'yyyy-mm-dd') day
from
    employees
    join departments on employees.department_id = departments.department_id
    join locations on departments.location_id = locations.location_id
where
    locations.city in ('Seattle','Rome')
    and hire_date 
        between to_date('1997-10-10','yyyy-mm-dd') 
        and to_date('1998-03-07','yyyy-mm-dd')
group by
    to_char(hire_date,'yyyy-mm-dd')
order by
    day asc;
-- 13
-- Un listado en el que se indique en líneas separadas
-- una etiqueda que describa el valor y como valor:
-- el número de empleados en Seattle, 
-- el número de departamentos con empleados en Seattle
-- el número de departamentos sin empleados en Seattle
-- el número de jefes de empleado en Seattle
-- el número de jefes de departamento en Seattle
select 
    'count_employees' Label,
    count(employee_id) Value
from
    employees
    join departments on employees.department_id = departments.department_id
    join locations on departments.location_id = locations.location_id
where
    locations.city = 'Seattle'
union
select 
    'count_departments_has_employees' Label,
    count(distinct departments.department_id) Value
from
    employees
    join departments on employees.department_id = departments.department_id
    join locations on departments.location_id = locations.location_id
where
    locations.city = 'Seattle'
union
select 
    'count_departments_hasnot_employees' Label,
    count(departments.department_id) Value
from
    employees
    right join departments on employees.department_id = departments.department_id
    left join locations on departments.location_id = locations.location_id
where
    locations.city = 'Seattle'
    and employees.department_id is null
union
select 
    'count_managers_employees' Label,
    count(distinct employees.manager_id) Value
from
    employees
    join departments on employees.department_id = departments.department_id
    join locations on departments.location_id = locations.location_id
where
    locations.city = 'Seattle'
union
select 
    'count_managers_departments' Label,
    count(distinct departments.manager_id) Value
from
    departments
    join locations on departments.location_id = locations.location_id
where
    locations.city = 'Seattle';
-- 14
-- Nombre, apellido, email, department_name
-- de los empleados del departamento con más empleados
select 
    employees.first_name, 
    employees.last_name, 
    employees.email, 
    departments.department_name
from 
    employees
    join departments on employees.department_id = departments.department_id
where
    employees.department_id in (
        select department_id
        from employees
        group by department_id
        having count(employee_id) = (
            select max(count_employees)
            from (
                select count(employee_id) count_employees
                from employees
                group by department_id
                )
            )
        );
--
select 
    employees.first_name, 
    employees.last_name, 
    employees.email, 
    departments.department_name
from 
    employees
    join departments on employees.department_id = departments.department_id
where
    employees.department_id in (
        select department_id
        from employees
        group by department_id
        having count(employee_id) = (
            select max(count(employee_id))
            from employees
            group by department_id
            )
        );
-- 15
-- Cuál es la fecha en la que más empleados
-- se han dado de alta
select to_char(hire_date,'yyyy-mm-dd') day_more_hire
from employees
group by to_char(hire_date,'yyyy-mm-dd')
having count(employee_id) in (
    select max(count(employee_id))
    from employees
    group by to_char(hire_date,'yyyy-mm-dd')
    );
------------------------------------------------------------------------------------------------
