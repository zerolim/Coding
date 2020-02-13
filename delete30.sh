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

syslog="syslog.$lastmon.gz"
access="access.log.$lastmon.gz"
error="error.log.$lastmon.gz"
vsftpd="vsftpd.log.$lastmon.gz"
php2="php7.2-fpm.log.$lastmon.gz"
php3="php7.3-fpm.log.$lastmon.gz"

sysloge="error = syslog.$lastmon.gz"
accesse="error = access.log.$lastmon.gz"
errore="error = error.log.$lastmon.gz"
vsftpde="error = vsftpd.log.$lastmon.gz"
php2e="error = php7.2-fpm.log.$lastmon.gz"
php3e="error = php7.3-fpm.log.$lastmon.gz"


uploadfile="/home/ubuntu/uploadtoS3/log.txt"
#feedback2=${apachealogCY}

if [ -f "$dsyslog" ];then
        $rsyslog
        feedback1=${syslog}
else
        feedback1=${sysloge}
fi

if [ -f "$daccess" ];then
        $raccess
        feedback2=${access}
else
        feedback2=${accesse}
fi

if [ -f "$derror" ];then
        $rerror
        feedback3=${error}
else
        feedback3=${errore}
fi

if [ -f "$dusf" ];then
        $rusf
        feedback4=${vsftpd}
else
        feedback4=${vsftpde}
fi

if [ -f "$dphp72" ];then
        $rphp72
        feedback5=${php2}
else
        feedback5=${php2e}
fi

if [ -f "$dphp73" ];then
        $rphp73
        feedback6=${php3}
else
        feedback6=${php3e}
fi


echo "$today" >> $uploadfile
echo "$feedback1" >> $uploadfile
echo "$feedback2" >> $uploadfile
echo "$feedback3" >> $uploadfile
echo "$feedback4" >> $uploadfile
echo "$feedback5" >> $uploadfile
echo "$feedback6" >> $uploadfile
