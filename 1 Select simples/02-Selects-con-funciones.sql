------------------------------------------------------------------------------------------------
# SELECT CON FUNCIONES
------------------------------------------------------------------------------------------------
/*
 1
 Mostrar la fecha actual de la siguiente forma:
 Fecha actual
 ------------------------------
 Sábado, 11 de febrero de 2017. 16:06:06

 El día en palabras con la primera letra en mayúsculas, seguida de una coma, el día en números,
 la palabra "de", el mes en minúscula en palabras, la palabra "de", el año en cuatro dígitos
 finalizando con un punto. Luego la hora en formato 24h con minutos y segundos.
 Y de etiqueta del campo "Fecha actual".
*/
select rtrim(to_char(sysdate,'Day'))||', '||
    to_char(sysdate,'dd')||' de '||
    rtrim(to_char(sysdate,'month'))|| ' de '||
    to_char(sysdate,'yyyy')||'. '||to_char(sysdate,'hh24:mi:ss')  "Fecha actual"
from dual;
-- 2
-- Dia en palabras en el cual naciste
select rtrim(to_char(to_date('12/06/1987','dd/mm/yyyy'), 'Day')) "Dia de nacimiento"
from dual;
-- 3
-- La suma de salarios, cuál es el mínimo, el máximo y la media de salario
select sum(salary), min(salary), max(salary), avg(salary)
from employees;
-- 4
-- Cuántos empleados hay, cuántos tienen salario y cuántos tienen comisión.
select count(*), count(salary), count(commission_pct)
from employees;
-- 5
-- Por un lado la media entre la media de salarios y el mínimo salario
-- Y por otro lado, la media entre la media de salarios y el máximo salario
-- Solo la parte entera, sin decimales ni redondeo.
select trunc((avg(salary)+min(salary))/2) mediabaja, trunc((avg(salary)+max(salary))/2) mediaalta
from employees;
-- 6
-- Listar el número de departamento y el máximo salario en cada uno de ellos.
select department_id, max(salary)
from employees
group by department_id;
-- 7
-- Mostrar los nombres de los empleados que se repiten indicando cuántos hay del mismo
-- en orden descendente.
select first_name, count(first_name)
from employees
group by first_name
having count(first_name) != 1
order by 2 desc;
-- 8
-- Mostrar en una sola consulta cuántos empleados son jefe de departamento
-- y cuántos son jefes de empleados.
select count( distinct manager_id) Id_Jefe, 'DEP' Jefe from departments
union
select count( distinct manager_id), 'EMP' from employees;
--
------------------------------------------------------------------------------------------------
