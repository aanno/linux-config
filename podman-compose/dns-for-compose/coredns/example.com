example.com.            IN          SOA dns.example.com. robbmanes.example.com. 2015082541 7200 3600 1209600 3600
gateway.example.com.    IN  A       192.168.1.1
dns.example.com.        IN  A       192.168.1.2
host.example.com.       IN  A       192.168.1.3
server.example.com.     IN  CNAME   host.example.com
