FROM alpine:latest

# Install necessary packages
RUN apk update && \
    apk add --no-cache go git curl python3 figlet mlocate nano && \
    rm -rf /var/cache/apk/*

RUN  apk add ruby; gem install lolcat;   \
     apk del ca-certificates ruby-dev; 

# Set the GOPATH environment variable
ENV GOPATH /go

# Add the Go bin directories to the system PATH
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"

# Install Project Discovery tools
RUN go install -v github.com/projectdiscovery/katana/cmd/katana@latest
RUN go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
RUN go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
RUN go install -v github.com/projectdiscovery/notify/cmd/notify@latest
RUN go install -v github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest
RUN go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
RUN go install -v github.com/ffuf/ffuf/v2@latest
RUN go install github.com/tomnomnom/gf@latest
RUN go install github.com/bp0lr/gauplus@latest
RUN go install github.com/tomnomnom/waybackurls@latest

#RUN go install github.com/ffuf/ffuf/v2@latest
#RUN go install github.com/ffuf/ffuf/v2@latest

# for add command in bashrc & bash_profile file 


RUN echo "kratos(){" >> ~/.recon \
    && echo "/bin/bash ~/script/kratos.sh $1" >> ~/.recon \
    && echo "}" >> ~/.recon

COPY .bashrc /root/
COPY .profile /root/

RUN source ~/.bashrc
#RUN source ~/.bash_profile

# Create script and output folders
RUN mkdir -p /root/script /root/output /root/tools

# Copy a sample script
COPY kratos.sh /root/script/kratos.sh
RUN chmod +x /root/script/kratos.sh

# Set the working directory
CMD figlet -f big "Recon Machine" | lolcat &&  \
  echo -e "Usages -  kratos example.com\n" | lolcat && \
  WORKDIR ~/root/
