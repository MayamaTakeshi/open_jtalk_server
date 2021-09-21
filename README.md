# open_jtalk_server

## Overview

This is an HTTP server written in nodejs permitting access to TTS service provided by open_jtalk.
HTTP response will be a wav file.

## Preparation of open_jtalk and related artifacts
Run:

```
./prepare_assets.sh
```

After it finishes, confirm open_jtalk is working by doing:
```
echo "おはようございます" | opt/bin/open_jtalk -x assets/open_jtalk_dic_utf_8-1.11 -m assets/hts_voice_nitech_jp_atr503_m001-1.05/nitech_jp_atr503_m001.htsvoice -ow a.wav

play a.wav

echo "おはようございます" | opt/bin/open_jtalk -x assets/open_jtalk_dic_utf_8-1.11 -m assets/MMDAgent_Example-1.8/Voice/mei/mei_normal.htsvoice -ow b.wav

play b.wav 
```

## Preparation of nodejs app

Install nodejs (see version in package.json)

Then install node packages
```
cd nodejs
npm install
```

## Prepare config file
```
cp config/default.js.sample config/default.js
vim config/default.js # adjust if necessary
```
The WORKING_FOLDER mentioned in the config file must exist (create it if necessary)


## Starting the server
```
node index.js
```

## Testing:
Open this in chrome browser (it will not work in firefox as it doesn't support playing wav files).
```
http://localhost:5000/text_to_speech?voice=mei_normal&text=おはようございます
```

## Available voices
  - m001
  - mei_normal
  - mei_happy
  - mei_sad
  - mei_bashful
  - mei_angry

