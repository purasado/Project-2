from fastapi.testclient import TestClient
from app import app

client = TestClient(app)

def test_health():
    resp = client.get("/health")
    assert resp.status_code == 200
    assert resp.json()["status"] == "ok"

def test_predict():
    resp = client.get("/predict")
    assert resp.status_code == 200
    assert "score" in resp.json()

