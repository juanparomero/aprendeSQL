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
id
guid
name
description
category
address

FLOORS
id
guid
name
category
description
height
facilityId

SPACES
id
guid
name
category
description
usableHeight
area
floorId

COMPONENTS
id
guid
name
description
serialNumber
installatedOn
spaceId
typeId

TYPES
id
guid
name
description
modelNumber
color
warrantyYears


En las definiciones establecer las siguientes restricciones
-Los guid deben ser únicos.
-No es posible dar de alta un componente sin un tipo.
-No es posible dar de alta un espacio sin una planta.
-No es posiblde dar de alta una planta sin un facility.
-Dos componentes no pueden llamarse igual, lo mismo pasa con el resto de entidades.
-La fecha de instalación de un componente por defecto es la actual.
-Los nombres no pueden estar vacíos en todas las entidades.
-Los años de garantia no pueden ser cero ni negativos.
-Se debe mantener la integridad referencial.

NOTA: Algunos ejercicios provocan errores que deben probar (para ver el error) y corregir.
*/

create table facilities(
    id          number,
    guid        varchar2(4000),
    name        varchar2(4000) not null,
    description varchar2(4000),
    category    varchar2(4000),
    address     varchar2(4000),
    constraint pk_facilities_guid primary key(id),
    constraint uq_facilities_name unique(name),
    constraint uq_facilities_guid unique(guid)
);

create table floors(
    id              number,
    guid            varchar2(4000),
    name            varchar2(4000) not null,
    category        varchar2(4000),
    description     varchar2(4000),
    height          number,
    facilityId      number not null,
    constraint pk_floors_guid primary key(id),
    constraint uq_floors_name unique(name),
    constraint uq_floors_guid unique(guid)
);

create table spaces(
    id              number,
    guid            varchar2(4000),
    name            varchar2(4000) not null,
    category        varchar2(4000),
    description     varchar2(4000),
    usableHeight    number,
    area            number,
    floorId         number not null,
    constraint pk_spaces_guid primary key(id),
    constraint uq_spaces_name unique(name),
    constraint uq_spaces_guid unique(guid)
);

create table components(
    id              number,
    guid            varchar2(4000),
    name            varchar2(4000) not null,
    description     varchar2(4000),
    serialNumber    varchar2(4000),
    installatedOn   date default sysdate,
    spaceId         number,
    typeId          number not null,
    constraint pk_components_guid primary key(id),
    constraint uq_components_name unique(name),
    constraint uq_components_guid unique(guid)
);

create table types(
    id              number,
    guid            varchar2(4000),
    name            varchar2(4000) not null,
    description     varchar2(4000),
    modelNumber     varchar2(4000),
    color           varchar2(4000),
    warrantyYears   number,
    constraint pk_types_guid primary key(id),
    constraint uq_types_name unique(name),
    constraint uq_types_guid unique(guid)
);

alter table floors ADD
    constraint fk_floors_facility foreign key (facilityId)
        references facilities(id);

alter table spaces add
    constraint fk_spaces_floor foreign key (floorId)
        references floors (id);

alter table components ADD(
    constraint fk_components_space foreign key (spaceId)
        references spaces(id),
    constraint fk_components_type foreign key (typeId)
        references types(id)
);

alter table types add(
    constraint ck_types_warrantyYears check(warrantyYears > 0)
);