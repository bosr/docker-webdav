#!/bin/bash

# declare trap behavior
_graceful_shutdown() {
	echo "gracefully shutting down"
	pidfile="/var/run/apache2.pid"
	kill -s 28 $(<"$pidfile") 2>/dev/null
}
trap _graceful_shutdown SIGWINCH


# start apache
echo "Preparing htpassword..."
htpasswd -cb /etc/apache2/webdav.password $USERNAME $PASSWORD
chown root:www-data /etc/apache2/webdav.password
chmod 640 /etc/apache2/webdav.password

echo "Starting Apache"
apache2 -D FOREGROUND &

# wait for apache to exit
child=$!
wait "$child"


# check exit code is 0 or 156 (apache2 graceful exit code) -> exit 0
# other codes are returned as is for error analysis
rc=$?; if [[ $rc == 0 || $rc == 156 ]]; then exit 0; else $rc; fi
