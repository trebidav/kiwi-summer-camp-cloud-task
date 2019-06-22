FROM python:3-alpine

RUN apk add --no-cache curl

# for better caching add requirements first
COPY requirements.txt /app/requirements.txt

WORKDIR /app

# install dependencies
RUN pip install -r requirements.txt

# now copy the rest
COPY . /app

# docker healthcheck
HEALTHCHECK --interval=10s --timeout=3s --retries=3 --start-period=3s\
  CMD curl -f http://localhost:5000/health || exit 1

EXPOSE 5000/tcp

ENTRYPOINT ["python3"]

CMD ["app.py"]
