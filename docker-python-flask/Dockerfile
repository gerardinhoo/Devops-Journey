# syntax=docker/dockerfile:1

# Base Image containing Python Runtime
FROM python:3.11-slim AS base

# Prevent Python from writing .pyc files and buffer logs
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1


# Set the working directory inside the container
WORKDIR /app
RUN addgroup --system app && adduser --system --ingroup app app 

# Dependency layer && caching)
# Copy only requirements first so Docker can cache this layer when code changes
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the application files from the host to the container
COPY . .

# Switch to Non Root User
USER app

# Expose to port 5000
EXPOSE 5000

# Define the command to run the Flask app when the container starts

CMD ["python", "app.py"]