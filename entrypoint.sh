#!/bin/sh
set -e  # Stoppt bei Fehlern

echo "Running database migrations..."

# In Prod Setup you dont want to make the migrations every deployment but in Dev Setup.
# python manage.py makemigrations

python manage.py migrate

echo "Creating superuser if not exists..."
python create_superuser.py

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting Gunicorn with WhiteNoise..."
exec gunicorn conduit.wsgi:application --bind 0.0.0.0:8000
