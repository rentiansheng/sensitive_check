# 描述
目是提供基于git项目仓库敏感信息，commit 信息格式检查，文件license 检查。 

# 功能

- 提供敏感信息校验

校验提交代码是否包含敏感信息，包含企业账户名称，域名

- 提供commit 消息格式校验

commit 消息必须为
```
type:message issue #1 #2
```

详情可以看[commit格式文章](http://www.ireage.com/git/2018/12/07/git_commit_format.html)


# 安装方式

``` sh 

    # path 必填,  git clone 对应仓库的地址
    sh install.sh   path 

    eg: git clone  https://github.com/rentiansheng/sensitive_check /tmp/sensitive_check  
    sh install  /tmp/sensitive_check


```

# 参数

### path 必须项目

```
   install.sh 第一个参数必须是项目目录的地址
```

### ignore_license 可选参数

```
ignore_license  不检查文件中是否带有license。默认是检查必java,php,go结尾文件，是否带有证书，没有license不允许提交 eg: sh install.sh /tmp/aa ignore_license


需要检查license 的时候，需要修改项目中的module/license 或者是git clone 项目中的.git/hooks/module/license 文件内容。
现在只检查.go,.php, .java 结尾的文件，如果需要检查其他类型的文件。 需要修改项目中的module/check_license.sh 或者是git clone 项目中的.git/hooks/module/check_license.sh 文件13行

```




# 用户白名单

## 加入白名单后，白名单中其他位置出现非法内容，也有可能被忽略请注意

### 域名或者企业用户名的白名单配置
 
 ```
 在.git/hooks/module 中新加一个以white_name结尾的文件。eg:reage_white_name
 
 文件的第一行必须为换行
 
```

### ip地址的白名单


```
 在.git/hooks/module 中新加一个以white_ips结尾的文件。eg:reage_white_ips
 
 文件的第一行必须为换行
```

### license地址的白名单


```
 在.git/hooks/module 中新加一个以white_license结尾的文件。eg:reage_white_license
 
 文件的第一行必须为换行
```



