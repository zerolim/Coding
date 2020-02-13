#! /bin/sh

lastmon="$(date -d "1 month ago" +'%Y%m%d')"

dsyslog="/var/log/COLsyslog/syslog.$lastmon.gz"
daccess="/var/log/apache2/COLaccess/access.log.$lastmon.gz"
derror="/var/log/apache2/COLerror/error.log.$lastmon.gz"
dusf="/var/log/COLvsftpd/vsftpd.log.$lastmon.gz"
dphp72="/var/log/COLphp/php7.2-fpm.log.$lastmon.gz"
dphp73="/var/log/COLphp/php7.3-fpm.log.$lastmon.gz"

rsyslog="rm /var/log/COLsyslog/syslog.$lastmon.gz"
raccess="rm /var/log/apache2/COLaccess/access.log.$lastmon.gz"
rerror="rm /var/log/apache2/COLerror/error.log.$lastmon.gz"
rusf="rm /var/log/COLvsftpd/vsftpd.log.$lastmon.gz"
rphp72="rm /var/log/COLphp/php7.2-fpm.log.$lastmon.gz"
rphp73="rm /var/log/COLphp/php7.3-fpm.log.$lastmon.gz"

echo "syslog.$lastmon.gz"
echo "access.log.$lastmon.gz"
echo "error.log.$lastmon.gz"
echo "vsftpd.log.$lastmon.gz"
echo "php7.2-fpm.log.$lastmon.gz"
echo "php7.3-fpm.log.$lastmon.gz"

if [ -f "$dsyslog" ];then
        $rsyslog
        echo "delete rsyslog"
else
        echo "fails delete rsyslog"
fi

if [ -f "$daccess" ];then
        $raccess
        echo "delete raccess"
else
        echo "fails delete raccess"
fi

if [ -f "$derror" ];then
        $rerror
        echo "delete rerror"
else
        echo "fails delete rerror"
fi

if [ -f "$dusf" ];then
        $rusf
        echo "delete rusf"
else
        echo "fails delete rusf"
fi

if [ -f "$dphp72" ];then
        $rphp72
        echo "delete rphp72"
else
        echo "fails delete rphp72"
fi

if [ -f "$dphp73" ];then
        $rphp73
        echo "delete rphp73"
else
        echo "fails delete rphp73"
fi
