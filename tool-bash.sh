#!/bin/bash

#importing colors
Red=$'\e[1;31m'
Green=$'\e[1;32m'
Blue=$'\e[1;34m'


echo " $Red

888       888          888                                         
c888  o   888          888                                         
888  d8b  888          888                                         
888 d888b 888  .d88b.  888  .d8888b .d88b.  88888b.d88b.   .d88b.  
888d88888b888 d8P  Y8b 888 d88P    d88  88b 888  888  88b d8P  Y8b 
88888P Y88888 88888888 888 888     888  888 888  888  888 88888888 
8888P   Y8888 Y8b.     888 Y88b.   Y88..88P 888  888  888 Y8b.     
888P     Y888   Y8888  888   Y8888P  Y88P   888  888  888 Y8888   

$Green TO BUGBOUNTY HUNTING AND WEB-APPLICATION PENETRATION TESTING TOOLS SETUP
           
                                                    author @selvaganesh
                                                                     "
sleep 2
echo "$Blue All the requried tools will be installed now"
sleep 4

cd ~
mkdir Tools
cd Tools 
sudo apt update
sudo apt install -y python3-pip
sudo apt-get install -y cargo
sudo pip install dnspython
sudo pip install requests
sudo pip install argparse
sudo apt-get install python-argparse
sudo apt install -y eyewitness
sudo apt-get install -y jq
sudo pip3 install arjun
sudo apt install cmake
sudo pip3 install h2


echo "$Green Installing Golang"

wget https://dl.google.com/go/go1.16.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.16.3.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> ~/.zshrc
echo 'export GOPATH=$HOME/go'	>> ~/.zshrc			
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc
source ~/.zshrc

echo "SUBDOMAIN FINDERS"
go get -u github.com/tomnomnom/assetfinder
go get -u github.com/tomnomnom/anew
go get -u github.com/tomnomnom/unfurl
git clone https://github.com/Edu4rdSHL/findomain.git
git clone https://github.com/aboul3la/Sublist3r.git
git clone https://github.com/projectdiscovery/subfinder.git
git clone https://github.com/TheRook/subbrute.git
git clone https://github.com/maurosoria/dirsearch.git
git clone https://github.com/devanshbatham/ParamSpider
git clone https://github.com/gwen001/github-search.git
git clone https://github.com/BishopFox/h2csmuggler.git
git clone https://github.com/ameenmaali/urldedupe.git

mkdir wordlists
cd wordlists
git clone https://github.com/danielmiessler/SecLists.git
git clone https://github.com/fuzzdb-project/fuzzdb.git
git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git
cd ../


cd findomain
cargo build --release
sudo cp target/release/findomain /usr/bin
cd ../

cd Sublist3r
pwd > path.txt
ph=$(< path.txt)
sudo ln -sf $ph/sublist3r.py /usr/bin/sublist3r
sudo rm path.txt
cd ../

cd subbrute
pwd > path.txt
ph=$(< path.txt)
sudo cp $ph/resolvers.txt /usr/local/bin/
rm path.txt
cd ../


cd subfinder/v2/cmd/subfinder
go build
sudo mv subfinder /usr/local/bin/
cd ../../../../

cd subbrute
pwd > path.txt
ph=$(< path.txt)
sudo ln -sf $ph/subbrute.py /usr/bin/subbrute
sudo rm path.txt
cd ../

cd dirsearch
pip3 install -r requirements.txt
pwd > path.txt
ph=$(< path.txt)
sudo ln -sf $ph/dirsearch.py /usr/local/bin/dirsearch
sudo rm path.txt
cd ../

cd ParamSpider
pip3 install -r requirements.txt
pwd > path.txt
ph=$(< path.txt)
sudo ln -sf $ph/paramspider.py /usr/local/bin/paramspider
sudo rm path.txt
cd ../

cd github-search
pip3 install -r requirements2.txt
pip3 install -r requirements3.txt
pwd > path.txt
ph=$(< path.txt)
sudo ln -sf $ph/github-subdomains.py /usr/local/bin/github-subdomains
sudo rm path.txt
cd ../

cd urldedupe
cmake CMakeLists.txt
make
sudo cp urldedupe /usr/local/bin/urldedupe
cd ../

cd h2csmuggler
pwd > path.txt 
ph=$(< path.txt)
sudo ln -sf $ph/h2csmuggler.py /usr/local/bin/h2csmuggler
sudo rm path.txt
cd ../

echo " $Green Installing Other tools"

go get github.com/tomnomnom/waybackurls
go get -u -v github.com/lc/gau
go get -u github.com/tomnomnom/qsreplace
go get -u github.com/tomnomnom/httprobe
go get -u github.com/ffuf/ffuf
go get -u github.com/tomnomnom/gf
git clone https://github.com/1ndianl33t/Gf-Patterns
GO111MODULE=on go get -u -v github.com/bp0lr/gauplus 


sudo cp ~/go/bin/* /usr/local/bin

echo "export PATH=$PATH:/usr/local/bin/waybackurls" >> ~/.bashrc
echo "export PATH=$PATH:/usr/local/bin/gau" >> ~/.bashrc
echo "export PATH=$PATH:/usr/local/bin/qsreplace" >> ~/.bashrc
echo "export PATH=$PATH:/usr/local/bin/httprobe" >> ~/.bashrc
echo "export PATH=$PATH:/usr/local/bin/gf" >> ~/.bashrc
echo "source /home/selvaganesh/go/pkg/mod/github.com/tomnomnom/gf@v0.0.0-20200618134122-dcd4c361f9f5/gf-completion.bash" >> ~/.bashrc
~/.bashrc
echo "export PATH=$PATH:/usr/local/bin/ffuf" >> ~/.bashrc
source ~/.bashrc

mkdir ~/.gf
cp -r "/home/selvaganesh/go/pkg/mod/github.com/tomnomnom/gf@v0.0.0-20200618134122-dcd4c361f9f5/examples/*" ~/.gf
cd "Gf-Patterns"
cp *.json ~/.gf
source ~/.gf

source ~/.bashrc
echo "$Green 




 ____  _   _  ____ _____ ____ ____  _____ _   _ _     _  __   __
/ ___|| | | |/ ___| ____/ ___/ ___||  ___| | | | |   | | \ \ / /
\___ \| | | | |   |  _| \___ \___ \| |_  | | | | |   | |  \ V / 
 ___) | |_| | |___| |___ ___) |__) |  _| | |_| | |___| |___| |  
|____/ \___/ \____|_____|____/____/|_|    \___/|_____|_____|_|  
                                                                
 ___ _   _ ____ _____  _    _     _     _____ ____  
|_ _| \ | / ___|_   _|/ \  | |   | |   | ____|  _ \ 
 | ||  \| \___ \ | | / _ \ | |   | |   |  _| | | | |
 | || |\  |___) || |/ ___ \| |___| |___| |___| |_| |
|___|_| \_|____/ |_/_/   \_\_____|_____|_____|____/ 
                                                    100%
                                                    
        #########   THANK YOU   #########                                         





"




