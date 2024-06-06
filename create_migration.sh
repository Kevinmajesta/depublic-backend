#!/bin/bash

# Generate timestamp
timestamp=$(date +"%Y%m%d%H%M%S")

# Define migration name
migration_name=$1

# Create migration files
migrate create -ext sql -dir db/migrations -seq $migration_name

# Get the latest migration files
up_file=$(ls -t db/migrations/*_$migration_name.up.sql | head -n 1)
down_file=$(ls -t db/migrations/*_$migration_name.down.sql | head -n 1)

# Rename migration files with timestamp
mv "$up_file" "db/migrations/${timestamp}_$migration_name.up.sql"
mv "$down_file" "db/migrations/${timestamp}_$migration_name.down.sql"
