#!/bin/sh
base_dir=$1
change_files=$(git diff --cached --name-only)
timestamp=$(date +"%T")

echo "checking the license"

tmp_white_license="${base_dir}/.git/hooks/module/white_license_${timestamp}_tmp"
cat "${base_dir}"/.git/hooks/module/*white_license>$tmp_white_license
lastErrFileName=""
for fileName in ${change_files};do
    if [ -f "$fileName" ];then
        ignore_check=$(echo ${fileName}|grep -v -f "${tmp_white_license}"|grep -aEino  '(.go|.php|.java)$')
        if [ "" = "${ignore_check}" ];then
            continue 
        fi
        check_license=$(grep -aEinor -f  "${base_dir}/.git/hooks/module/license"  ${fileName})
        if [ -z "${check_license}" ];then
            echo "  invalid: not license, file name:"${fileName}
            lastErrFileName=$fileName
        fi
    fi
   
done
if [ -f "$tmp_white_license" ];then
    rm $tmp_white_license
fi

if [ "" != "$lastErrFileName" ];then
    exit 1
fi

echo "  OK"