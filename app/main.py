from fastapi import FastAPI
import os

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "ECS Three-Tier App Running"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}

@app.get("/version")
def version():
    return {"version": os.getenv("APP_VERSION", "dev")}
