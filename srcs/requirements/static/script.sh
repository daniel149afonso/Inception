#!/bin/bash

# stop the script in case of error
set -e

echo "Starting static website..."

exec nginx -g "daemon off;"