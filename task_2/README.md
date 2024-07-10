# Project in devops-stage-2 repo

## DevOps Stage 2: Dockerized Full Stack Web Application Deployment
In this stage, you’ll deploy a provided full stack web application (React frontend and FastAPI + PostgreSQL backend) using Docker containers and proxy both services to run on the same port using Traefik or Nginx Proxy Manager.
### Requirements:
1. Fork the Repository:
   Create a fork of this repository to add the necessary Docker and proxy configuration files.
2. Dockerization:
   Write Dockerfiles to containerize both the React frontend and FastAPI backend. Ensure each service can be built and run locally in their respective containers.
3. Configure Traefik, HaProxy or Nginx Proxy Manager to:
   - Serve the frontend and backend on the same host machine port (80).
   - Serve the frontend on the root (/).
   - Proxy /api on the backend to /api on the main domain.
   - Proxy /docs on the backend to /docs on the main domain.
   - Proxy /redoc on the backend to /redoc on the main domain.
4. Database Configuration:
   Configure the application to use a PostgreSQL database. Ensure the database is properly set up and connected.
5. Adminer Setup:
   Configure Adminer to run on port 8080. Ensure Adminer is accessible via the subdomain db.domain and is properly connected to the postgres database.
6. Proxy Manager Setup:
   Configure the proxy manager to run on port 8090. Ensure the proxy manager is accessible via the subdomain proxy.domain.
7. Cloud Deployment:
   Deploy your Dockerized application to an AWS EC2 instance. Set up a domain for your application. If you don't have a domain, get a free subdomain from Afraid DNS. Configure HTTP to redirect to HTTPS. Configure www to redirect to non-www.
### Additional Instructions:
There is a minimal README with simple instructions on starting the application in the repository. However, you are required to improve all the README files with well-detailed instructions on how to deploy the app, both manually and using Docker.
### Testing and Evaluation:
Your hosted application will be tested to ensure it meets all the requirements. Your repository will be tested to ensure it works correctly after running docker-compose up -d.
