# Use a lightweight Python image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
pip install -r requirements.txt

# Copy application code
COPY app.py .

# Expose port 80
EXPOSE 80

# Run the application
CMD ["python", "app.py"]
