# open_jtalk_server

## Preparation
run
```
./prepare_assets.sh
```

After it finishes, confirm it worked this way:
```
echo "おはようございます" | opt/bin/open_jtalk -x assets/open_jtalk_dic_utf_8-1.11 -m assets/hts_voice_nitech_jp_atr503_m001-1.05/nitech_jp_atr503_m001.htsvoice -ow a.wav

play a.wav

echo "おはようございます" | opt/bin/open_jtalk -x assets/open_jtalk_dic_utf_8-1.11 -m assets/MMDAgent_Example-1.8/Voice/mei/mei_normal.htsvoice -ow b.wav

play b.wav 
```
