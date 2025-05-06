# Task Manager Application

A full-stack task management application built with Ruby on Rails API backend and Vue.js frontend.

## Project Overview

This project is a simple task management application that allows users to:
- Create new tasks with title and description
- View a list of all tasks
- Delete tasks

The application uses a Ruby on Rails API backend with PostgreSQL database and a Vue.js frontend with Axios for API communication.

## Tech Stack

### Backend
- Ruby on Rails 7 (API mode)
- PostgreSQL database
- RESTful API design

### Frontend
- Vue.js 3 (Composition API)
- Axios for API communication
- Custom CSS for styling

## Installation and Setup

### Prerequisites
- Ruby 3.2.2 or higher
- Rails 7.0 or higher
- PostgreSQL
- Node.js and npm
- Git

### Backend Setup

1. Clone the repository and navigate to the backend directory:
```bash
cd backend
```
2. Install Ruby dependencies:

```bash
bundle install
```

3. Configure the database connection in config/database.yml if needed
4. Create and set up the database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

5. Start the Rails server:
```bash
rails server
```

The API will be available at `http://localhost:3000`

### Frontend Setup

1. Navigate to the frontend directory:

```bash
cd frontend
```

2. Install JavaScript dependencies:

```bash
npm install
```

3. Start the Vue development server:
```bash
npm run serve
```

The frontend application will be available at `http://localhost:8080`


### API Endpoints
The backend provides the following RESTful API endpoints:

1. `GET /api/tasks`: List all tasks
2. `POST /api/tasks`: Create a new task
3. `DELETE /api/tasks/:id`: Delete a task