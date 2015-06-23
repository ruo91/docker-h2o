# Dockerfile - H2O Web Server
##### - Run
```
[root@ruo91 ~]# docker run -d --name="h2o" -h "h2o" ruo91/h2o
```

or

##### Build
```
[root@ruo91 ~]# git clone https://github.com/ruo91/docker-h2o /opt/docker-h2o
[root@ruo91 ~]# cd /opt/docker-h2o
[root@ruo91 ~]# docker build --rm -t h2o:latest .
```

##### - Run
```
[root@ruo91 ~]# docker run -d --name="h2o" -h "h2o" h2o:latest
```

##### - Test
```
[root@ruo91 ~]# H2O_IP="`docker inspect -f '{{ .NetworkSettings.IPAddress }}' h2o`"
[root@ruo91 ~]# curl -k -v -4 https://$H2O_IP
```
```
* Rebuilt URL to: https://172.17.0.84/
* Hostname was NOT found in DNS cache
*   Trying 172.17.0.84...
* Connected to 172.17.0.84 (172.17.0.84) port 443 (#0)
* successfully set certificate verify locations:
*   CAfile: none
  CApath: /etc/ssl/certs
* SSLv3, TLS handshake, Client hello (1):
* SSLv3, TLS handshake, Server hello (2):
* SSLv3, TLS handshake, CERT (11):
* SSLv3, TLS handshake, Server key exchange (12):
* SSLv3, TLS handshake, Server finished (14):
* SSLv3, TLS handshake, Client key exchange (16):
* SSLv3, TLS change cipher, Client hello (1):
* SSLv3, TLS handshake, Finished (20):
* SSLv3, TLS change cipher, Client hello (1):
* SSLv3, TLS handshake, Finished (20):
* SSL connection using ECDHE-RSA-AES256-GCM-SHA384
* Server certificate:
*        subject: C=US; ST=New York; L=NYC; O=localhost; OU=localhost; CN=*.localhost; emailAddress=root@localhost
*        start date: 2015-06-23 15:09:48 GMT
*        expire date: 2015-06-23 15:09:48 GMT
*        issuer: C=US; ST=New York; L=NYC; O=localhost; OU=localhost; CN=*.localhost; emailAddress=root@localhost
*        SSL certificate verify result: self signed certificate (18), continuing anyway.
> GET / HTTP/1.1
> User-Agent: curl/7.35.0
> Host: 172.17.0.84
> Accept: */*
>
< HTTP/1.1 200 OK
< Date: Tue, 23 Jun 2015 17:27:45 GMT
* Server h2o/1.3.1 is not blacklisted
< Server: h2o/1.3.1
< Connection: keep-alive
< Content-Length: 335
< content-type: text/html
< last-modified: Tue, 23 Jun 2015 12:50:03 GMT
< etag: "558955fb-14f"
< vary: accept-encoding
< accept-ranges: bytes
< cache-control: max-age=39420000, must-revalidate
< content-security-policy: script-src self https://apis.google.com https://ajax.cloudflare.com
< x-frame-options: SAMEORIGIN
< strict-transport-security: max-age=31536000; includeSubDomains; preload
< x-content-type-options: nosniff
<
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="canonical" href="./" />
<link rel="stylesheet" href="assets/style.css" type="text/css" />
<title>H2O</title>
</head>

<body>
<h1>Hi!</h1>

This webserver is powered by <a href="http://h2o.github.io/">h2o</a>.
</body>
* Connection #0 to host 172.17.0.84 left intact
```

### Version
latest
