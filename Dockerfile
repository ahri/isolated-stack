FROM debian:jessie

RUN apt update && \
    apt upgrade -y && \
    apt install -y curl sudo && \
    curl -sSL https://get.haskellstack.org/ | sh && \
    apt remove -y curl && \
    rm -rf /var/lib/apt

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
