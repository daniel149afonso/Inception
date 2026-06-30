# Build static site Image
# Download Debian Bullseye
FROM debian:bullseye

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y wget apt-transport-https gnupg && \
    wget -qO - https://get.trivy.dev/deb/public.key \
    | gpg --dearmor \
    | tee /usr/share/keyrings/trivy.gpg > /dev/null && \
    echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://get.trivy.dev/deb bullseye main" \
    > /etc/apt/sources.list.d/trivy.list && \
    apt-get update && \
    apt-get install -y trivy && \
    rm -rf /var/lib/apt/lists/*

COPY script.sh /script.sh

RUN chmod +x /script.sh

CMD ["/script.sh"]