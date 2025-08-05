from app import app  
from waitress import serve
import logging

logging.basicConfig(level=logging.DEBUG)

if __name__ == "__main__":
    print("Starting server on http://127.0.0.1:8000")
    serve(app, host="127.0.0.1", port=8000)
