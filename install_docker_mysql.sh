echo  "---------------------------------------"
echo  "      Running sudo apt-get update"
echo  "---------------------------------------"
sudo apt-get update
echo  "---------------------------------------"
echo  "    Installing pre requisites for docker"
echo  "---------------------------------------"
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
echo  "---------------------------------------"
echo  "    adding docker to apt-get repository"
echo  "---------------------------------------"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
echo  "---------------------------------------"
echo  "           Installing Docker"
echo  "---------------------------------------"
sudo apt-get install docker-ce docker-ce-cli containerd.io
echo  "---------------------------------------"
echo  "       Installing docker-compose"
echo  "---------------------------------------"
sudo apt  install docker-compose
echo  "---------------------------------------"
echo  "         Installing mysql client"
echo  "---------------------------------------"
sudo apt install mysql-client-core-5.7
echo  "---------------------------------------"
echo "      Adding current user to docker group for using docker without sudo"
echo  "---------------------------------------"
sudo usermod -aG docker $USER
echo  "---------------------------------------"
echo  "         Please use following command to Running the App Installation"
echo  "                       docker-compose up"
echo  "---------------------------------------"
newgrp docker




