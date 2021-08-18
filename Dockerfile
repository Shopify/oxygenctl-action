FROM alpine:latest
COPY oxygenctl "/usr/local/bin/oxygenctl"
COPY entrypoint.sh "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
