#!/bin/bash

set -e

echo "Starting Adminer..."

exec php -S 0.0.0.0:8080 -t /usr/share/adminer/adminer