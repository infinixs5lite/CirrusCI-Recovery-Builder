#!/bin/bash
source $CONFIG
echo -e \
"
🛠️ ShazuxD CI

The Build has been Completed!
Device: "${DEVICE}"
" > upload.txt

TG_CHAT_ID=-1001983306115
telegram_message() {
        curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d parse_mode="HTML" \
        -d text="$1"
}
cd /tmp/ci/out/target/product/$DEVICE
echo "Image File:" >> upload.txt
curl --upload-file $OUTPUT https://free.keep.sh >> upload.txt
if [ $ALT_FILE = "empty" ] ;then
echo "No Alt file is set"
else
echo "Recovery Zip:" >> upload.txt
curl --upload-file $ALT_FILE https://free.keep.sh >> upload.txt
fi
wget https://github.com/Sushrut1101/GoFile-Upload/raw/master/upload.sh >> /dev/null
chmod +x upload.sh
sudo apt install jq -y >> /dev/null
./upload.sh $OUTPUT >> upload.txt
echo
if [ $ALT_FILE = "empty" ] ;then
echo "No alt file is set"
else
./upload.sh $ALT_FILE >> upload.txt
fi
cat upload.txt

p=$(< upload.txt)
telegram_message "$p"
echo " "
