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
{"amount":93.4096,"exchange_rate":0.934096}%                                           


","rate":38.208},{"currency":"SSP","rate":130.26},{"currency":"STD","rate":22281.8},{"currency":"STN","rate":23.112226},{"currency":"SVC","rate":8.751432},{"currency":"SYP","rate":2512.53},{"currency":"SZL","rate":18.919612},{"currency":"THB","rate":36.429271},{"currency":"TJS","rate":10.986505},{"currency":"TMT","rate":3.51},{"currency":"TND","rate":3.165},{"currency":"TOP","rate":2.382844},{"currency":"TRY","rate":27.723699},{"currency":"TTD","rate":6.794051},{"currency":"TWD","rate":32.073499},{"currency":"TZS","rate":2510.0},{"currency":"UAH","rate":36.490337},{"currency":"UGX","rate":3753.589629},{"currency":"USD","rate":1.0},{"currency":"UYU","rate":39.982354},{"currency":"UZS","rate":12225.0},{"currency":"VES","rate":34.798072},{"currency":"VND","rate":24449.883597},{"currency":"VUV","rate":118.722},{"currency":"WST","rate":2.7185},{"currency":"XAF","rate":617.454505},{"currency":"XAG","rate":0.0453525},{"currency":"XAU","rate":0.00053322},{"currency":"XCD","rate":2.70255},{"currency":"XDR","rate":0.762232},{"currency":"XOF","rate":617.454505},{"currency":"XPD","rate":0.00085341},{"currency":"XPF","rate":112.327366},{"currency":"XPT","rate":0.0011274},{"currency":"YER","rate":250.349961},{"currency":"ZAR","rate":18.825459},{"currency":"ZMW","rate":21.528535},{"currency":"ZWL","rate":322.0}]%                                                                        
elitamsut@Elis-Laptop ~ % curl http://localhost:8000/date/1697059200


