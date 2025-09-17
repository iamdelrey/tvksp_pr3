FROM alpine:3.20

LABEL maintainer="Anton Stepanov" course="Practice3-Task1"

ENV FOO=bar

WORKDIR /app

RUN apk add --no-cache bash && mkdir -p /app/bundle

COPY start.sh /usr/local/bin/start.sh
COPY hello.txt /app/bundle/hello.txt
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/README.md /app/bundle/remote.txt

RUN set -eux; \
    sed -i 's/\r$//' /usr/local/bin/start.sh; \
    chmod 0755 /usr/local/bin/start.sh

VOLUME ["/data"]
EXPOSE 9090

RUN adduser -D appuser && chown -R appuser:appuser /app
USER appuser

ENTRYPOINT ["/usr/local/bin/start.sh"]
CMD ["default-cmd-arg"]

ONBUILD RUN echo "ONBUILD fired in child build!"
