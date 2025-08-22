from flask import Flask
from sqlalchemy import create_engine, text
import os

app = Flask(__name__)

DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://appuser:apppass@db:5432/appdb")
engine = create_engine(DATABASE_URL, pool_pre_ping=True)

@app.route("/")
def home():
   return "Greetings From Flask inside Docker!"

@app.route("/db")
def db_check():
   with engine.connect() as conn:
        # simple sanity check: run 1+1 and return result
        result = conn.execute(text("SELECT 1 + 1 AS two;")).scalar_one()
        return f"DB connection OK. 1+1={result}"


if __name__ == "__main__":
   # Binded to 0.0.0.0 so it’s reachable from outside the container
   app.run(host="0.0.0.0", port=5000, debug=True)