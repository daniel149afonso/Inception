# Build Redis Image
# Download Debian Bullseye
FROM debian:bullseye

RUN apt-get update && apt-get install -y redis-server \
	&& rm -rf /var/lib/apt/lists/*

# Redis usually listen 6379 port
EXPOSE 6379

COPY script.sh /script.sh

COPY redis.conf /etc/redis/redis.conf

RUN chmod +x /script.sh

CMD ["/script.sh"]