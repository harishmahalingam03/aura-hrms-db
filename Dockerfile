# Use the official PostgreSQL image from the Docker Hub
FROM --platform=linux/amd64 postgres:latest

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_DB=hrms

WORKDIR /app

# Copy the schema.sql file to the Docker container
COPY schema.sql  /docker-entrypoint-initdb.d/

# The schema.sql file will be automatically executed during the container startup

# Expose the PostgreSQL port
EXPOSE 5432

CMD ["postgres", "-h", "localhost", "-p", "5432", "-d", "${POSTGRES_DB}"]