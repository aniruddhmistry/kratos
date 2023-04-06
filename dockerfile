FROM alpine:latest

RUN apk update && apk add --no-cache python3 go ruby ruby-dev libpcap-dev figlet nano bash && \
    gem install lolcat && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /tmp/* && \
    rm -rf /var/log/* && \
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/*

# Set the GOPATH environment variable
ENV GOPATH /go

# Add the Go bin directories to the system PATH
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"

RUN go install -v github.com/ffuf/ffuf/v2@latest && \
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest && \
    go install -v github.com/bp0lr/gauplus@latest

# Copy a sample script
# Creating some Folders
RUN mkdir -p /root/output /root/tools
COPY Fuzz /root/Fuzz

COPY kratos.sh /root/script/kratos.sh
COPY recon.sh /root/.myprofile

RUN apk add --no-cache bash && \
    echo "source /root/.myprofile" >> /root/.bashrc
CMD ["bash"]