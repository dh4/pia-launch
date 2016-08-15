#!/bin/sh

# Check for root
if [[ "$EUID" != 0 ]]; then
    echo "Please run as root"
    exit
fi


# Check for required files/directories
dir="/etc/openvpn/privateinternetaccess/"

if [[ -d $dir ]]; then
    cd $dir
else
    echo "$dir does not exist"
    exit
fi

if [[ ! -f "$dir/resolv.conf" ]]; then
    echo "Missing resolv.conf file"
    exit
fi

if [[ ! -f "$dir/ca.rsa.2048.crt" || ! -f "$dir/crl.rsa.2048.pem" ]]; then
    echo "Missing ca.rsa.2048.crt and crl.rsa.2048.pem file"
    exit
fi

if [[ ! -f "$dir/auth/auth.ovpn" || ! -f "$dir/auth/credentials.txt" ]]; then
    echo "Please create auth/auth.ovpn and auth/credentials.txt"
    exit
fi


# Present user with list to choose from
i=1
for file in *.ovpn; do
    if [[ $file == "*.ovpn" ]]; then #No .ovpn files
        echo "Please place .ovpn files in $dir"
        exit
    fi

    menu[$i]="$i) ${file%.*}"$'\n'
    servers[$i]="$file"
    (( i++ ))
done

while true; do
    echo " ${menu[@]}" | column
    read -p "Choose a server to connect to: " selection
    server=${servers[$selection]}

    if [[ $server != '' ]]; then
        break
    fi
done


# Setup DNS
mv /etc/resolv.conf /etc/resolv.conf.bak
cp ./resolv.conf /etc/resolv.conf


# Run OpenVPN
openvpn --config "$server" --config "auth/auth.ovpn"


# Reset DNS once VPN connection closed
mv /etc/resolv.conf.bak /etc/resolv.conf
