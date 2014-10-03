# PIA-Launch

PIA-Launch is a simple wrapper for OpenVPN for use with [Private Internet Access](https://www.privateinternetaccess.com/) on Linux.


### Setup

Copy the contents of the /etc/openvpn directory here to your system. The resolv.conf file used has the DNS servers for [this](http://blog.censurfridns.dk/en/about) service. You may modify this file to point to another DNS server if you wish. Then, edit the /etc/openvpn/privateinternetaccess/auth/credentials.txt file with your login/password. You may want to chmod this file to protect it.

Last, download the setup files from Private Internet Access [here](https://www.privateinternetaccess.com/openvpn/openvpn-ip.zip) and place them in the directory /etc/openvpn/privateinternetaccess/. The script will provide you with a list of servers to choose from when run.
