# SAP-Procurement-Analytics

## Project Overview
This project is an end-to-end, object-oriented ABAP reporting and analytics solution developed for an SAP environment. It is designed to track procurement data and monitor inventory stock movements, enabling dynamic, real-time business decision-making. 

The architecture strictly follows the separation of concerns, isolating database operations within a dedicated Data Access class and handling UI/presentation logic in an executable program.

## Tools & Technologies
* **Environment:** SAP GUI, ABAP Workbench
* **Database (SE11):** Transparent Tables, Data Elements
* **Business Logic (SE24):** OOPS ABAP, Encapsulation, Open SQL, Internal Tables
* **Presentation (SE38):** Executable Programs, Dynamic Selection Screens, Classical ALV (SLIS)

## System Architecture

### 1. Data Dictionary Layer (SE11)
Created custom transparent tables utilizing standard SAP data elements to prevent data redundancy and ensure proper formatting:
* **`ZPIA_PO_HEADER`**: Procurement Header Table (Company Code, Vendor, Document Dates).
* **`ZPIA_PO_ITEM`**: Procurement Item Table (Material, Quantity, Net Price).
* **`ZPIA_VENDOR`**: Vendor Master Data.
* **`ZPIA_MATERIAL`**: Material Master Data.
* **`ZPIA_STOCK_DOC`**: Inventory Stock Movement Data (Plant, Movement Types, Storage Locations).

### 2. Business Logic Layer (SE24)
Developed a Global Class (`ZCL_PIA_DATA_ACCESS`) to act as the primary Data Access Object (DAO).
* Encapsulated all Open SQL queries using `INNER JOIN` and `LEFT OUTER JOIN`.
* Utilized modular methods (`GET_PURCHASE_ORDERS` and `GET_STOCK_MOVEMENTS`) with appropriate Importing/Exporting parameters and table types.
* Ensured high performance by minimizing database hits and moving data processing to the application server.

### 3. Validation Logic (SE24)
Implemented dedicated validator classes to ensure data integrity and maintain a clean object-oriented design:
* **`ZCL_PIA_VALIDATOR`**
* **`ZCL_PIA_PO_VALIDATOR`**
* **`ZCL_PIA_STOCK_VALIDATOR`**

### 4. Presentation Layer (SE38)
Developed a dynamic reporting interface (`ZPIA_ANALYTICS_REPORT`).
* Built a dynamic Selection Screen using `SELECT-OPTIONS` and `PARAMETERS` that conditionally hides/shows input fields based on the selected radio button (Procurement vs. Inventory).
* Manually configured ALV Field Catalogs for optimized, user-friendly data presentation.
* Output rendered using Interactive Classical ALV Grids.

## Repository Structure
Since this project was developed on a shared SAP server, the source code and visual proofs have been manually exported.

* `ZCL_PIA_DATA_ACCESS.abap` - Global class for database operations.
* `ZPIA_ANALYTICS_REPORT.abap` - Executable program for UI and ALV generation.
* `images/tables/` - Visual DDIC definitions of the transparent tables.
* `images/data/` - Dummy data sets populated for testing.
* `images/screens/` - Screenshots of the dynamic selection screen and final ALV output.
