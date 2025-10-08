#!/bin/sh
set -e  # Stoppt bei Fehlern

echo "Running database migrations..."
python manage.py makemigrations
python manage.py migrate

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting Gunicorn..."
exec gunicorn conduit.wsgi:application --bind 0.0.0.0:8000
