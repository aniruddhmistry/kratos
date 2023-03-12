FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache go git curl python3

# for add command in bashrc & bash_profile file 
# RUN echo "<code>" >> ~/.bashrc && echo "<code>" >> ~/.bash_profile

# Set environment variables
ENV GOPATH /usr/local/go

WORKDIR $GOPATH

# Install Project Discovery tools
RUN go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
RUN go install -v github.com/projectdiscovery/katana/cmd/katana@latest
RUN go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
RUN go install -v github.com/projectdiscovery/notify/cmd/notify@latest
RUN go install -v github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest
#RUN go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
RUN go install -v github.com/ffuf/ffuf/v2@latest
#RUN go install -v github.com/tomnomnom/gf
RUN go install github.com/bp0lr/gauplus@latest
RUN go install github.com/tomnomnom/waybackurls@latest

#RUN go install github.com/ffuf/ffuf/v2@latest
#RUN go install github.com/ffuf/ffuf/v2@latest

# Create script and output folders
RUN mkdir -p /root/script /root/output /root/tools

# Copy a sample script
COPY script.sh /root/script/script.sh
RUN chmod +x /root/script/script.sh

# Set the working directory
WORKDIR /root
