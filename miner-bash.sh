#!/bin/bash

source ~/.bashrc

# Importing color

Red=$'\e[1;31m'
Green=$'\e[1;32m'
Blue=$'\u001b[34m'
Magenta=$'\u001b[35m'
Cyan=$'\u001b[36m'
White=$'\u001b[37m'
Yellow=$'\u001b[33m'



echo " 
  $Magenta WELCOME TO
  $Red                                                                                       
 .d8888b.  8888888888 888      8888888888      888b     d888 8888888 888b    888  8888888888 8888888b.  
d88P  Y88b 888        888      888             8888b   d8888   888   8888b   888  888        888   Y88b 
Y88b.      888        888      888             88888b.d88888   888   88888b  888  888        888    888 
  Y888b.   8888888    888      8888888         888Y88888P888   888   888Y88b 888  8888888    888   d88P 
     Y88b. 888        888      888             888 Y888P 888   888   888 Y88b888  888        8888888P   
       888 888        888      888             888  Y8P  888   888   888  Y88888  888        888 T88b   
Y88b  d88P 888        888      888             888       888   888   888   Y8888  888        888  T88b  
  Y8888P   8888888888 88888888 888             888       888 8888888 888    Y888  8888888888 888   T88b 

                                             
                                                      # # # # # # # # # # # # # #
                                                      # $Magenta  Author: @SELVAGANESH  #
                                                      # # # # # # # # # # # # # # 
                                             
                                             
                                             
                                             
                                                                                                  "






######################################################################


# dir setup and github token setup

echo "$Cyan Enter Your Target Domain Ex: google.com"
read dm
mkdir -p ~/Recon/$dm
cd ~/Recon/$dm
echo 
echo "$Red IF YOU NEED A GITHUB RECON PLEASE ENTER YOUR GITHUB BELOW
           TOKEN IF NOT YOU CAN SKIP BY $Green ctrl + c "
sleep 2          
echo
echo "Enter Your Github Token"
read token
sleep 2
echo " "
echo "<<<< $Red IF YOU WANT TO FETCH URLS INCLUDING SUBDOMAINS TYPE $Green ALL $Red ELSE $Green PRESS ENTER >>>>>>>"
read domain
echo
##########################################################################
mkdir "SubdomainEnumeration"
cd "SubdomainEnumeration"
echo "$Cyan SUBDOMAIN ENUMERATION STARTED"

print "$Green" "<<< SUBFINDER STARTED >>>"
print "$Blue"  "<<< Domain = $dm >>>"
echo " "
subfinder -d $dm -o subfinder.txt
sleep 1

#****************************************************************************#

print "$Green" "<<< ASSET FINDER STARTED >>>"
print "$Blue"  "<<< Domain = $dm >>>"
echo " "
assetfinder -subs-only $dm > assetfinder.txt
sleep 1

#****************************************************************************#

print "$Green" "<<< FIND DOMAIN STARTED >>>"
print "$Blue"  "<<< Domain = $dm >>>"
echo " "
findomain -t $dm -u findomain.txt
sleep 1

#****************************************************************************#

print "$Green" "<<< SUBLIST3R STARTED >>>"
print "$Blue"  "<<< Domain = $dm >>>"
echo " "
python3 ~/Tools/Sublist3r/sublist3r.py -d $dm -o ~/Recon/$dm/SubdomainEnumeration/sublist3r.txt   
sleep 1

#****************************************************************************#

print "$Green" "<<< SUBBRUTE STARTED >>>"
print "$Blue"  "<<< Domain = $dm >>>"
echo " "
subbrute -t $dm -o subbrute.txt
sleep 1

#****************************************************************************#

echo " "
print "$Green" "<<< GITHUB SUBDOMAIN ENUMERATION STARTED >>>"
print "$Blue"  "<<< Domain = $dm >>>"
print ""
github-subdomains  -t $token -d $dm | tee  githubrecon.txt
sleep 1

##############################################################################

echo " "
print "$Magenta" "<<< REMOVING DUPLICATES AND SORTING >>>"
cat *.txt | sort -u > allsubdomain.txt 
cat allsubdomain.txt | wc -l
sleep 1

###############################################################################

echo " "
print "$Magenta" "<<< SACNNING FOR LIVE DOMAINS >>>"
cat allsubdomain.txt | httprobe -c 50 -t 3000 -p 80,443 | tee -a live.txt
cat live.txt | wc -l
sleep 1

###############################################################################

echo " "
print "$Magenta" "<<< GREPING ONLY HTTPS >>>"
cat live.txt | grep "https" | cut -d"/" -f3 > live-https.txt | wc -l 
sleep 1

##############################################################################

echo " "
print "$Magenta" "<<< TAKING WEB SCREENSHOTS FOR ALL THE DOMAIN >>>"
mkdir aquatone && cat live.txt | aquatone -out aquatone
eyewitness -f live.txt -d eyewitness  --no-prompt       
sleep 1

##############################################################################

cd ../
mkdir dirsearch
echo " "
print "$green"   "<<< DIR SEARCH STARTED FOR ALL THE DOMAINS >>>"
print "$yellow"  "<<< THIS PROCESS TAKES SOME TIME IF YOU DONT NEED
                          PRESS $red CTRL + C  >>>"
while read -r domain ; do
echo " Domain : $domain"
dirsearch -u $domain -e php,asp,aspx,net,js,cs,php2,php3,php4,php5,php6,php7,jsp,java,python,yaml,yml,config,conf,htaccess,htpasswd,shtml | tee dirsearch/$domain.txt                          

done < SubdomainEnumeration/live.txt

##############################################################################
mkdir parameters       
         
         case $domain in
         
         all | ALL )
         echo "$Cyan GAU and WAYBACKURLS started including SUBDOMAINS"
         cat  SubdomainEnumeration/live.txt | waybackurls | sort -u > parameters/wayback.txt
         sleep 1
         cat  SubdomainEnumeration/live.txt | gau | sort -u > parameters/allgau.txt
         cd parameters
         cat *.txt | sort -u > parameters/allurls.txt
         echo
         echo "$Green Total URLs Found"
         cat allurls.txt | wc -l 
         cd ../
         sleep 2
         
         mkdir paramsider
         
         print "$Cyan" "<<< PARAMSPIDER STARED CRAWLING URLs FOR ALL THE SUBDOAMINS
                            THIS MAY TAKE WHILE TO STOP THIS $Red CTRL + C >>>" 
         
         cat 'SubdomainEnumeration/live.txt' | xargs -I % paramspider -l high -o paramspider/% -d.txt % ; 
         cat paramspider/*.txt | sort -u > allparam.txt
         echo
         echo " Total Paramspider URLs "
         cat allparam.txt | wc -l
         ;;
         


      *)

        cd parameters
 
        print "$Cyan" "<<< URL Crawling started MAIN domain only >>>"

        waybackurls $dm | tee "$dm wayback.txt"
        echo " "
        cat "$dm wayback.txt" | sort -u | wc -l

        gau $dm | tee "$dm gau.txt" 
        echo " "
        cat "$dm gau.txt" | sort -u | wc -l

        paramspider --domain $dm | tee "$dm paramspider.txt"
        echo " "
        cat "$dm paramspider.txt" | sort -u | wc -l  
        cat *.txt | sort -u > allurls.txt
        cd ../

        ;;
        esac  

################################################################################

# Finding Vunlnerable URLs
mkdir Vunlerable-URLs

printf "$Cyan"   "Findigs XSS"
gf xss parameters/allurls.txt |  tee  Vunlerable-URLs/xss.txt
echo "$Green XSS PARAMETERS ARE"
echo
cat Vunlerable-URLs/xss.txt | wc -l

printf "$Cyan"   "Findigs SSRF"
gf ssrf parameters/allurls.txt |  tee  Vunlerable-URLs/ssrf.txt
echo "$Green SSRF PARAMETERS ARE"
echo
cat Vunlerable-URLs/ssrf.txt | wc -l

##################################################################################





 
 
