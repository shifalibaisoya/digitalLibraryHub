# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Install system dependencies for MariaDB client
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    pkg-config \
    libmariadb-dev \
    libmariadb-dev-compat \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8000 for the application
EXPOSE 8000

# Start the Django application with Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "olms.wsgi:application"]

