Highways Digital Twin - API, data models, and analytical notebooks
===

This repository contains the indicative data models, data queries, and service interface definitions supporting a Proof-of-Concept (PoC) cross-asset highways Digital Twin (DT). It accompanies an academic reseach project focused on network-level digital twins for highways asset management. 

The repository demonstrates how authoritative network data, condition observations, and predictive forecasts can be integrated into unified views and exposed via restful APIs. 

Directory overview:
---

*/erd/* contains a plantUML entiry-relationship definition for raw, process and service schemas in the data management layer of the PoC, 

*/sql/* contains indicative postgis SQL queries and views supporting the tool,

*/api/* contains an OpenAPI 3.0 YAML specification describing REST API endpoints for the service schema,

*/notebooks/* contains example analytical workflows for pavement condition forecasting using SCANNER data, and drainage modelling using near-time guaged flow and rainfall.

Technologies and Standards
---

Database: PostgreSQL and Postgis

Modelling: PlantUML

API Specification: OpenAPI 3.0

Notebooks: Tested on Python 3.13 

Discalimer
---

This repository represents a prototype demonstration supporting ongoing research. It is not intended for production use. 
