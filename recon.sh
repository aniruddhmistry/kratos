figlet -f big "Recon Machine" | lolcat       #Terminal Banner
echo -e "Usages -  kratos example.com\n" | lolcat

kratos(){
/bin/bash ~/script/kratos.sh $1
}

showscript(){
nano ~/script/kratos.sh
}