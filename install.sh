#/bin/bash

echo "*******************************"
echo "*                             *"
echo "*      TimeIsMoney (TIM)      *"
echo "*         Masternode          *"
echo "*            SETUP            *"
echo "*******************************"
echo ""
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!                                                 !"
echo "! Make sure you double check before hitting enter !"
echo "!                                                 !"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo && echo && echo

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

IP==$(curl -s4 icanhazip.com)
echo -e "${GREEN}Please enter your private key: (Copy from Windows and right click to paste and press enter)${NC}" 
read KEY
sleep 2
echo ""
echo ""
echo -e "${RED}Updating environment and installing dependencies${NC}"
sleep 5

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install libboost-all-dev libevent-dev software-properties-common -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
sudo apt-get install libpthread-stubs0-dev -y
sudo apt-get install libzmq3-dev -y
sudo apt install -y make build-essential libtool software-properties-common autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev \
libboost-program-options-dev libboost-system-dev libboost-test-dev libboost-thread-dev sudo automake git curl libdb4.8-dev \
bsdmainutils libdb4.8++-dev libminiupnpc-dev libgmp3-dev ufw pkg-config libevent-dev libdb5.3++ unzip libzmq5

sleep 2
echo -e "${GREEN}Creating Swap Space${NC}"
sleep 5 
cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo free
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
cd
sleep 2
echo -e "${GREEN}Installing & Configuring FIREWALL (ufw)${NC}"
sleep 5
sudo apt-get install -y ufw
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw allow 11333/tcp
sudo ufw logging on
echo "y" | sudo ufw enable
sleep 2
echo ""
echo ""
echo -e "${GREEN}Moving wallet -daemon & -client to local user directory${NC}"
cd
cd timenode
sudo unzip daemon.zip
sudo rm -rf daemon.zip
sudo chmod +x /root/timenode/timeismoney-cli /root/timenode/timeismoneyd /root/timenode/timeismoney-tx
sudo mv /root/timenode/timeismoney-cli /root/timenode/timeismoneyd /root/timenode/timeismoney-tx /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/
cd
cd /root
cd .timeismoney/mainnet

sleep 5

echo -e "${GREEN}Configuring Wallet${NC}"


echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /root/.timeismoney/mainnet/timeismoney.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /root/.timeismoney/mainnet/timeismoney.conf
echo "rpcallowip=127.0.0.1" >> /root/.timeismoney/mainnet/timeismoney.conf
echo "listen=1" >> /root/.timeismoney/mainnet/timeismoney.conf
echo "server=1" >> /root/.timeismoney/mainnet/timeismoney.conf
echo "daemon=1" >> /root/.timeismoney/mainnet/timeismoney.conf
echo "maxconnections=250" >> /root/.timeismoney/mainnet/timeismoney.conf
echo "masternode=1" >> /root/.timeismoney/mainnet/timeismoney.conf
echo "masternodeaddr=$IP:11333" >> /root/.timeismoney/mainnet/timeismoney.conf
echo "port=$IP:11333" >> /root/.timeismoney/mainnet/timeismoney.conf
echo "rpcport=$IP:11334" >> /root/.timeismoney/mainnet/timeismoney.conf
echo "externalip=$IP:11333" >> /root/.timeismoney/mainnet/timeismoney.conf
echo "masternodeprivkey=$KEY" >> /root/.timeismoney/mainnet/timeismoney.conf
cd /root

sleep 1 

echo -e "${RED}Stopping Client${NC}"

sudo timeismoney-cli stop

echo -e "${GREEN}RESTARTING DAEMON${NC}"

sudo timeismoneyd -daemon

sleep 10 

timeismoney-cli masternode status

sleep 10

timeismoney-cli masternode debug
timeismoney-cli mnsync status


sleep 20

echo -e "${GREEN}Waiting for Node to sync{NC}"

sleep 10

timeismoney-cli mnsync status
sleep 2
echo ""
echo ""
echo -e "Thank you for installing the TimeIsMoney HOT/COLD wallet.  Follow the instructions to move to the ${RED}NEXT${NC} step."
