# Automated CI/CD Pipeline with Jenkins, AWS, Terraform, and GitHub

## Project Objective
The objective of this project is to build an automated, production-style CI/CD (Continuous Integration and Continuous Deployment) pipeline that tests, builds, and deploys a Node.js web application using Jenkins, AWS, Terraform, and GitHub.

Phase 1 focuses on building the core Node.js application equipped with API health checks and automated unit/integration tests using Jest and Supertest.

## Technology Stack
- **Runtime:** Node.js
- **Framework:** Express.js
- **Testing:** Jest & Supertest
- **Version Control:** Git & GitHub
- *(Future Phases)*: Jenkins, Docker, AWS (EC2/ECS), Terraform

## Folder Structure
```
jenkins-aws-cicd/
├── app/
│   ├── server.js          # Express application entry point & routes
│   ├── package.json       # Project dependencies & npm scripts
│   └── test/
│       └── server.test.js # Integration tests for API endpoints
├── .gitignore             # Git ignore rules for node_modules, logs, env files
└── README.md              # Project documentation
```

## Installation Instructions
Navigate to the `app` directory and install the required dependencies:

```bash
cd app
npm install
```

## How to Start the Application
To run the application locally on default port `3000`:

```bash
cd app
npm start
```

To run on a custom port (e.g. `8080`):

```bash
cd app
PORT=8080 npm start
```

## How to Run Tests
To execute the automated test suite using Jest:

```bash
cd app
npm test
```

## API Endpoints & Expected Responses

### 1. Root Endpoint
- **HTTP Method:** `GET`
- **Path:** `/`
- **Response HTTP Code:** `200 OK`
- **Response Body:**
  ```json
  {
    "message": "CI/CD Demo Application is running"
  }
  ```

### 2. Health Check Endpoint
- **HTTP Method:** `GET`
- **Path:** `/health`
- **Response HTTP Code:** `200 OK`
- **Response Body:**
  ```json
  {
    "status": "UP"
  }
  ```

## Future CI/CD Architecture
In subsequent phases, this application will be automated as follows:
1. **GitHub Push:** Code changes pushed to GitHub will trigger a Jenkins build via webhooks.
2. **Jenkins CI:** Jenkins will run tests (`npm test`) inside an isolated build step.
3. **Infrastructure Provisioning:** Terraform will provision cloud resources on AWS.
4. **Containerization & Deployment:** Docker images will be built and deployed automatically to AWS infrastructure.


Automatic CI/CD test
