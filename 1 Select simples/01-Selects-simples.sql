------------------------------------------------------------------------------------------------
-- SELECTS SIMPLES
------------------------------------------------------------------------------------------------
-- 1
-- Describir la tabla employees
desc employees;
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
-- Nombre, apellido, salario ordenador por apellido asc y salario desc
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
-- que no tengan comisión ordenados por número de departamento 
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
-- Nombre de las columnas de la tabla de empleados 'Employees'
select column_name
from user_tab_columns
where table_name = 'EMPLOYEES'
    and column_name not like '%@_%' escape '@';
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
--
--
------------------------------------------------------------------------------------------------
