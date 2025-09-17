FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app

COPY pom.xml .
RUN --mount=type=cache,target=/root/.m2 mvn -B -q -DskipTests dependency:go-offline

COPY src ./src

RUN apt-get update && apt-get install -y --no-install-recommends wget ca-certificates && \
    mkdir -p /tmp/assets && \
    wget -O /tmp/assets/mirea_gerb.png https://www.mirea.ru/upload/medialibrary/80f/MIREA_Gerb_Colour.png && \
    rm -rf /var/lib/apt/lists/*

RUN --mount=type=cache,target=/root/.m2 mvn -B -DskipTests package

FROM eclipse-temurin:21-jre AS runtime
WORKDIR /app

LABEL author="Anton Stepanov" group="IKBO-30-22"

ENV DB_PORT=5432 \
    DB_HOST=postgres \
    DB_NAME=appdb \
    DB_USER=appuser \
    DB_PASSWORD=apppassword \
    APP_PORT=8080

COPY --from=build /app/target/app.jar /app/app.jar
COPY --from=build /tmp/assets/mirea_gerb.png /app/assets/mirea_gerb.png
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN set -eux; \
    sed -i 's/\r$//' /usr/local/bin/entrypoint.sh; \
    chmod 0755 /usr/local/bin/entrypoint.sh; \
    useradd -m nonroot; \
    chown -R nonroot:nonroot /app

EXPOSE 8080

ONBUILD RUN echo "ONBUILD: Сборка и запуск произведены. Автор: Anton Stepanov"

USER nonroot
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
