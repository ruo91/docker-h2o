# Dockerfile - H2O Web Server

##### Build
```
[root@ruo91 ~]# git clone https://github.com/ruo91/docker-h2o /opt/docker-h2o
[root@ruo91 ~]# cd /opt/docker-h2o
[root@ruo91 ~]# docker build --rm -t h2o:source .
```

##### - Run
```
[root@ruo91 ~]# docker run -d --name="h2o" -h "h2o" -p 8080:80 h2o:source
```

##### - Run
```
[root@ruo91 ~]# curl -l http://localhost:8080
```
```
HTTP/1.1 200 OK
Date: Wed, 17 Jun 2015 03:04:37 GMT
Server: h2o/1.2.1-alpha1
Connection: keep-alive
Content-Length: 335
content-type: text/html
last-modified: Wed, 17 Jun 2015 02:46:37 GMT
etag: "5580df8d-14f"
vary: accept-encoding
accept-ranges: bytes
cache-control: max-age=39420000, must-revalidate
set-cookie: test=1
x-content-type-options: nosniff
```

### Version
latest