# Official python image that generally only installs the minimal packages needed to run our app.
FROM python:3.6.15-slim 

# Copy existing application directory contents
COPY . /app

# Change working directory
WORKDIR /app

# Install required libraries
RUN pip install -r requirements.txt

# Expose port 5000 and start the flask application
EXPOSE 5000
CMD ["python", "-u", "app.py"]