#!/bin/sh
clear
echo "Starting ENCRYPT Masternode download and install script"
echo "Updating/Upgrading OS..."
sudo apt update && sudo apt upgrade -y
echo "Downloading EncryptNetwork latest build..."
wget -N https://github.com/EncryptNetwork/EncryptNetwork/releases/download/1.3.0.0/encrypt-1.3.0.0-linux.zip
echo "Installing unzip..."
sudo apt-get install unzip -y
echo "Unzipping latest zip..."
sudo unzip -jo encrypt-1.3.0.0-linux.zip -d /usr/local/bin
sudo chmod +x /usr/local/bin/encrypt*
echo "Creating .encrypt directory..."
mkdir ~/.encrypt
cd ~/.encrypt
echo "Editing encrypt.conf..."
echo rpcuser= >> encrypt.conf
echo rpcpassword= >> encrypt.conf
echo rpcallowip=127.0.0.1 >> encrypt.conf
echo server=1 >> encrypt.conf
echo daemon=1 >> encrypt.conf
echo listen=1 >> encrypt.conf
echo staking=0 >> encrypt.conf
echo logtimestamps=1 >> encrypt.conf
echo masternode=1 >> encrypt.conf
echo externalip= >> encrypt.conf
echo masternodeprivkey= >> encrypt.conf
vi encrypt.conf >> encrypt.conf
echo "Setting up and enabling fail2ban..."
sudo apt-get install fail2ban -y
sudo ufw allow ssh
sudo ufw allow 2020
sudo ufw allow 2121
sudo ufw enable
echo "Launching encryptd..."
encryptd -daemon
echo "Cleaning up..."
cd
rm -rf encrypt-1.3.0.0-linux.zip
echo "ENCRYPT Masternode installed successfully!"