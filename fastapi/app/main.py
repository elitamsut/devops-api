from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import requests
from typing import List
from prometheus_client import Gauge, generate_latest, REGISTRY
from fastapi.responses import PlainTextResponse
import os
from datetime import datetime

app = FastAPI()

# Configuration
API_KEY = os.getenv("OXR_API_KEY")
if not API_KEY:
    raise RuntimeError("OXR_API_KEY environment variable is not set")
BASE_URL = "https://openexchangerates.org/api"

# Prometheus metric
conversion_rate = Gauge(
    "conversion_rate",
    "Current exchange rate for a currency",
    ["currency"]
)

# Data models for input validation
class ConversionRequest(BaseModel):
    date: int
    from_currency: str
    to_currency: str
    amount: float

class CurrencyRate(BaseModel):
    currency: str
    rate: float

# Helper function to fetch historical rates
def fetch_historical_rates(timestamp: int) -> dict:
    try:
        date_str = datetime.utcfromtimestamp(timestamp).strftime("%Y-%m-%d")
        url = f"{BASE_URL}/historical/{date_str}.json"
        params = {"app_id": API_KEY}
        response = requests.get(url, params=params)
        if response.status_code != 200:
            raise HTTPException(status_code=400, detail="Failed to fetch exchange rates")
        data = response.json()
        return data["rates"]
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Update Prometheus metrics
def update_prometheus_metrics(rates: dict):
    for currency, rate in rates.items():
        conversion_rate.labels(currency=currency).set(rate)

# Endpoint 1: Get all currency rates
@app.get("/date/{date}", response_model=List[CurrencyRate])
async def get_rates(date: int):
    rates = fetch_historical_rates(date)
    update_prometheus_metrics(rates)
    return [{"currency": currency, "rate": rate} for currency, rate in rates.items()]

# Endpoint 2: Convert currency
@app.post("/")
async def convert_currency(request: ConversionRequest):
    rates = fetch_historical_rates(request.date)
    if request.from_currency not in rates or request.to_currency not in rates:
        raise HTTPException(status_code=400, detail="Invalid currency code")
    
    exchange_rate = rates[request.to_currency] / rates[request.from_currency]
    converted_amount = request.amount * exchange_rate
    
    update_prometheus_metrics(rates)
    return {
        "amount": converted_amount,
        "exchange_rate": exchange_rate
    }

# Prometheus metrics endpoint
@app.get("/metrics", response_class=PlainTextResponse)
async def metrics():
    return generate_latest(REGISTRY)
