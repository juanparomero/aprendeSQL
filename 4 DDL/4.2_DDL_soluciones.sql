/*
Se desea gestionar solicitudes sobre componentes. Y para ello se quiere almacenar:
Información sobre una solicitud: asunto, tipo de solicitud (incidencia, petición de servicio), descripción y el estado (creada, asignada, terminada, cerrada). Y los componentes sobre los que se genera.
Las solicitudes pueden generar ordenes de trabajo de las que se quiere tener: tipo de problema, empresa a la que se asigna, un nivel de criticidad (baja, media, alta, urgente), un estado (creada, en progreso, terminada, cerrada), el tiempo de trabajo.
Además, se quiere tener el coste de los materiales utilizados en cada orden de trabajo. Tanto el número de unidades como el valor del material utilizado.

Nos describen las siguientes restricciones:
Cada tabla tiene un id.
Toda orden de trabajo pertenece a una solicitud.
El tipo de solicitud debe ser Incidencia o Petición de servicio si se genera una orden de trabajo.
La cantidad de unidades y el coste no puede ser inferior a cero.

Nota: como con cualquier proyecto el cliente facilita ideas de lo que quiere. Algunas son útiles y otras no, es necesario educir y aclarar lo que el cliente quiere.

1-Generar las siguientes tablas

COMPONENTS
id
guid
name
description
serialNumber
installatedOn
spaceId
typeId

TICKETS
id
subject
ticketTypeId
description
statusId

TICKET_TYPE
id
name

TICKET_STATUS
id
name

TICKET_COMPONENT
ticketId
componentId

ORDERS
id
problemTypeId
companyId
criticalityId
statusId
ticketId
workingHours

COMPANY
id
name

PROBLEM_TYPE
id
name

ORDER_STATUS
id
name

CRITICALLY
id
name

MATERIALS
id
name

COSTS
id
cost
quantity
orderId
materialId

En las definiciones establacer las siguientes restricciones
-Toda orden de trabajo pertenece a una solicitud.
-La cantidad de unidades y el coste no puede ser inferior a cero.
-Toda solicitud tiene un estado.
-Toda orden de trabajo tiene un estado.
-Toda orden de trabajo tiene un tipo de problema.
-Toda orden de trabajo tiene un nivel de criticidad.
-Los nombres de los estados son únicos.
-Los tipos de problemas son únicos.
-Se debe mantener la integridad referencial.

*/

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

create table TICKETS(
    id              number,
    subject         varchar2(4000),
    description     varchar2(4000),
    ticketTypeId    number,
    statusId        number not null,
    constraint pk_tickets_id primary key(id)
);

create table TICKET_TYPE(
    id      number,
    name    varchar2(4000),
    constraint pk_ticket_type_id primary key(id),
    constraint uq_ticket_type_name unique(name)
);

create table TICKET_STATUS(
    id      number,
    name    varchar2(4000),
    constraint pk_ticket_status_id primary key(id),
    constraint uq_ticket_status_name unique(name)
);

create table TICKET_COMPONENT(
    ticketId    number,
    componentId number,
    constraint pk_ticket_component primary key(ticketId, componentId)
);

create table ORDERS(
    id              number,
    problemTypeId   number not null,
    companyId       number,
    criticalityId    number not null,
    statusId        number not null,
    workingHours    number,
    ticketId        number,
    constraint pk_orders_id primary key(id)
);

create table COMPANY(
    id      number,
    name    varchar2(4000),
    constraint pk_company_id primary key(id),
    constraint uq_company_name unique(name)
);

create table PROBLEM_TYPE(
    id      number,
    name    varchar2(4000),
    constraint pk_problem_type_id primary key(id),
    constraint uq_problem_type_name unique(name)
);

create table ORDER_STATUS(
    id      number,
    name    varchar2(4000),
    constraint pk_order_status_id primary key(id),
    constraint uq_order_status_name unique(name)
);

create table CRITICALITIES(
    id      number,
    name    varchar2(4000),
    constraint pk_critically_id primary key(id),
    constraint uq_critically_name unique(name)
);

create table MATERIALS(
    id      number,
    name    varchar2(4000),
    constraint pk_materials_id primary key(id),
    constraint uq_materials_name unique(name)
);

create table COSTS(
    id          number,
    cost        number,
    quantity    number,
    orderId     number,
    materialId  number,
    constraint pk_costs_id primary key(id),
    constraint ck_costs_quantity check(quantity > 0),
    constraint ck_costs_cost check(cost > 0)
);

alter table tickets add(
    constraint fk_tickets_status foreign key(statusId)
        references ticket_status(id),
    constraint fk_tickets_type foreign key(ticketTypeId)
        references ticket_type(id)
);

alter table ticket_component add (
    constraint fk_ticket_component_ticket foreign key(ticketId)
        references tickets(id),
    constraint fk_ticket_component_comp foreign key(componentId)
        references components(id)
);

alter table orders add(
    constraint fk_orders_problem foreign key(problemTypeId)
        references problem_type(id),
    constraint fk_orders_companyId foreign key(companyId)
        references company(id),
    constraint fk_orders_criticalityId foreign key(criticalityId)
        references criticalities(id),
    constraint fk_orders_statusId foreign key(statusId)
        references order_status(id),
    constraint fk_orders_ticketId foreign key(ticketId)
        references tickets(id)
);

