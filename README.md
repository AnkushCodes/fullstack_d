# 🚀 Full Stack DartLang Application

A modern full-stack application built entirely with DartLang, combining:

- 💻 **Flutter Web** for the frontend  
- 🧩 **Shelf** for backend API routing  
- 🔁 **Reverse Proxy** in Dart to manage API routing cleanly  
- 🐳 **Docker Compose** for local development and deployment  
- 🗄️ **PostgreSQL** for database integration

## 📦 Features

### 🌐 Frontend: Flutter Web

- Built with Flutter targeting the web platform
- Clean, responsive UI
- Connects to Shelf APIs via reverse proxy

### 🛠️ Backend: Shelf (Dart Server)

- RESTful API built using the Shelf framework
- Modular routing using `shelf_router`
- Middleware for logging, CORS, and security

### 🔄 Reverse Proxy in Dart

- Acts as a smart middle layer between the frontend and backend
- Handles API redirection and security filtering
- Developed in pure Dart with no external dependencies

### 🐳 Docker Compose

- **Services:**
  - Flutter Web App
  - Shelf API Server
  - Reverse Proxy (Dart-based)
  - PostgreSQL database

- Easy to spin up the entire stack using Docker Compose
- Supports environment-based configurations

### 🗄️ PostgreSQL Database

- PostgreSQL as the main database for storing application data
- Integration via the `postgres` package to handle queries and database interactions
- Easy database management with Docker support
- Environment-based configurations for seamless deployment

## 🔧 Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/AnkushCodes/fullstack_dart.git
# fullstack_d
