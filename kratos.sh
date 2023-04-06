#!/bin/bash

mkdir /root/output/$1
cd /root/output/$1


# Subdomain Finding using Subfinder
echo -e  "\e[32;1m------------- Subdomain Finding using Subfinder ------------\e[0m" #Aniruddh
subfinder -d $1 -v | sort -u > /root/output/$1/subdomains_$1.txt
cat /root/output/$1/subdomains_$1.txt | wc -l
echo -e "\n"

# Port Scanning on subdomains using naabu 
echo -e  "\e[32;1m------------- Port Scanning using Naabu ------------\e[0m" #Aniruddh
cat /root/output/$1/subdomains_$1.txt | naabu -top-ports 1000 | sort -u > /root/output/$1/naabu_$1.txt
cat /root/output/$1/naabu_$1.txt| wc -l
echo -e "\n"

# HTTP resolver using HTTPX
echo -e  "\e[32;1m------------- HTTP resolver using HTTPX ------------\e[0m" #Aniruddh
cat /root/output/$1/naabu_$1.txt | httpx | sort -u > /root/output/$1/httpx_$1.txt
cat /root/output/$1/httpx_$1.txt | wc -l
echo -e "\n"

#Crolling 

echo -e "\e[32;1m-------------- Fetching archive URLs using gau  ----------------\e[0m" #Aniruddh
cat /root/output/$1/httpx_$1.txt | gau --blacklist ttf,woff,svg,png,jpg,gif,jpeg,inc,css,mp3,mp4,avi,ts --o /root/output/$1/gau_$1_output.txt # for fetch archive URLs
echo "gau URL count - `cat /root/output/$1/gau_$1_output.txt | wc -l`"  #count of archive URLs

#Fuzzing

echo -e "\e[32;1m----------- Fuzzing dirs using FFUF ----------------\e[0m" #Aniruddh
ffuf -u FUZZDOMAIN/FUZZDIR -w /root/output/$1/httpx_$1.txt:FUZZDOMAIN -w /root/Fuzz/all-dirs.txt:FUZZDIR -sf -r -c -ignore-body -of md -o /root/output/$1/ffuf_all_$1_output.txt #Fuzzing Domains

## for 200 URLs
cat /root/output/$1/ffuf_all_$1_output.txt | grep "200" >> /root/output/$1/temp_ffuf_2xx_$1_output #Aniruddh
cat /root/output/$1/temp_ffuf_2xx_$1_output | grep -o 'http[s]\?://[^ ]\+' | sort -u >> /root/output/$1/ffuf_2xx_$1_output.txt
rm -r /root/output/$1/temp_ffuf_2xx_$1_output

## for 401 - 402 & 403 URLs
cat /root/output/$1/ffuf_all_$1_output.txt | grep '401\|402\|403' >> /root/output/$1/temp_ffuf_4xx_$1_output #Aniruddh
cat /root/output/$1/temp_ffuf_4xx_$1_output | grep -o 'http[s]\?://[^ ]\+' | sort -u >> /root/output/$1/ffuf_4xx_$1_output.txt
rm -r /root/output/$1/temp_ffuf_4xx_$1_output

echo "All FFUF URL count - `cat /root/output/$1/ffuf_all_$1_output.txt | wc -l`" #Aniruddh
echo "2xx URL count - `cat /root/output/$1/ffuf_2xx_$1_output.txt | wc -l`" #Aniruddh
echo "4xx URL count - `cat /root/output/$1/ffuf_4xx_$1_output.txt | wc -l`" #Aniruddh

#Tools 
# Nuclei
echo -e  "\e[32;1m------------- Identify Known issue using Nuclei ------------\e[0m" #Aniruddh
cat /root/output/$1/httpx_$1.txt | nuclei -rl 50 -o /root/output/$1/nuclei_$1.txt
echo -e "\n"

# Nikto
echo -e "\e[32;1m---------- Automate scanning using nikto ------------\e[0m" #Aniruddh
nikto -host /root/output/$1/httpx_$1.txt -output /root/output/$1/nikto_$1_output.html -Format HTML | tee /root/output/$1/nikto_$1_output.txt # Nikto automate vuln scanner