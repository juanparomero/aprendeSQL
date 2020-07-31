/*
NOTA: Algunos ejercicios provocan errores que deben probar (para ver el error) y corregir.
*/

/*1
Dar de alta al edificio matriz
*/
insert into facilities(id,name)
values(1,'Matriz');
/*2
Dar de alta Planta 1, Planta 2 y Planta 3
en el edificio matriz con una altura de 3.69m
*/
insert into floors(id, name, facilityid, height)
    select 1, 'Planta 1', 1, 3.69 from dual
    UNION
    select 2, 'Planta 2', 1, 3.69 from dual
    UNION
    select 3, 'Planta 3', 1, 3.69 from dual ;

/*3
Dar de alta en Planta 1 los espacios: Recepción, Sala1, Sala2
*/
insert into spaces(id, name, floorid)
    select 1, 'Recepción', 1 from dual
    UNION
    select 2, 'Sala 1', 1 from dual
    UNION
    select 3, 'Sala 2', 1 from dual ;
/*4
Dar de alta los tipos: 
Mesa madera cuadrada 1x1x1
Mesa madera redonda 2x1
Silla reclinable TPM
*/
insert into types(id, name)
    select 1, 'Mesa madera cuadrada 1x1x1' from dual
    UNION
    select 2, 'Mesa madera redonda 2x1' from dual
    UNION
    select 3, 'Silla reclinable TPM' from dual ;

/*5
Dar de alta los componentes: 
[{
"name": "Mobiliario_Mesa madera cuadrada 1x1x1",
"serialNumber": "ASD-3322",
"assetId": "MOB-MES-1234",
"space": "Sala 1",
"type": "Mesa madera cuadrada 1x1x1"
},
{
"name": "Mobiliario_Mesa madera cuadrada 1x1x1",
"serialNumber": "ASD-3355",
"assetId": "MOB-MES-4321",
"space": "Sala 2",
"type": "Mesa madera cuadrada 1x1x1"
}
]
*/
/*
Nota:
-se necesita agregar un campo para almacenar el código dado que es independiente del nuestro.
-se elimina la restricción de que el nombre de los componentes no pueda repetirse
*/
alter table components add
    assetId varchar2(4000);

alter table components
drop constraint uq_components_name;

insert into components(id, name, serialNumber, assetId, spaceId, typeId)
    select 1, 'Mobiliario_Mesa madera cuadrada 1x1x1','ASD-3322','MOB-MES-1234', 2, 1 from dual
    UNION
    select 2, 'Mobiliario_Mesa madera cuadrada 1x1x1','ASD-3355','MOB-MES-4321', 3, 1 from dual;

/*6
Actualizar la fecha de instalación del componente número 2
al 31 de junio del 2020
*/
update components
set installatedOn = to_Date('2020-06-31','yyyy-mm-dd')
where id = 2;

/*
No existe el 31 de junio. Le colocamos 1 de junio.
*/
update components
set installatedOn = to_Date('2020-06-1','yyyy-mm-dd')
where id = 2;

/*7
Quitar restricción de obliga a los componentes
a tener un espacio
*/
alter table components
modify spaceId number null;

/*8
Quitar restricción de obliga a los componentes
a tener un tipo
*/
alter table components
modify typeid number null;