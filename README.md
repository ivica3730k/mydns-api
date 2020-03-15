# MYDNS-API
PHP API for interfacing the database which is providing data for MyDNS server
Purpose of this API is to enable end users to add or modify all dns records without
need to write any SQL. 

**This API interfaces database to which MyDNS connects to, not the DNS Server itself.**

#### Docker images
In order to instal MyDNS server you can follow instructions at the link specified below.
But if you dont want to build from scratch you can pull docker images I created on docker hub and run a server in docker container. 
\
Docker image with only MYDNS server is available at : https://hub.docker.com/r/ivicamatic/mydns-server \
\
Docker image with MySQL server and MyDNS server is available at: https://hub.docker.com/repository/docker/ivicamatic/mydns 

On both links you have example of run command and doxygen-compose file in the Readme area.

#### About MYDNS server : http://mydns.bboy.net/]
MyDNS is a free DNS server for UNIX. It was implemented from scratch and is designed
to serve records directly from an SQL database (currently either MySQL or PostgreSQL).
Its primary objectives are stability, security, interoperability, and speed, 
though not necessarily in that order.
\ 
MyDNS does not include recursive name service, nor a resolver library. 
It is primarily designed for organizations with many zones 
and/or resource records who desire the ability to perform 
real-time dynamic updates on their DNS data via MySQL.
\
MyDNS starts and is ready to answer questions immediately, no 
matter how much DNS data you have in the database. It is very 
fast and memory-efficient. It includes complete documentation,
including a manual.
\
MyDNS supports a few frills, including round robin DNS, 
dynamic load balancing, and outgoing AXFR for non-MyDNS
nameservers.
