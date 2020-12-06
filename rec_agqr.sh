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

CONNECT_URL="https://www.uniqueradio.jp/agplayer5/hls/mbr-ff.m3u8"
TIME=${1}
currenttime=`date +%Y%m%d-%H%M%S`
FILENAME=${2}/${currenttime}
TEMPFILE=${2}/recFile.mp4

ffmpeg -i ${CONNECT_URL} -movflags faststart -t ${TIME} -c copy ${TEMPFILE} -loglevel fatal
ffmpeg -i ${TEMPFILE} -acodec libmp3lame -ab 256k ${FILENAME}.mp3 -loglevel fatal
if [ $? = 0 ]; then
	rm -f ${TEMPFILE}
fi
