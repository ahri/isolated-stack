FROM debian:stretch

RUN apt update && \
    apt upgrade -y && \
    apt install -y curl && \
    curl -sSL https://get.haskellstack.org/ | sh && \
    rm -rf /var/lib/apt

ENTRYPOINT ["/usr/local/bin/stack"]

USER nobody
ENV HOME /tmp

ENV PATH $HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
