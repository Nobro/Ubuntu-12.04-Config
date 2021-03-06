#Basic Ubuntu 12.04 3NIC Config

              ____                                  ____
             |    |            192.168.1.50/24     |    |      10.0.1.1/26
        WAN--| AP |---------------------------eth1-|SRV |-eth2----------
             |____|                                |____|                                                           
                                                     |
                                                   eth0   
                                                     | 10.0.0.1/26
                                                     |
                                                                                                                       
* * * *

sudo su

ip addr add 10.0.0.1/26 broadcast 10.0.0.63 dev eth0

ip addr add 10.0.1.1/26 broadcast 10.0.1.63 dev eth2

iptables -A FORWARD -o eth1 -i eth0 -s 10.0.0.1/26 -m conntrack --ctstate NEW -j ACCEPT

iptables -A FORWARD -o eth1 -i eth2 -s 10.0.1.1/26 -m conntrack --ctstate NEW -j ACCEPT

iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -t nat -F POSTROUTING # OPTIONAL Flushes Postrouting to make sure no other rules will interfere just in case

iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE

sudo iptables-save | sudo tee /etc/iptables.sav

vim /etc/rc.local

~~~

//add before exit 0 line

iptables-restore < /etc/iptables.sav

ip addr add 10.0.0.1/26 broadcast 10.0.0.63 dev eth0

ip addr add 10.0.1.1/26 broadcast 10.0.1.63 dev eth2

~~~

sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward" #set port forwarding for ipv4

vim /etc/sysctl.conf

~~~

//uncoment this line

net.ip4.ip_forward=1

~~~

apt-get install dnsmasq dnsmasq-base- #install dnsmasq remove dnsmasq-base

/etc/init.d/dnsmasq stop

vim /etc/dnsmasq.conf

~~~

//add and uncomment accordingly

except-interface=eth1 #dhcp to all interfaces except eth1

dhcp-range=eth0,10.0.0.10,10.0.0.20,72h #eth0 is not neaded but it is nice for future revisions

dhcp-range=eth2,10.0.1.10,10.0.1.20,72h #eth2 is not neaded but it is nice for future revisions

~~~

/etc/init.d/dnsmasq restart

reboot

ip addr show //test
