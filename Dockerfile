FROM lambci/lambda:build-python3.8

WORKDIR /app

# Copy your function and install dependencies
COPY resizer.py ./
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt -t .
