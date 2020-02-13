#! /bin/sh

today=$(date +"%Y%m%d , %H:%M")
getyesdate="$(date -d "1 day ago" +'%Y%m%d')"
lastmon="$(date -d "1 day ago" +'%b')"
last30min="$(date -d "1 month ago" +'%b')"

lastyear="$(date -d "l day ago" +'%Y')"

yesfile72="/var/log/apache2/access.log.$getyesdate.gz"
yesfile73="/var/log/apache2/error.log.$getyesdate.gz"

file72="/var/log/apache2/COLaccess/access.log.$getyesdate.gz"
file73="/var/log/apache2/COLerror/error.log.$getyesdate.gz"

upfuction72="aws s3 cp /var/log/apache2/COLaccess/access.log.$getyesdate.gz s3://mofa-instance-log/Dev-NSPP/ApacheLog/$lastyear/$lastmon/ --region ap-northeast-1"
upfuction73="aws s3 cp /var/log/apache2/COLerror/error.log.$getyesdate.gz s3://mofa-instance-log/Dev-NSPP/ApacheLog/$lastyear/$lastmon/ --region ap-northeast-1"

movefuction72="mv /var/log/apache2/access.log.$getyesdate.gz  /var/log/apache2/COLaccess/"
movefuction73="mv /var/log/apache2/error.log.$getyesdate.gz  /var/log/apache2/COLerror/"

detectfile="/var/log/apache2/access.log.$getyesdate.gz"
detectfile="/var/log/apache2/error.log.$getyesdate.gz"

uploadfile="/home/ubuntu/uploadtoS3/log.txt"

apachealogEY="apache access file is exists"
apachealogEN="apache access is not exists"
apachealogCY="apache access is copy done"
apachealogCN="apache access is copy fails"
apachealogUY="apache access is upload done"
apachealogUN="apache access is upload fails"

apacheelogEY="apache error file is exists"
apacheelogEN="apache error is not exists"
apacheelogCY="apache error is copy done"
apacheelogCN="apache error is copy fails"
apacheelogUY="apache error is upload done"
apacheelogUN="apache error is upload fails"

if [ -f "$yesfile72" ];then
        feedback1=${apachealogEY}
else
        feedback1=${apachealogEN}
fi

if [ -f "$yesfile73" ];then
        feedback11=${apacheelogEY}
else
        feedback11=${apacheelogEN}
fi

if [ -f "$yesfile72" ];then
        $movefuction72
        feedback2=${apachealogCY}
else
        feedback2=${apachealogCN}
fi

if [ -f "$yesfile73" ];then
        $movefuction73
        feedback22=${apacheelogCY}
else
        feedback22=${apacheelogCN}
fi

if [ -f "$file72" ];then
        $upfuction72
        feedback3=${apachealogUY}
else
        feedback3=${apachealogUN}
fi

if [ -f "$file73" ];then
        $upfuction73
        feedback33=${apacheelogUY}
else
        feedback33=${apacheelogUN}
fi 


echo "$today" >> $uploadfile
echo "$feedback1" >> $uploadfile
echo "$feedback1" >> $uploadfile
echo "$feedback2" >> $uploadfile
echo "$feedback2" >> $uploadfile
echo "$feedback3" >> $uploadfile
echo "$feedback3" >> $uploadfile