------------------------------------------------------------------------------------------------
-- SELECT CON suncolsultas y JOINS
------------------------------------------------------------------------------------------------
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

-- Listar el nombre, apellido y salario de los tres empleados que ganan más
select first_name, last_name, salary
from (select first_name, last_name, salary from employees order by salary desc)
where rownum < 4;

-- Listar nombre, apellido de los empleados que les coindice a la vez
-- la primera letra de su nombre y el apellido
select first_name, employees.last_name last_name, email
from employees 
    join 
        (select substr(first_name,1,1) letrainicial, last_name
        from employees
        group by substr(first_name,1,1), last_name
        having count(*) > 1) correos  
    on(employees.last_name = correos.last_name 
        and correos.letrainicial = substr(first_name,1,1));

-- Listar nombre, apellido y un literal que indique el salario.
-- 'BAJO' si el salario es menor a la mediabaja (media entre el salario mínimo y la media de salarios)
-- 'ALTO' si el salario es mayor a la mediaalta (media entre el salario máximo y la media de salarios)
-- 'MEDIO' si el salario está entre la mediabaja y medialata.
select first_name,last_name, 
    case  
        when salary < mediabaja then 'BAJO'
        when salary between mediabaja and mediaalta then 'MEDIO'
        else 'ALTO'
    end salary
from employees 
    join (select department_id, trunc((avg(salary)+min(salary))/2) mediabaja, trunc((avg(salary)+max(salary))/2) mediaalta
        from employees
        group by department_id) medias
    on(employees.department_id = medias.department_id);
--
------------------------------------------------------------------------------------------------