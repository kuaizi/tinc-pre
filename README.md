tinc-pre
====

[tinc][1] is a Virtual Private Network (VPN) daemon that uses tunnelling and
encryption to create a secure private network between hosts on the Internet.

To use this image, you need to have basic knowledges of tinc. (See this [tutor][2])

## Directory Tree

```
~/fig/tinc/
├── docker-compose.yml
└── tinc/
    └── netname/
        ├── hosts/
        │   ├── client
        │   ├── client-down*
        │   ├── client-up*
        │   └── server
        ├── rsa_key.priv
        ├── tinc.conf
        ├── tinc-down*
        └── tinc-up*
```
## build 

```
git clone --depth=1 https://github.com/kuaizi/tinc-pre
cd tinc-pre
chmod +x *.sh
docker build -t tinc-pre .
```

## docker-compose.yml

```yaml
tinc-pre:
  image: tinc-pre
  ports:
    - "655:655/tcp"
    - "655:655/udp"
  volumes:
    - ./tinc:/etc/tinc
  environment:
    - IP_ADDR=1.2.3.4
    - ADDRESS=10.20.30.1
    - NETMASK=255.255.255.0
    - NETWORK=10.20.30.0/24
    - RUNMODE=server
  cap_add:
    - NET_ADMIN
  dns: 8.8.8.8
  restart: always
```

## Server Setup

```bash
# run
$ docker-compose up -d

# monitor
$ docker-compose logs

# stats
$ docker-compose exec tinc tinc -n vpn top

#client
$ docker-compose exec tinc peer.sh client 10.20.30.2
```



https://github.com/vimagick/dockerfiles/tree/master/tinc
