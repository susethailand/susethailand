#!/bin/sh
# #############################################################################
# Author: Sontaya Potibut <susethailand.com@gmail.com>, Sep 15, 2011
# Website: http://www.susethailand.com
# This program is distributed under the terms of the GNU General Public License
## ############################################################################

# /etc/init.d/sphinx
# and its symbolic link
# ln -s /etc/init.d/sphinx /usr/sbin/rcsphinx 

### BEGIN INIT INFO
# Provides:            sphinx
# Default-Start:       2 3 5
# Default-Stop:        0 1 6
# Description:         Sphinx is an Open Source Search Server and increasing performance of MySQL queries for LogZilla
### END INIT INFO

# Source SuSE config, only if exists with size greater zero
test -s /etc/rc.config && \
    . /etc/rc.config

# Shell functions sourced from /etc/rc.status:
#      rc_check         check and set local and overall rc status
#      rc_status        check and set local and overall rc status
#      rc_status -v     ditto but be verbose in local rc status
#      rc_status -v -r  ditto and clear the local rc status
#      rc_failed        set local and overall rc status to failed
#      rc_failed <num>  set local and overall rc status to <num><num>
#      rc_reset         clear local rc status (overall remains)
#      rc_exit          exit appropriate to overall rc status

export sphinx_HOME=/srv/www/htdocs/lz/sphinx/bin
sphinx_pid="$sphinx_HOME/sphinx.pid"
sphinx="$sphinx_HOME/searchd -c /srv/www/htdocs/lz/sphinx/sphinx.conf"
sphinx_status="$sphinx_HOME/searchd"

test -s /etc/rc.status && \
     . /etc/rc.status

test -x $red || exit 5

# First reset status of this service
rc_reset

# Return values acc. to LSB for all commands but status:
# 0 - success
# 1 - generic or unspecified error
# 2 - invalid or excess argument(s)
# 3 - unimplemented feature (e.g. "reload")
# 4 - insufficient privilege
# 5 - program is not installed
# 6 - program is not configured
# 7 - program is not running
# 
# Note that starting an already running service, stopping
# or restarting a not-running service as well as the restart
# with force-reload (in case signalling is not supported) are
# considered a success.

case "$1" in
    start)
  test -s ${sphinx_pid} && {
	    killproc -p ${sphinx_pid} ${sphinx}
	    echo -n "Re-"
	}
	echo -n "Starting Sphinx search server services"
	startproc -p ${sphinx_pid} ${sphinx} 
	rc_status -v

	;;
    stop)
	echo -n "Shutting sphinx Search Server"
	ps -ef | awk '/searchd/ && !/awk/ {print $2}' pid= > ${sphinx_pid}
	kill `cat $sphinx_pid`
	rc_status -v
	rm -f ${sphinx_pid}
	;;
    try-restart)
	$0 status >/dev/null &&  $0 restart
	rc_status
	;;
    restart)
	$0 stop
	$0 start
	rc_status
	;;
    force-reload)
	if ps -C cupsd -o user | grep -q '^root$'; then
	    echo -n "Reload service sphinx"
	    killproc -HUP $sphinx
	    rc_status -v
	else
	    $0 restart
	fi
	;;
    reload)
	if ps -C cupsd -o user | grep -q '^root$'; then
	    echo -n "Reload service sphinx"
	    killproc -HUP $sphinx
	    rc_status -v
	else
	    echo -n '"reload" not possible in RunAsUser mode - use "restart" instead'
	    rc_status -s
	fi
	;;
    status)
	echo -n "Checking for Sphinx Search Server: "
	checkproc $sphinx_status
	rc_status -v
	;;
    probe)
	rc_failed 3
	;;
    *)
	echo "Usage: $0 {start|stop|status}"
	exit 1
	;;
esac
rc_exit
