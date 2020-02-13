#! /bin/sh

today=$(date +"%Y%m%d , %H:%M")
getyesdate="$(date -d "1 day ago" +'%Y%m%d')"
lastmon="$(date -d "1 day ago" +'%b')"
last30min="$(date -d "1 month ago" +'%b')"

lastyear="$(date -d "l day ago" +'%Y')"

yesfile72="/var/log/syslog.$getyesdate.gz"

file72="/var/log/COLsyslog/syslog.$getyesdate.gz"

upfuction72="aws s3 cp /var/log/COLsyslog/syslog.$getyesdate.gz s3://mofa-instance-log/Dev-NSPP/Syslog/$lastyear/$lastmon/ --region ap-northeast-1"
movefuction72="mv /var/log/syslog.$getyesdate.gz  /var/log/COLsyslog/"
uploadfile="/home/ubuntu/uploadtoS3/log.txt"
syslogEY="Syslog file is exists"
syslogEN="Syslog file is not exists"
syslogCY="Syslog file is copy done"
syslogCN="Syslog file is copy fails"
syslogUY="Syslog file is upload done"
syslogUN="Syslong file is upload fails"

if [ -f "$yesfile72" ];then
        feedback1=${syslogEY}
else
        feedback1=${syslogEN}
fi

if [ -f "$yesfile72" ];then
        $movefuction72
        feedback2=${syslogCY}
else
        feedback2=${syslogCN}
fi

if [ -f "$file72" ];then
        $upfuction72
        feedback3=${syslogUY}
else
        feedback3=${syslogUN}
fi

echo "$today" >> $uploadfile
echo "$feedback1" >> $uploadfile
echo "$feedback2" >> $uploadfile
echo "$feedback3" >> $uploadfile
