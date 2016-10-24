FROM debian:stretch

RUN apt update && \
    apt upgrade -y && \
    apt install -y curl && \
    curl -sSL https://get.haskellstack.org/ | sh && \
    rm -rf /var/lib/apt

ENTRYPOINT ["/usr/local/bin/stack"]
CMD ["--version"]

USER nobody
ENV HOME /tmp
