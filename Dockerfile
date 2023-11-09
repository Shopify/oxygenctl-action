FROM node:21
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN apt-get install -y curl bash && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.5/install.sh | bash
RUN npm install -g @shopify/oxygen-cli@latest
ENTRYPOINT ["/entrypoint.sh"]
