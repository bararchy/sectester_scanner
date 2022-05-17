FROM crystallang/crystal

RUN mkdir /scanner
WORKDIR /scanner

RUN apt update && \
    apt-get install -y libnode-dev node-gyp libssl-dev && \
    apt-get install -y nodejs npm && \
    npm install -g @neuralegion/nexploit-cli --unsafe-perm=true

RUN git clone https://github.com/NeuraLegion/sec-tester-cr.git .
RUN shards install
RUN shards build
RUN mv bin/sec_tester_cli /usr/bin/sec_tester_cli

ENV TERM xterm
ENTRYPOINT [ "/usr/bin/sec_tester_cli" ]