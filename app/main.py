from fastapi import FastAPI
import os

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "CI/CD DEPLOY SUCCESS1"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}

@app.get("/version")
def version():
    return {"version": os.getenv("APP_VERSION", "dev")}
