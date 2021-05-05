FROM ubuntu:latest AS builder

RUN apt-get update && apt-get install -y \
    git \
    make \
    wget

WORKDIR /workspace
RUN wget -qO- https://get.haskellstack.org/ | sh
RUN git clone https://github.com/CDSoft/pp.git
WORKDIR /workspace/pp
RUN make && make install

FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    gpp \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /root/.local/bin/pp /usr/local/bin/pp
