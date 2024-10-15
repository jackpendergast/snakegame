# Use an official Python runtime based on Alpine
FROM python:3.9-alpine

# Set the working directory in the container
WORKDIR /app

# Install dependencies for building Python packages and for your app
RUN apk add --no-cache gcc musl-dev libffi-dev openssl-dev

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Define environment variable
ENV NAME SnakeGameApp

# Run app.py when the container launches
CMD ["python", "app.py"]
