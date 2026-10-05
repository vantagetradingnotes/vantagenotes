# Plan: Project Setup and Authentication (TICKET-1)

## Overview
Initialize the project structure with a decoupled FastAPI backend and React frontend, and implement basic JWT-based authentication.

## Implementation Steps

### 1. Backend Setup (FastAPI)
- Create `backend/` directory.
- Initialize `pyproject.toml` (or `requirements.txt`) with FastAPI, Uvicorn, SQLAlchemy, psycopg2, and `fastapi-users` (for auth).
- Setup basic FastAPI app structure (`main.py`, `models/`, `api/`, `core/`).
- Configure database connection using environment variables (`DATABASE_URL`).

### 2. Frontend Setup (React)
- Create `frontend/` directory.
- Initialize React project using Vite.
- Install basic dependencies (Axios, React Router, TailwindCSS for styling).
- Create basic structure (`src/components/`, `src/pages/`, `src/services/`).

### 3. Authentication Implementation
- Define `User` model using `fastapi-users`.
- Setup JWT authentication backend.
- Create basic register/login endpoints in FastAPI.
- Implement basic login/signup forms in the React frontend.
- Setup Axios interceptor in frontend to handle JWT token storage and inclusion in API requests.

## Deliverables
- Functional backend skeleton with working `/auth` endpoints.
- Functional frontend skeleton with working Login/Register UI.
- Secure JWT token handling.
