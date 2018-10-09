# WebDAV container
(forked from morrisjobke/webdav)

You can run this container in following way. You can then access the WebDAV instance at `http://localhost:8888/webdav`. Internally the folder `/var/webdav` is used as WebDAV root.

    docker run -d --name webdav -e USERNAME=test -e PASSWORD=test -p 8888:80 bosr/webdav

Note: this container runs Apache 2, thus in order to gracefully stop it, you should use `kill`, not `stop`:

    docker kill --signal WINCH webdav

see [Apache 2 Documentation on the subject](https://httpd.apache.org/docs/2.4/stopping.html#gracefulstop).
