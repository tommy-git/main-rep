#!/bin/sh

PATH=/usr/local/bin:$PATH

usage() {
    echo "Usage: ${command} ${time} ${download_path}"
    echo "time: seconds"
    echo "download_path: path to save file"
}

if [ $# -ne 2 ]; then
    usage
fi

CONNECT_URL=${find with your own}
TIME=${1}
currenttime=`date +%Y%m%d-%H%M%S`
FILENAME=${2}/${currenttime}

rtmpdump -r ${CONNECT_URL} --live -B ${TIME} -o ${FILENAME}.flv > /dev/null
if [ $? -ne 0  ]; then
    echo "Failed to record"
else
    ffmpeg -v quiet -y -i ${FILENAME}.flv -acodec libmp3lame -aq 2 ${FILENAME}.mp3 -ss 00:00:00.001 > /dev/null
    if [ $? -ne 0 ]; then
	echo "Failed to convert record data"
    else
	rm -f ${FILENAME}.flv
    fi
fi
