------------------------------------------------------------------------------------------------
-- DML
------------------------------------------------------------------------------------------------
/* 1
Insertar un empleado llamado James Dexter 
en el departamento de IT Innovation 
que se encuentra en la ciudad de Madrid, Spain
Y como tipo de trabajo: Software Engineering 
*/

insert into countries(
    country_id, 
    country_name, 
    region_id)
values(
    'ES',
    'Spain',
    1
);

insert into locations(
    location_id, 
    city, 
    country_id)
values(
    3300,
    'Madrid',
    'ES'
);

insert into departments(
    department_id, 
    department_name, 
    location_id)
values(
    280,
    'IT Innovation',
    3300
);

insert into jobs(
    job_id,
    job_title
)
values(
    'IT_SWE',
    'Software Engineering'
);

insert into employees(
    employee_id,
    first_name,
    last_name,
    job_id,
    department_id,
    hire_date,
    email
)
values(
    108,
    'James',
    'Dexter',
    'IT_SWE',
    280,
    sysdate,
    'JDEXTER'
);
/*
Comprobar que se ven los datos insertados de forma conjunta con una JOIN
y no de forma independiente. Con el fin de comprobar las relaciones.
*/
select 
    first_name, 
    last_name,
    department_name,
    job_title,
    city,
    country_name
FROM
    employees
    join jobs on jobs.job_id = employees.job_id
    join departments on employees.department_id = departments.department_id
    join locations on locations.location_id = departments.location_id
    join countries on countries.country_id = locations.country_id
where
    employee_id = 108;

/* 2
Actualizarle el salario a 60000
*/
update employees
set salary = 60000
where employee_id = 108;

/* 3
Colocarle una comisión igual a la media de comisiones
Manteniendo dos centécimas como valor.
*/
update employees
set commission_pct = (select round(avg(commission_pct),2) from employees)
where employee_id = 108;

/* 4
Anonimizar sus datos personales: nombre, apellido, email, teléfono
*/
update employees
set 
    first_name = null,
    last_name = 'ANONYMIZED',
    email = 'ANONYMIZED',
    phone_number = null
where 
    employee_id = 108;