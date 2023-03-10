#!/bin/bash

echo "Enter domain name:"
read domain

subfinder -d $domain -o output.txt
