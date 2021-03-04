#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="STORJ"
LOGFILE=/var/log/${QPKG_NAME}
QPKG_ROOT=`/sbin/getcfg $QPKG_NAME Install_Path -f ${CONF}`
APACHE_ROOT=`/sbin/getcfg SHARE_DEF defWeb -d Qweb -f /etc/config/def_share.info`
export QNAP_QPKG=$QPKG_NAME

case "$1" in
  start)
    echo `date` " STORJ : Request to start ($@) " >> $LOGFILE
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
	echo `date` " STORJ : $PKG_NAME is disabled " >> $LOGFILE
        exit 1
    fi
    : ADD START ACTIONS HERE
    echo `date` "Create $QPKG_ROOT/web folder link to STORJ folder " >> /tmp/runSTORJ.log
    ln -s $QPKG_ROOT/web /home/Qhttpd/Web/STORJ
    echo `date` " STORJ : Request to start ($@) completed " >> $LOGFILE
    ;;

  stop)
    echo `date` " STORJ : Request to stop ($@) " >> $LOGFILE
    : ADD STOP ACTIONS HERE
    rm /home/Qhttpd/Web/STORJ
    ;;

  restart)
    echo `date` " STORJ : Request restart ($@) " >> $LOGFILE
    $0 stop
    $0 start
    ;;

  *)
    echo `date` " STORJ : Request UNKNOWN ($@) " >> $LOGFILE
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac

wget https://github.com/storj/storj/releases/download/v1.22.2/storagenode_linux_amd64.zip
wget https://github.com/storj/storj/releases/download/v1.22.2/storagenode_linux_amd64.zip
unzip storagenode_linux_amd64.zip
unzip storagenode-updater_linux_amd64.zip
chmod +x storagenode
chmod +x storagenode-updater
mkdir -p /opt/storagenode/bin
mv storagenode storagenode-updater /opt/storagenode/bin
exit 0
