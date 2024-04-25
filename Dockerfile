#ie the official Python image from the Docker Hub
FROM python:3.9-slim
WORKDIR /app
RUN pip install Flask
COPY . .
EXPOSE 5000
ENV FLASK_APP=health_status.py
CMD ["flask", "run", "--host", "0.0.0.0"]

