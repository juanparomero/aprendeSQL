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
