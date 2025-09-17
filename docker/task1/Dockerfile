FROM alpine:3.20

LABEL maintainer="Anton Stepanov" course="Practice3-Task1"

ENV FOO=bar

WORKDIR /app

RUN mkdir -p /app/bundle && apk add --no-cache bash

COPY start.sh /usr/local/bin/start.sh
COPY hello.txt /app/bundle/hello.txt

ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/README.md /app/bundle/remote.txt

# VOLUME
VOLUME ["/data"]

RUN adduser -D appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 9090

RUN chmod +x /usr/local/bin/start.sh
ENTRYPOINT ["/usr/local/bin/start.sh"]
CMD ["default-cmd-arg"]

ONBUILD RUN echo "ONBUILD fired in child build!"
