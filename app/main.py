from fastapi import FastAPI
import os

app = FastAPI(title="ECS Three-Tier FastAPI")

@app.get("/")
def read_root():
    return {"message": "ECS Three-Tier FastAPI is running"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}

@app.get("/version")
def version():
    return {"version": os.getenv("APP_VERSION", "dev")}
