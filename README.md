# devops-api

elitamsut@Elis-Laptop fastapi % docker build -t fastapi-app .

docker run -d -p 8000:8000 -e OXR_API_KEY='4dfe6f4c3ffa4575b5487ca947a1f2e3' fastapi-app

docker ps

docker logs 242271da2aa3

elitamsut@Elis-Laptop fastapi % docker run -d -p 8000:8000 -e OXR_API_KEY='api-key' fastapi-app



elitamsut@Elis-Laptop fastapi % cd ..
elitamsut@Elis-Laptop ~ % helm install fastapi ./fastapi \
--namespace currency-converter \
--create-namespace \
--set app.env.OXR_API_KEY='api-key'


elitamsut@Elis-Laptop ~ % 
elitamsut@Elis-Laptop ~ % kubectl port-forward svc/currency-converter 8000:8000 -n currency-converter
Forwarding from 127.0.0.1:8000 -> 8000
Forwarding from [::1]:8000 -> 8000



elitamsut@Elis-Laptop ~ % curl -X POST http://localhost:8000/ \
-H "Content-Type: application/json" \
-d '{"date": 1672531200, "from_currency": "USD", "to_currency": "EUR", "amount": 100}'
{"amount":93.4096,"exchange_rate":0.934096}%                                                                          elitamsut@Elis-Laptop ~ % 



