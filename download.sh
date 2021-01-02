#!/bin/sh -e
mkdir -p original
CHANNEL_URL="https://www.youtube.com/channel/UClSsb_e0HDQ-w7XuwNPgGqQ/videos"
youtube-dl -o "original/%(upload_date)s-%(id)s.%(ext)s" $CHANNEL_URL --write-info-json -f 'bestvideo,bestaudio'
