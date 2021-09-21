#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail


if [[ $# != 3 ]]
then
	cat >&2 <<EOF
Arguments: $0 "text" voice_file file_path
Ex:	       $0 "おはようございます" ../assets/MMDAgent_Example-1.8/Voice/mei/mei_normal.htsvoice work/some_file_name.wav
EOF
	exit 1
fi


text=$1
voice_file=$2
file_path=$3


echo "$text" | ../assets/open_jtalk-1.11/bin/open_jtalk -x ../assets/open_jtalk_dic_utf_8-1.11 -m $voice_file -ow $file_path
cat $file_path
rm -f $file_path > /dev/null
