#!/bin/bash
source $CONFIG
TG_CHAT_ID=-1001983306115
telegram_message() {
        curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d parse_mode="HTML" \
        -d text="$1"
}

echo -e \
"
🛠️ ShazuxD CI

The Build has been Triggered!

Device: "${DEVICE}"
Logs: <a href=\"https://cirrus-ci.com/build/${CIRRUS_BUILD_ID}\">Here</a>
" > tg.html

p=$(< tg.html)
telegram_message "$p"
echo " "

# Source Vars
mkdir /tmp/ci
cd /tmp/ci
ls
repo init $TWRP_MANIFEST -b $TWRP_BRANCH --depth=1
repo sync || { echo "ERROR: Failed to Sync TWRP Sources!" && exit 1; }
ls

# Clone Trees
git clone $DT_LINK -b $DT_BRANCH $DEVICE_PATH || { echo "ERROR: Failed to Clone the Device Trees!" && exit 1; }

# Exit
exit 0
