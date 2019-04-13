#!/bin/bash
#set -e

msg_file=$1

base_dir=__BASE_DIR__
cd ${base_dir}


echo "checking the commit message type "
check_msg_type=$(grep -aEinor  "^(merge)"  $msg_file )
if [ -n "${check_msg_type}" ];then
   echo "checking the commit message type: OK"
   exit 0
fi

check_msg_type=$(grep -aEinor -f  "${base_dir}/.git/hooks/module/commit_type"  $msg_file )
if [ -z "${check_msg_type}" ];then
    echo "  invalid: miss type. "$(cat $msg_file)
    echo "  example: type:messsge issueFlag #id1 #id2"
    echo "  type range: feature|fix|docs|style|refactor|test|chore|depend|lib|define"
    echo "  detail:  http://www.ireage.com/git/2018/12/07/git_commit_format.html"
    exit 1
else 
   echo "  OK"
fi


issueFlag="(issue|close|closes|closed|fix|fixes|fixed|resolve|resolves|resolved)"

echo "checking the commit message issue  "
check_msg_type=$(grep -aEinor   " ${issueFlag}(([ ]+#[0-9]+)+)$"  $msg_file )
if [ -z "${check_msg_type}" ];then
    echo "  invalid: miss issue flag. "$(cat $msg_file)
    echo "  example: type:messsge issueFlag #id1 #id2"
    echo "  issueFlag: "$issueFlag
    echo "  detail:  http://www.ireage.com/git/2018/12/07/git_commit_format.html"
    exit 1 
else 
   echo "  OK"
fi
