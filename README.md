# Todo App - Clean Architecture Example

## Overview
โปรเจกต์ Todo App นี้เป็นตัวอย่างการใช้ **Clean Architecture** ที่แยกแยะส่วนประกอบหลักของระบบอย่างชัดเจน โดยมี

- **Entities:** Business Models (Todo)
- **Use Cases:** Logic การทำงาน (Create, List, Complete)
- **Interfaces:** Interface สำหรับ Repository
- **Infrastructure:** Adapter สำหรับฐานข้อมูล (SQLite) และ CLI / Web API (FastAPI)
- **API:** FastAPI เป็น Web Interface

## Features
- สร้าง, แสดงรายการ, และทำเครื่องหมาย Todo ว่าทำเสร็จแล้ว
- ใช้ SQLite เป็นฐานข้อมูลแบบ persistent
- รองรับ CLI และ REST API (FastAPI)
- เขียน Unit Test ด้วย Mock Repository เพื่อทดสอบ Use Case แยกส่วน

## Installation

```bash
pip install -r requirements.txt
