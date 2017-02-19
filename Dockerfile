FROM alpine:latest
RUN apk add --no-cache --update \
    python py-pip git wget autoconf automake build-base linux-headers python-dev supervisor && \
    pip install --upgrade pip setuptools tornado u-msgpack-python jinja2 chardet requests pbkdf2 && \
    pip install pycrypto mysql-connector-python-rf --egg && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/MoeGakuen/qiandao \
    --depth 1 --branch master --single-branch && \
    cd qiandao && \
    rm config.py && \
	wget https://gist.githubusercontent.com/MoeGakuen/731e37e8c439f2edc80fca19a445a4d0/raw/d7c56d75ac24656c96bb11429b598a88587cca50/config.py && \
    apk del build-base linux-headers python-dev autoconf automake wget py-pip && \
    rm -rf /var/cache/apk/*

COPY supervisord.conf /etc/supervisord.conf

ENV PORT 80

EXPOSE $PORT

#ENTRYPOINT python /opt/qiandao/run.py
ENTRYPOINT ["/usr/bin/supervisord"]
