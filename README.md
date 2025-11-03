# Factura Market Services

Microservicios para la gestión de clientes y facturas electrónicas, con auditoría en MongoDB.  
Este proyecto está desarrollado con Ruby on Rails, SQLite, MongoDB y Docker Compose para levantar todos los servicios en contenedores.

## Arquitectura

El proyecto está dividido en los siguientes microservicios:

| Servicio  | Puerto | Descripción |
|-----------|--------|------------|
| Clientes  | 3001   | Gestión de clientes (CRUD) |
| Facturas  | 3002   | Creación y consulta de facturas, validando que el cliente exista |
| Auditoría | 8080   | Registro de eventos en MongoDB |
| MongoDB   | 27017  | Base de datos para el servicio de auditoría |

Todos los servicios se comunican entre sí a través de la red interna de Docker `app-network`.

## Requisitos

- Docker y Docker Compose instalados
- Git
- Navegador o cliente REST (por ejemplo, Postman o curl)

## Cómo levantar el proyecto

Clona el repositorio:

```bash
git clone https://github.com/tuusuario/factura-market-services.git
cd factura-market-services
Levanta todos los servicios con Docker Compose:

bash
Copiar código
sudo docker-compose up --build
Accede a los servicios:

Clientes: http://localhost:3001

Facturas: http://localhost:3002

Auditoría: http://localhost:8080

MongoDB: localhost:27017

Microservicio de Clientes
Crear un cliente
bash
Copiar código
curl -X POST http://localhost:3001/clientes \
-H "Content-Type: application/json" \
-d '{
  "cliente": {
    "nombre_o_razon_social": "Soluciones Modernas Ltda.",
    "identificacion": "8005551234",
    "correo": "ventas@solucionesmodernas.com",
    "direccion": "Avenida Siempre Viva 742"
  }
}'
Obtener un cliente por ID
bash
Copiar código
curl http://localhost:3001/clientes/1
Listar todos los clientes
bash
Copiar código
curl http://localhost:3001/clientes
Microservicio de Facturas
Crear una factura
bash
Copiar código
curl -X POST http://localhost:3002/facturas \
-H "Content-Type: application/json" \
-d '{
  "factura": {
    "cliente_id": "1",
    "total": 350.75,
    "fecha": "2025-11-03"
  }
}'
La factura solo se crea si el cliente existe.

Consultar factura por ID
bash
Copiar código
curl http://localhost:3002/facturas/1
Listar facturas por rango de fechas
bash
Copiar código
curl "http://localhost:3002/facturas?fechaInicio=2025-11-01&fechaFin=2025-11-05"
Validaciones
cliente_id: Debe existir en el microservicio de clientes.

total: Debe ser mayor a 0.

fecha: Debe ser válida.

Stack tecnológico
Ruby on Rails 7.2

SQLite (para clientes y facturas)

MongoDB (para auditoría)

Faraday (para comunicación entre microservicios)

Docker & Docker Compose

REST API JSON

Estructura del proyecto
bash
Copiar código
factura-market-services/
├─ clientes/      # Microservicio de clientes
├─ facturas/      # Microservicio de facturas
├─ auditoria/     # Microservicio de auditoría
├─ data/          # Datos persistentes (SQLite)
├─ docker-compose.yml
└─ README.md
