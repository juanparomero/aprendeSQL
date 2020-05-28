------------------------------------------------------------------------------------------------
-- SELECTS SIMPLES
------------------------------------------------------------------------------------------------
-- 1
-- Describir la tabla employees
desc employees;
--
-- 2
-- Datos de la tabla regions
select *
from regions;
-- 3
-- Datos de la tabla countries
select *
from countries;
-- 4
-- Ciudad y estado de las localidades
select city, state_province
from locations;
-- 5
-- Número y nombre de departamento, además, el código del empleado jefe,
-- de la localidad 1700.
select department_id, department_name, manager_id
from departments
where location_id = 1700;
-- 6
-- Nombre y número de departamento de los empleados.
select first_name, department_id
from employees;
-- 7
-- Listar los distintos números de departamento en el que trabajan los empleados.
select distinct department_id
from employees;
-- 8
-- Nombre, apellido y salario ordenado por apellido ascendentemente y salario descendentemente
select first_name, last_name, salary
from employees
order by last_name asc, salary desc;
-- 9
-- códigos de los distintos trabajos que existen en el departamento 30
select distinct job_id
from employees
where department_id = 30;
-- 10
-- Nombre, apellido y correo de los empleados del departamento 30
-- cuyo salario es menor a 3000
select first_name, last_name, email
from employees
where department_id = 30
    and salary < 3000;
-- 11
-- nombre, apellido y número de departamento de los empleados
-- que no tengan comisión. Ordenados por número de departamento 
-- del mayor a menor y por apellido.
select first_name, last_name, department_id
from employees
where commission_pct is not null
order by 3 asc, 2 desc;
-- 12
-- Número de empleado, nombre y apellido de los empleados
-- desde el apellido que empieza por L hasta los que su apellido
-- empieza por la R, incluidos.
select employee_id, first_name, last_name
from employees
where last_name between 'L' and 'R';
-- 13
--Lista de apellidos que su segunda letra sea una 'a'
select last_name
from employees
where last_name like '_a%';
-- 14
-- Nombre, apellido y el salario de los empleados
-- pero como salario una etiqueta que indique 
-- 'BAJO' si es menor a 4280, 'ALTO' si es mayor a 15230
-- y 'MEDIO' si está entre medias
select first_name,last_name, 
    case  
        when salary < 4280 then 'BAJO'
        when salary between 4280 and 15230 then 'MEDIO'
        else 'ALTO'
    end salary
from employees;
--15
--Listar los correos concatenados con el texto '@company.com'
select email || '@company.com'
from employees;
--16
--Lista de nombres de las ciudades que su país es 'US'
select city
from locations
where country_id = 'US';
--17
--Lista de nombre de las ciudades que su país no es Estados Unidos
select city
from locations
where country_id != 'US';
--18
--Número y nombre de los departamentos que tienen un jefe.
select department_id, department_name
from departments
where manager_id is not null;
--19
--Número y nombre de los departamentos que no tienen jefe.
select department_id, department_name
from departments
where manager_id is null;
--20
-- Nombre de las columnas de la tabla de empleados 'Employees' que no tienen un guión bajo en el nombre.
select column_name
from user_tab_columns
where table_name = 'EMPLOYEES'
    and column_name not like '%@_%' escape '@';
--
------------------------------------------------------------------------------------------------
