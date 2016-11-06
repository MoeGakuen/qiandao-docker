FROM alpine:latest
RUN apk add --no-cache --update \
    python py-pip git wget autoconf automake build-base linux-headers python-dev supervisor && \
    pip install --upgrade pip setuptools tornado u-msgpack-python jinja2 chardet requests pbkdf2 && \
    pip install pycrypto mysql-connector-python-rf --egg
RUN mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/binux/qiandao \
    --depth 1 --branch master --single-branch && \
    cd qiandao && \
    rm config.py && \
    wget https://gist.github.com/legendtang/bef8ae767e892ed2affdb781bb751733/raw/d67313e68432be79e3fec6c04a073422f8be1bf9/config.py && \
    apk del build-base linux-headers python-dev autoconf automake wget py-pip && \
    rm -rf /var/cache/apk/*

COPY supervisord.conf /etc/supervisord.conf

ENV PORT 80

EXPOSE $PORT

#ENTRYPOINT python /opt/qiandao/run.py
ENTRYPOINT ["/usr/bin/supervisord"]
