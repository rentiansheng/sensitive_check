#!/bin/sh

base_dir=$1
check_license="true"
check_license_arg="ignore_license"

echo "set git project directoy path:" $base_dir


for arg in "$@";do 
    if [ "$arg" = "$check_license_arg" ];then 
        check_license="false"
    fi
done 


sed 's:'__BASE_DIR__':'${base_dir}':g' pre-commit.tpl |sed 's:'__CHECK_LICENSE__':'${check_license}':g' > pre-commit

sed 's:'__BASE_DIR__':'${base_dir}':g' commit-msg.tpl > commit-msg

git_hooks_dir=${base_dir}/.git/hooks/
cp pre-commit ${git_hooks_dir}
cp commit-msg  ${git_hooks_dir}
cp -r module ${git_hooks_dir}/

rm pre-commit commit-msg

cd ${git_hooks_dir} ${git_hooks_dir}
chmod -R +x pre-commit commit-msg  module