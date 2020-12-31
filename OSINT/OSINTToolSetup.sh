
#!/bin/bash

#Tool Install

{
#Make Tools Directory
mkdir /root/Tools

#Install GoLang
echo Installing GoLang!
apt-get install golang-go -qq -y

#Install Subfinder
echo Installing Subfinder!
GO111MODULE=on go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
mkdir /root/Tools/subfinder
cp /root/go/bin/subfinder /root/Tools/subfinder/

#Install assetfinder
echo Installing assetfinder!
go get -u github.com/tomnomnom/assetfinder
mkdir /root/Tools/assetfinder
cp /root/go/bin/assetfinder /root/Tools/assetfinder/
cp /root/go/bin/assetfinder /usr/local/bin/

#Install dnsprobe
#echo Installing dnsprobe!
#go get -u github.com/projectdiscovery/dnsprobe
#mkdir /root/Tools/dnsprobe
#cp /root/go/bin/dnsprobe /root/Tools/dnsprobe/
#cp /root/go/bin/dnsprobe /usr/local/bin/

#Install Infoga
echo Installing Infoga!
git clone https://github.com/m4ll0k/Infoga.git /root/Tools/Infoga -q
python /root/Tools/Infoga/setup.py install

#Install ShodanScraper
#Need to initialize Shodan API Key!
echo Installing ShodanScraper!

git clone https://github.com/ariel-shin/Recon-Scripts/blob/master/shodanScraper.py /root/Tools/shodanScraper
chmod +x /root/Tools/shodanScraper/shodanScraper.py
python3 -m easy_install shodan

#Install CloudEnum
echo Installing CloudEnum!
git clone https://github.com/initstring/cloud_enum.git /root/Tools/cloud_enum -q
pip3 install -r /root/Tools/cloud_enum/requirements.txt -q

#Install GitDorker
echo Installing GitDorker
git clone https://github.com/obheda12/GitDorker /root/Tools/GitDorker -q
pip3 install -r /root/Tools/GitDorker/requirements.txt -q
rm /root/Tools/GitDorker/*png
}
