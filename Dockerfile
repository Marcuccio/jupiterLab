FROM kalilinux/kali-rolling

EXPOSE 8888

RUN  apt-get update \
  && apt-get install -y apt-utils \
  && apt-get install -y software-properties-common wget locate

RUN apt-get update

#installing python 
RUN apt-get install -y python3 && ln /usr/bin/python3 /usr/bin/python
RUN apt-get install -y git

#install basics
RUN echo "Installing Basics!" && apt-get install zip -qq -y
RUN echo "Installing certbot!" && apt-get install certbot -qq -y
RUN echo "Installing pip3!" && apt install python3-pip -qq -y
RUN echo "Installing awscli!" && pip3 install awscli -q

#Install Python PIP
RUN echo "Installing Python PIP!" \
  && wget -q https://bootstrap.pypa.io/get-pip.py -O get-pip.py \
  && python get-pip.py \
  && rm get-pip.py

#Install Juypter
RUN echo "Installing Jupyter!" \
  && pip3 install jupyter -q \
  && pip3 install --upgrade --force jupyter-console -q \
  && pip3 install pandas -q \
  && pip3 install openpyxl -q \
  && mkdir -p /root/.jupyter/ssl
RUN openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=IT/ST=IT/L=CITY/O=JUSTME/CN=CNAME" -keyout /root/.jupyter/ssl/mykey.key -out /root/.jupyter/ssl/mycert.pem

#Make Tools Directory
RUN mkdir /root/Tools
 
#Install GoLang
RUN echo "Installing GoLang!" \
  && apt-get install golang-go -qq -y 
  
#Install Subfinder
RUN echo "Installing Subfinder!" \
  && GO111MODULE=on go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder \
  && mkdir /root/Tools/subfinder \
  && cp /root/go/bin/subfinder /root/Tools/subfinder/

#Install assetfinder
RUN echo "Installing assetfinder!" \
  && go get -u github.com/tomnomnom/assetfinder \
  && mkdir /root/Tools/assetfinder \
  && cp /root/go/bin/assetfinder /root/Tools/assetfinder/ \
  && cp /root/go/bin/assetfinder /usr/local/bin/

#Install dnsx
RUN echo "Installing dnsx!" \
  && GO111MODULE=on go get -u -v github.com/projectdiscovery/dnsx/cmd/dnsx \
  && mkdir /root/Tools/dnsx \
  && cp /root/go/bin/dnsx /root/Tools/dnsx \
  && cp /root/go/bin/dnsx /usr/local/bin/

#Install Infoga
RUN echo "Installing Infoga!" \
  && git clone https://github.com/m4ll0k/Infoga.git /root/Tools/Infoga -q \
  && python /root/Tools/Infoga/setup.py install

#Install ShodanScraper
#Need to initialize Shodan API Key!
#RUN echo "Installing ShodanScraper!" \
#  && git clone https://github.com/ariel-shin/Recon-Scripts/blob/master/shodanScraper.py /root/Tools/shodanScraper \
#  && chmod +x /root/Tools/shodanScraper/shodanScraper.py \
#  && python3 -m easy_install shodan


#Install CloudEnum
RUN echo "Installing CloudEnum!" \
  && git clone https://github.com/initstring/cloud_enum.git /root/Tools/cloud_enum -q \
  && pip3 install -r /root/Tools/cloud_enum/requirements.txt -q

#Install GitDorker
RUN echo Installing GitDorker \
  && git clone https://github.com/obheda12/GitDorker /root/Tools/GitDorker -q \
  && pip3 install -r /root/Tools/GitDorker/requirements.txt -q \
  && rm /root/Tools/GitDorker/*png

COPY OSINT/Jupyter_OSINT.ipynb /root/.jupyter/

RUN rm -rf /var/lib/apt/lists/*

CMD jupyter-notebook --allow-root --ip=0.0.0.0 --notebook-dir /root/.jupyter
