#!/bin/bash
_graceful_shutdown() {
	echo "gracefully shutting down"
	pidfile="/var/run/apache2.pid"
	kill -s 28 $(<"$pidfile")
}

trap _graceful_shutdown SIGWINCH

echo "Preparing htpassword..."
htpasswd -cb /etc/apache2/webdav.password $USERNAME $PASSWORD
chown root:www-data /etc/apache2/webdav.password
chmod 640 /etc/apache2/webdav.password

echo "Starting Apache"
apache2 -D FOREGROUND &

child=$!
wait "$child"
