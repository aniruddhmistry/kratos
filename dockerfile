FROM alpine:latest

RUN apk update 
RUN apk add git 
RUN apk add bash 
RUN apk add curl 
RUN apk add python 
RUN apk add go

RUN curl -L https://github.com/projectdiscovery/subfinder/releases/download/v2.4.5/subfinder_2.4.5_linux_amd64.tar.gz --output subfinder.tar.gz \
    && tar -xzf subfinder.tar.gz \
    && mv subfinder_2.4.5_linux_amd64/subfinder /usr/local/bin/subfinder \
    && rm -rf subfinder_2.4.5_linux_amd64 \
    && rm subfinder.tar.gz

COPY script.sh /

RUN chmod +x /script.sh

CMD ["/script.sh"]
