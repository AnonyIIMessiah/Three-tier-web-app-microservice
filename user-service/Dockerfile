FROM python:3-alpine

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

RUN adduser -D python

USER python

COPY --chown=python:python . .

EXPOSE 5001

CMD ["python", "app.py"]