# devops-api
elitamsut@Elis-Laptop fastapi % docker build -t fastapi-app .
docker run -d -p 8000:8000 -e OXR_API_KEY='4dfe6f4c3ffa4575b5487ca947a1f2e3' fastapi-app
docker ps
docker logs 242271da2aa3
elitamsut@Elis-Laptop fastapi % docker run -d -p 8000:8000 -e OXR_API_KEY='api-key' fastapi-app
