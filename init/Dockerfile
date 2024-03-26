FROM debian:bookworm-slim

RUN apt update && apt install -y ca-certificates tzdata bash aria2 zstd lz4

COPY ./fetch-snapshots.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/*

ENTRYPOINT [ "fetch-snapshots.sh" ]
