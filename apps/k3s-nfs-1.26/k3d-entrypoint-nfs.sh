#!/bin/sh

set -o errexit
set -o nounset
set -o pipefail

( echo "Delay checking rc status..." && \
    sleep 10 && \
    echo "Starting check rc status" && \
    #/bin/rc-status > /tmp/rcstatus.moises && cat /tmp/rcstatus.moises && \
    /bin/rc-status && \
    echo "End checking rc status" ) &

( echo "Delaying nfs start..." && \
    sleep 20 && \
    echo "Starting nfs" && \
    touch /run/openrc/softlevel && \
    /sbin/rc-service nfs start && \
    echo "End nfs restart proccess" ) &

echo "Starting k3s"
exec /bin/k3s "$@"