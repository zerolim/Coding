#! /bin/sh

today=$(date +"%Y%m%d")
getyesdate="$(date -d "1 day ago" +'%Y%m%d')"
lastmon="$(date -d "1 day ago" +'%b')"
last30min="$(date -d "1 month ago" +'%b')"

lastyear="$(date -d "l day ago" +'%Y')"

yesfile72="/var/log/php7.2-fpm.log.$getyesdate.gz"
yesfile73="/var/log/php7.3-fpm.log.$getyesdate.gz"

file72="/var/log/COLphp/php7.2-fpm.log.$getyesdate.gz"
file73="/var/log/COLphp/php7.3-fpm.log.$getyesdate.gz"

upfuction72="aws s3 cp /var/log/COLphp/php7.2-fpm.log.$getyesdate.gz s3://mofa-instance-log/Dev-NSPP/Phplog/$lastyear/$lastmon/ --region ap-northeast-1"
upfuction73="aws s3 cp /var/log/COLphp/php7.3-fpm.log.$getyesdate.gz s3://mofa-instance-log/Dev-NSPP/Phplog/$lastyear/$lastmon/ --region ap-northeast-1"

movefuction72="mv /var/log/php7.2-fpm.log.$getyesdate.gz  /var/log/COLphp/"
movefuction73="mv /var/log/php7.3-fpm.log.$getyesdate.gz  /var/log/COLphp/"

detectfile="/var/log/COLphp/php7.2-fpm.log.$getyesdate.gz"
detectfile="/var/log/COLphp/php7.3-fpm.log.$getyesdate.gz"

if [ -f "$yesfile72" ];then
        $movefuction72
        echo "move php72"
else
        echo "fails move php72"
fi

if [ -f "$yesfile73" ];then
        $movefuction73
        echo "move php73"
else
        echo "fails move php73"
fi

if [ -f "$file72" ];then
        $upfuction72
        echo "finish upload php72 to s3"
else
        echo "fails upload php72 to s3"
fi

if [ -f "$file73" ];then
        $upfuction73
        echo "finish upload php73 to s3"
else
        echo "fails upload php73 to s3"
fi





if [ -f "$yesfile73" ];then
        $movefuction73
        echo "move php73"
else
        echo "fails move php73"
fi

if [ -f "$file72" ];then
        $upfuction72
        echo "finish upload php72 to s3"
else
        echo "fails upload php72 to s3"
fi

if [ -f "$file73" ];then
        $upfuction73
        echo "finish upload php73 to s3"
else
        echo "fails upload php73 to s3"
fi
