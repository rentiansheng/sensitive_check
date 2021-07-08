#!/bin/bash
#set -e

base_dir=__BASE_DIR__
check_license=__CHECK_LICENSE__
timestamp=$(date +"%T")

cd ${base_dir}
change_files=$(git diff --cached --name-only)

fileNo=$(git diff --cached --name-only|wc -l)
if [ -z "$fileNo" ] || [ "0" -eq "$fileNo" ] ;then
    echo "not change file"
    exit 0
fi

echo "scan the source count:"$fileNo

lastErrFileName=""
tmp_white_name="${base_dir}/.git/hooks/module/white_name_${timestamp}_tmp"
cat "${base_dir}"/.git/hooks/module/*white_name>$tmp_white_name
echo "checking the name"
for fileName in ${change_files};do
    if [ ! -f "$fileName" ];then
        echo "delete file: $fileName"
        continue 
    fi
    check_name=$(grep -aEinor -f  "${base_dir}/.git/hooks/module/name"  $fileName)
    if [ -z "${check_name}" ];then
        continue
    fi 
    for tmp in ${check_name};do
        errLineMsg="$fileName:$tmp"
        check_white_name=$(echo "$errLineMsg"| grep -v  -f "${tmp_white_name}")
        if [ -z "${check_white_name}" ];then
            continue
        fi 
        echo "  invalid: "${errLineMsg}
        lastErrFileName=${fileName}
    done


done
if [ -f "$tmp_white_name" ];then
    rm $tmp_white_name
fi
## valid has sensitive 
if [ "" != "$lastErrFileName" ];then
    exit 1
fi
echo "  OK"

lastErrFileName=""
tmp_white_ips="${base_dir}/.git/hooks/module/white_ips_${timestamp}_tmp"
cat "${base_dir}"/.git/hooks/module/*white_ips>$tmp_white_ips
ipRegex="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
echo "checking the ip"
for fileName in ${change_files};do
    if [ ! -f "$fileName" ];then
        echo "delete file: $fileName"
        continue 
    fi
    check_ip=$(grep "$ipRegex" -REnoa  $fileName )
    if [ -z "${check_ip}" ];then
        continue
    fi 
    for tmp in ${check_ip};do
        errLineMsg="$fileName:$tmp"
        check_white_ip=$(echo "$errLineMsg"| grep -v -f "${tmp_white_ips}")
        if [ -z "${check_white_ip}" ];then
            continue
        fi 
        echo "  invalid: "${errLineMsg}
        lastErrFileName=${fileName}
    done
    
done 
if [ -f "${tmp_white_ips}" ];then
    rm $tmp_white_ips
fi
## valid has sensitive 
if [ "" != "$lastErrFileName" ];then
    exit 1
fi
echo "  OK"

if [ "true" = "$check_license" ];then
   sh ${base_dir}/.git/hooks/module/check_license.sh $base_dir
fi

