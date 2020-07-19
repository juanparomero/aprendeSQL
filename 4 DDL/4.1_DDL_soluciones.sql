------------------------------------------------------------------------------------------------
-- DDL
------------------------------------------------------------------------------------------------
/* 
Se desea tener una base de datos con la información de instalaciones/edificios (falicities).
-Información acerca de las plantas, nombre, categoria, descripción, GUID (Global Unique identifier), altura.
-Sobre los espacios, nombre, categoria, descripción, altura usable, area, GUID
-componentes, nombre, descripción, GUID, numero de serie, fecha de instalación
-tipo de componentes, nombre, descripción, modelo, GUID, material, color, años de garantia

1-Generar las siguientes tablas
FACILITIES
guid
name
description
category
address

FLOORS
guid
name
category
description
height
facilityGuid

SPACES
guid
name
category
description
usableHeight
area
floorGuid

COMPONENTS
guid
name
description
serialNumber
installatedOn
spaceGuid
typeGuid

TYPES
guid
name
description
modelNumber
color
warrantyYears


En las definiciones establacer las siguientes restricciones
-Los guid se utilizan como identificadores.
-No es posible dar de alta un componente sin un tipo.
-No es posible dar de alta un espacio sin una planta.
-No es posiblde dar de alta una planta sin un facility.
-Dos componentes no pueden llamarse igual, lo mismo pasa con el resto de entidades.
-La fecha de instalación de un componente no puede ser futura.
-Los nombres no pueden estar vacíos en todas las entidades.
-Los años de garantia no pueden ser cero ni negativos.
-Se debe mantener la integridad referencial.

NOTA: Algunos ejercicios provocan errores que deben probar (para ver el error) y corregir.
*/

create table facilities(
guid        varchar2(4000),
name        varchar2(4000) not null,
description varchar2(4000),
category    varchar2(4000),
address     varchar2(4000),
constraint pk_facilities_guid primary key(guid),
constraint uq_facilities_name unique(name)
);

create table floors(
guid            varchar2(4000),
name            varchar2(4000) not null,
category        varchar2(4000),
description     varchar2(4000),
height          number,
facilityGuid    varchar2(4000) not null,
constraint pk_floors_guid primary key(guid),
constraint uq_floors_name unique(name)
);

create table spaces(
guid            varchar2(4000),
name            varchar2(4000) not null,
category        varchar2(4000),
description     varchar2(4000),
usableHeight    number,
area            number,
floorGuid       varchar2(4000) not null,
constraint pk_spaces_guid primary key(guid),
constraint uq_spaces_name unique(name)
);

create table components(
guid            varchar2(4000),
name            varchar2(4000) not null,
description     varchar2(4000),
serialNumber    varchar2(4000),
installatedOn   date,
spaceGuid       varchar2(4000),
typeGuid        varchar2(4000) not null,
constraint pk_components_guid primary key(guid),
constraint uq_components_name unique(name)
);

create table types(
guid            varchar2(4000),
name            varchar2(4000) not null,
description     varchar2(4000),
modelNumber     varchar2(4000),
color           varchar2(4000),
warrantyYears   number,
constraint pk_types_guid primary key(guid),
constraint uq_types_name unique(name)
);

alter table floors ADD
    constraint fk_floors_facility foreign key (facilityGuid)
        references facilities(guid);

alter table spaces add
    constraint fk_spaces_floor foreign key (floorGuid)
        references floors (guid);

alter table components ADD(
    constraint fk_components_space foreign key (spaceGuid)
        references spaces(guid),
    constraint fk_components_type foreign key (typeGuid)
        references type(guid),
    constraint ck_components_instalatedOn check(installatedOn <= sysdate)
);

alter table types add(
    constraint ck_types_warrantyYears check(warrantyYears > 0)
)