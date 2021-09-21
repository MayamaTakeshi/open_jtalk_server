#!/bin/bash

set -o errexit
set -o nounset


START_DIR=`pwd`


HTS_ENGINE_API_VERSION=1.10
OPEN_JTALK_VERSION=1.11
OPEN_JTALK_DIC_UTF_8_VERSION=1.11
HTS_VOICE_NITECH_JP_ATR503_M001_VERSION=1.05
MMDAGENT_EXAMPLE_VERSION=1.8


cd ${START_DIR}/assets
rm -fr hts_engine_API-${HTS_ENGINE_API_VERSION}
tar xf hts_engine_API-${HTS_ENGINE_API_VERSION}.tar.gz
cd hts_engine_API-${HTS_ENGINE_API_VERSION}
./configure --prefix=${START_DIR}/opt
make
make install


cd ${START_DIR}/assets
rm -fr open_jtalk-${OPEN_JTALK_VERSION}
tar xf open_jtalk-${OPEN_JTALK_VERSION}.tar.gz
cd open_jtalk-${OPEN_JTALK_VERSION}
./configure --prefix=${START_DIR}/opt --with-hts-engine-header-path=${START_DIR}/assets/hts_engine_API-${HTS_ENGINE_API_VERSION}/include --with-hts-engine-library-path=${START_DIR}/assets/hts_engine_API-${HTS_ENGINE_API_VERSION}/lib --with-charset=UTF-8
sed -i -r "s|^CFLAGS.*=.*|& -I ${START_DIR}/opt/include|" Makefile
sed -i -r "s|^CFLAGS.*=.*|& -I ${START_DIR}/opt/include|" bin/Makefile
sed -i -r "s|^LDFLAGS.*=.*|& -L ${START_DIR}/opt/lib|" Makefile
sed -i -r "s|^LDFLAGS.*=.*|& -L ${START_DIR}/opt/lib|" bin/Makefile
make install


cd ${START_DIR}/assets
rm -fr open_jtalk_dic_utf_8-${OPEN_JTALK_DIC_UTF_8_VERSION}
tar xf open_jtalk_dic_utf_8-${OPEN_JTALK_DIC_UTF_8_VERSION}.tar.gz


cd ${START_DIR}/assets
rm -fr hts_voice_nitech_jp_atr503_m001-${HTS_VOICE_NITECH_JP_ATR503_M001_VERSION}
tar xf hts_voice_nitech_jp_atr503_m001-${HTS_VOICE_NITECH_JP_ATR503_M001_VERSION}.tar.gz 


cd ${START_DIR}/assets
rm -fr MMDAgent_Example-${MMDAGENT_EXAMPLE_VERSION}
unzip MMDAgent_Example-${MMDAGENT_EXAMPLE_VERSION}.zip


echo Success

