#! /bin/sh
today=$(date +"%Y%m%d , %H:%M")
getyesdate="$(date -d "1 day ago" +'%Y%m%d')"
lastmon="$(date -d "1 day ago" +'%b')"
last30min="$(date -d "1 month ago" +'%b')"
lastyear="$(date -d "l day ago" +'%Y')"

yesfile72="/var/log/php7.2-fpm.log.$getyesdate.gz"
yesfile73="/var/log/php7.3-fpm.log.$getyesdate.gz"

movefuction72="mv /var/log/php7.2-fpm.log.$getyesdate.gz /var/log/COLphp/"
movefuction73="mv /var/log/php7.3-fpm.log.$getyesdate.gz /var/log/COLphp/"

file72="/var/log/COLphp/php7.2-fpm.log.$getyesdate.gz"
file73="/var/log/COLphp/php7.3-fpm.log.$getyesdate.gz"

upfuction72="aws s3 cp /var/log/COLphp/php7.2-fpm.log.$getyesdate.gz s3://mofa-instance-log/Dev-NSPP/Phplog/$lastyear/$lastmon/ --region ap-northeast-1 "
upfuction73="aws s3 cp /var/log/COLphp/php7.3-fpm.log.$getyesdate.gz s3://mofa-instance-log/Dev-NSPP/Phplog/$lastyear/$lastmon/ --region ap-northeast-1 "

uploadfile="/home/ubuntu/uploadtoS3/log.txt"

php2logEY="phplog 7.2 file is exists"
php2logEN="phplog 7.2 file is not exists"
php2logCY="phplog 7.2 file is copy done"
php2logCN="phplog 7.2 file is copy fails"
php2logUY="phplog 7.2 file is upload done"
php2logUN="phplog 7.2 file is upload fails"

php3logEY="phplog 7.3 file is exists"
php3logEN="phplog 7.3 file is not exists"
php3logCY="phplog 7.3 file is copy done"
php3logCN="phplog 7.3 file is copy fails"
php3logUY="phplog 7.3 file is upload done"
php3logUN="phplog 7.3 file is upload fails"

if [ -f "$yesfile72" ];then
        feedback1=${php2logEY}
else
        feedback1=${php2logEN}
fi

if [ -f "$yesfile73" ];then
        feedback11=${php3logEY}
else
        feedback11=${php3logEN}
fi

if [ -f "$yesfile72" ];then
        $movefuction72
        feedback2=${php2logCY}
else
        feedback2=${php2logCN}
fi

if [ -f "$yesfile73" ];then
        $movefuction73
        feedback22=${php3logCY}
else
        feedback22=${php3logCN}
fi

if [ -f "$file72" ];then
        $upfuction72
        feedback3=${php2logUY}
else
        feedback3=${php2logUN}
fi

if [ -f "$file73" ];then
        $upfuction73
        feedback33=${php3logUY}
else
        feedback33=${php3logUN}
fi

echo "$today" >> $uploadfile
echo "$feedback1" >> $uploadfile
echo "$feedback11" >> $uploadfile

echo "$feedback2" >> $uploadfile
echo "$feedback22" >> $uploadfile

echo "$feedback3" >> $uploadfile
echo "$feedback33" >> $uploadfile