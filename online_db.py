import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session
from dotenv import load_dotenv

# Load environment variables from .env
load_dotenv()

# Get the REMOTE_DB string from .env
REMOTE_DB = os.getenv('REMOTE_DB')

if not REMOTE_DB:
    raise RuntimeError("REMOTE_DB is not set. Check your .env file.")

# Set up SQLAlchemy engine and session for remote PostgreSQL DB
online_engine = create_engine(REMOTE_DB)
OnlineSession = scoped_session(sessionmaker(bind=online_engine))
online_session = OnlineSession()
