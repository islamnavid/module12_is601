
# Module 12 — User & Calculation Routes + Integration Testing

**Course:** IS601 — Python for Web API Development  
**Student:** Md Navidul Islam  
**Institution:** New Jersey Institute of Technology (NJIT)

## Project Overview

This project implements a RESTful Calculations API using FastAPI, PostgreSQL, SQLAlchemy, and Pydantic.

Module 12 focuses on user authentication, calculation CRUD operations, integration testing, and continuous deployment through GitHub Actions and Docker Hub.

### Features

- User registration with password hashing
- User login and JWT-based authentication
- Protected calculation endpoints
- Calculation BREAD operations (Browse, Read, Edit, Add, Delete)
- Request and response validation with Pydantic
- PostgreSQL database integration using SQLAlchemy
- Automated testing with pytest
- Interactive API documentation using Swagger UI
- Docker containerization
- GitHub Actions CI/CD pipeline
- Docker Hub image deployment
- Trivy container security scanning

## Technologies Used

- Python 3.12
- FastAPI
- PostgreSQL
- SQLAlchemy
- Pydantic
- pytest and pytest-cov
- Docker and Docker Compose
- GitHub Actions
- Docker Hub
- Trivy

## GitHub Repository

https://github.com/islamnavid/module12_is601

## Docker Hub Repository

https://hub.docker.com/r/navidislam/module12_is601

Docker image:

```bash
docker pull navidislam/module12_is601:latest
```

## Running the Application with Docker Compose

### Prerequisites

Install:

- Git
- Docker Desktop
- Docker Compose (included with Docker Desktop)

### 1. Clone the Repository

```bash
git clone https://github.com/islamnavid/module12_is601.git
cd module12_is601
```

### 2. Configure Environment Variables

Configure the environment variables required by the application's Docker Compose setup.

Use the repository's environment configuration as a reference. Do not commit production credentials or secret keys to GitHub.

### 3. Build and Start the Application

```bash
docker compose up -d --build
```

Docker Compose starts the FastAPI application and its supporting services, including PostgreSQL and pgAdmin.

### 4. Verify the Containers

```bash
docker compose ps
```

### 5. Open the API

Swagger UI:

http://localhost:8000/docs

ReDoc:

http://localhost:8000/redoc

Health check:

http://localhost:8000/health

### 6. Stop the Application

```bash
docker compose down
```

## API Endpoints

### User Authentication

| Method | Endpoint | Description |
|---|---|---|
| POST | `/auth/register` | Register a new user |
| POST | `/auth/login` | Log in using JSON credentials |
| POST | `/auth/token` | Obtain an authentication token using form credentials |

Passwords are securely hashed rather than stored in plaintext.

JWT authentication is used to protect calculation operations.

### Calculation Operations (BREAD)

| Method | Endpoint | Description |
|---|---|---|
| GET | `/calculations` | Browse calculations |
| GET | `/calculations/{calc_id}` | Retrieve a calculation |
| POST | `/calculations` | Add a calculation |
| PUT | `/calculations/{calc_id}` | Edit a calculation |
| DELETE | `/calculations/{calc_id}` | Delete a calculation |

Calculation operations use SQLAlchemy models and Pydantic schemas to validate and manage database records.

## Manual API Testing with Swagger UI

Start the application:

```bash
docker compose up -d --build
```

Open:

http://localhost:8000/docs

### Test User Registration

1. Expand `POST /auth/register`.
2. Select **Try it out**.
3. Enter a valid registration request using the schema shown in Swagger UI.
4. Click **Execute**.
5. Verify the successful response.

### Test User Login

1. Expand `POST /auth/login`.
2. Select **Try it out**.
3. Enter the registered user's credentials.
4. Click **Execute**.
5. Verify the login response.

### Authenticate Requests

Use Swagger UI's **Authorize** feature with the authentication credentials or token required by the application.

### Test Calculation Operations

1. Create a calculation using `POST /calculations`.
2. Retrieve calculations using `GET /calculations`.
3. Retrieve an individual calculation using `GET /calculations/{calc_id}`.
4. Update the calculation using `PUT /calculations/{calc_id}`.
5. Delete the calculation using `DELETE /calculations/{calc_id}`.

Verify the response status codes and JSON response bodies.

For example, an addition calculation with inputs 42 and 7 should produce a result of 49.

Also test invalid requests to verify that validation errors are returned appropriately.

## Running Automated Integration Tests

The project uses pytest for automated testing of the FastAPI application, including authentication, calculation operations, and database interactions.

### 1. Create a Python Virtual Environment

```bash
python3.12 -m venv .venv
```

Activate on macOS/Linux:

```bash
source .venv/bin/activate
```

Activate on Windows:

```powershell
.venv\Scripts\activate
```

### 2. Install Dependencies

```bash
python -m pip install -r requirements.txt
```

### 3. Start PostgreSQL

```bash
docker compose up -d db
```

Configure the required application and test database environment variables, including `DATABASE_URL` and `TEST_DATABASE_URL`.

Ensure the test database exists before running integration tests.

### 4. Run Tests

```bash
python -m pytest -v
```

### 5. Run Tests with Coverage

```bash
python -m pytest -v --cov=app --cov-report=term-missing
```

The automated tests verify application behavior, including user authentication, calculation operations, and error handling.

## GitHub Actions CI/CD

The repository contains a GitHub Actions workflow at:

`.github/workflows/test.yml`

The workflow runs automatically when changes are pushed to the `main` branch or when a pull request targets `main`.

### CI/CD Pipeline

**1. Test**

- Sets up Python
- Starts PostgreSQL
- Installs project dependencies
- Creates the test database
- Runs automated pytest tests

**2. Security**

- Builds the Docker image
- Runs a Trivy vulnerability scan
- Checks for HIGH and CRITICAL vulnerabilities

**3. Deploy**

After the test and security jobs succeed on a push to `main`:

- Authenticates with Docker Hub using GitHub Actions secrets
- Builds the Docker image
- Pushes the image to Docker Hub

### Docker Hub Image Tags

```text
navidislam/module12_is601:latest
navidislam/module12_is601:<commit-sha>
```

The deployment workflow builds images for both `linux/amd64` and `linux/arm64`.

### CI/CD Verification

The latest verified workflow completed successfully with all three jobs passing:

- Test
- Security
- Deploy

Successful commit: `5121da8`

View workflow runs:

https://github.com/islamnavid/module12_is601/actions

## Security Practices

The application incorporates:

- Hashed user passwords
- JWT authentication
- Protected API endpoints
- Pydantic input validation
- Environment-based configuration
- Non-root Docker container execution
- Automated container vulnerability scanning
- GitHub Actions secrets for Docker Hub authentication

## Module 12 Learning Outcomes

This project demonstrates:

- REST API development using FastAPI
- Secure user authentication
- CRUD operations with SQLAlchemy and PostgreSQL
- Request and response validation with Pydantic
- Integration testing with pytest
- Docker-based application deployment
- CI/CD automation with GitHub Actions
- Container vulnerability scanning

## Future Development

Module 13 will add a front-end interface to interact with the existing back-end API.

## Author

**Md Navidul Islam**  
M.S. in Computer Science  
New Jersey Institute of Technology
