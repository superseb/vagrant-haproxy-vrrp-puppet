vagrant-haproxy-vrrp-puppet
===========================

Vagrant setup where Puppet will configure keepalived with a virtual IP and application check (HAProxy), and haproxy. A testcase to demonstrate HA setup for haproxy.

Usage  |  IP
------------- | -------------
haproxy01 | 172.28.33.10
haproxy02  | 172.28.33.11
web01 | 172.28.33.21
web02 | 172.28.33.22
haproxy VIP | 172.28.33.12

Link | URL
------------- | -------------
Stats page haproxy01 | http://localhost:8080
Stats page haproxy02 | http://localhost:8082
