#!/bin/sh
#
# Author: Sontaya Potibut <susethailand.com@gmail.com>, 2009
# Website: www.susethailand.com
# /etc/init.d/h2server
#  and its symbolic link
# /usr/sbin/rch2server

### BEGIN INIT INFO
# Provides: h2server
# Default-Start:  2 3 5
# Default-Stop: 0 1 6
# Short-Description: H2 daemon, Start and Stop H2 Database Server
# Description:  H2 is the Java SQL database engine
### END INIT INFO

h2server_pid="/var/run/h2server.pid"
h2server="/usr/share/h2/bin/h2.sh"

. /etc/rc.status
rc_reset
case "$1" in
    start)
	test -s ${h2server_pid} && {
	    killproc -p ${h2server_pid} ${h2server}
	    echo -n "Re-"
	}
	echo -n "Starting h2server services"
	startproc -p ${h2server_pid} ${h2server} 
	rc_status -v
	;;
    stop)
	echo -n "Shutting down h2server services"
	ps -ef | awk '/org.h2.tools.Console/ && !/awk/ {print $2}' pid= > ${h2server_pid}
	kill `cat $h2server_pid`
        rc_status -v

	rm -f ${h2server_pid}
	;;
    status)
	echo -n "Checking for service h2server:"
	checkproc ${h2server} ; 
	rc_status -v
	;;
    *)
	echo "Usage: $0 {start|stop|status}"
	exit 1
	;;
esac
rc_exit
