FROM ubuntu:latest
RUN apt-get update && \
    apt-get install -y python-dev python-pip mysql-client redis-server git wget supervisor && \
    pip install tornado u-msgpack-python jinja2 chardet requests pbkdf2 pycrypto mysql-connector-python-rf
RUN mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/binux/qiandao --depth=1 && \
    cd qiandao && \
    rm config.py && \
    wget https://gist.github.com/legendtang/bef8ae767e892ed2affdb781bb751733/raw/d67313e68432be79e3fec6c04a073422f8be1bf9/config.py

COPY supervisord.conf /etc/supervisord.conf

ENV PORT 80

EXPOSE $PORT

#ENTRYPOINT python /opt/qiandao/run.py
ENTRYPOINT ["/usr/bin/supervisord"]
