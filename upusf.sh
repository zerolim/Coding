#! /bin/sh

today=$(date +"%Y%m%d , %H:%M")
getyesdate="$(date -d "1 day ago" +'%Y%m%d')"
lastmon="$(date -d "1 day ago" +'%b')"
last30min="$(date -d "1 month ago" +'%b')"

lastyear="$(date -d "l day ago" +'%Y')"

yesfile72="/var/log/vsftpd.log.$getyesdate.gz"
#yesfile73="/var/log/php7.3-fpm.log.$getyesdate.gz"

file72="/var/log/COLvsftpd/vsftpd.log.$getyesdate.gz"
#file73="/var/log/COLphp/php7.3-fpm.log.$getyesdate.gz"

upfuction72="aws s3 cp /var/log/COLvsftpd/vsftpd.log.$getyesdate.gz s3://mofa-instance-log/Dev-NSPP/VSFTPLog/$lastyear/$lastmon/  --region ap-northeast-1"
#upfuction73="aws s3 cp /var/log/COLphp.php7.3-fpm.log.$getyesdate.gz s3:/mofa-instance-log/Dev-NSPP/$lastyear/$lastmon/"

movefuction72="mv /var/log/vsftpd.log.$getyesdate.gz  /var/log/COLvsftpd/"
#movefuction73="mv /var/log/php7.3-fpm.log.$getyesdate.gz  /var/log/COLphp/"

detectfile="/var/log/COLphp/vsftpd.log.$getyesdate.gz"
#detectfile="/var/log/COLphp/php7.3-fpm.log.$getyesdate.gz"
uploadfile="/home/ubuntu/uploadtoS3/log.txt"

vsflogEY="vsf file is exists"
vsflogEN="vsf file is not exists"
vsflogCY="vsf file is copy done"
vsflogCN="vsf file is copy fails"
vsflogUY="vsf file is upload done"
vsflogUN="vsf file is upload fails"

if [ -f "$yesfile72" ];then
        feedback1=${vsflogEY}
else
        feedback1=${vsflogEN}
fi

if [ -f "$yesfile72" ];then
        feedback2=${vsflogCY}
else
        feedback2=${vsflogCN}
fi

if [ -f "$file72" ];then
        $upfuction72
        feedback3=${vsflogUY}
else
        feedback3=${vsflogUN}
fi

echo "$today" >> $uploadfile
echo "$feedback1" >> $uploadfile
echo "$feedback2" >> $uploadfile
echo "$feedback3" >> $uploadfile
