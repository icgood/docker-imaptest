FROM alpine:latest

WORKDIR /tmp

COPY dovecot-crlf.gz .
RUN gunzip dovecot-crlf.gz

RUN apk add curl

ARG dovecot_url="http://dovecot.org/nightly/dovecot-latest.tar.gz"
RUN curl -LO ${dovecot_url} && tar xzf dovecot-latest.tar.gz && mv dovecot-20* dovecot-latest

ARG imaptest_url="http://dovecot.org/nightly/imaptest/imaptest-latest.tar.gz"
RUN curl -LO ${imaptest_url} && tar xzf imaptest-latest.tar.gz && mv imaptest-20* imaptest-latest

RUN apk --update add --virtual build-dependencies build-base \
	&& sh -c 'cd dovecot-latest && ./configure --without-shared-libs && make' \
	&& sh -c 'cd imaptest-latest && ./configure --with-dovecot=/tmp/dovecot-latest && make && make install' \
	&& apk del build-dependencies

VOLUME ["/mnt"]
WORKDIR /mnt

ENTRYPOINT ["imaptest", "mbox=/tmp/dovecot-crlf"]
