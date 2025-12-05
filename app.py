from fastapi import FastAPI
from fastapi.responses import JSONResponse

app = FastAPI(title="Scoring Service", version="1.0.0")

@app.get("/health")
def health():
    return JSONResponse({"status": "ok"})

@app.get("/predict")
def predict():
    return JSONResponse({"score": 0.75})
