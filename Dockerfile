FROM --platform=$TARGETPLATFORM alpine:3.19.1

ARG TARGETPLATFORM

RUN apk add --no-cache curl

RUN if [ "$TARGETPLATFORM" = "linux/386" ]; then \
        PLATFORM=65; \
    elif [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        PLATFORM=66; \
    elif [ "$TARGETPLATFORM" = "linux/arm" ]; then \
        PLATFORM=67; \
    elif [ "$TARGETPLATFORM" = "linux/arm/v6" ]; then \
        PLATFORM=67; \
    elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then \
        PLATFORM=67; \
    elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        PLATFORM=68; \
    elif [ "$TARGETPLATFORM" = "linux/arm64/v8" ]; then \
        PLATFORM=68; \
    else \
        PLATFORM=66; \
    fi && \
    curl -o gaganode.tar.gz "https://assets.coreservice.io/public/package/${PLATFORM}/gaganode_pro/0.0.300/gaganode_pro-0_0_300.tar.gz" && \
    tar -zxf gaganode.tar.gz && \
    rm -f gaganode.tar.gz && \
    mv ./gaganode-*-* /app

WORKDIR /app

RUN sed -i "s/^os_name = '.*'\s*$/os_name = 'alpine'/g" ./root_conf/default.toml && \
    sed -i "s/^os_version = '.*'\s*$/os_version = '3.19.1'/g" ./root_conf/default.toml && \
    sed -i "s/^product = '.*'\s*$/product = 'Docker'/g" ./root_conf/default.toml

EXPOSE 36060/tcp 36060/udp

COPY --chmod=755 ./docker-entrypoint.sh ./docker-entrypoint.sh

CMD [ "./docker-entrypoint.sh" ]
