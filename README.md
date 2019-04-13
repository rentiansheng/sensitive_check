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

白名单只要设置需要忽略文件一部分或者全部路径即可。

**主机只要包含配置白名单中的一项。即将被忽略掉, 设置忽略 aa, 只要文件路径或文件名中包含aa就会被忽略**



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





# 使用示例

#### 安装

``` sh


➜  sensitive_check git:(master) ✗ sh ./install.sh /tmp/sensitive_check    

upgrade template start
Already up to date.
upgrade template end

set git project directoy path: /tmp/sensitive_check

```

### 出现企业用户名或者内部域名



##### 配置企业用户名和域名敏感信息

``` sh
➜  sensitive_check git:(master) ✗ cat .git/hooks/module/name
ireage\.com|rentiansheng

``` 

##### 出现敏感信息提示

``` sh

➜  sensitive_check git:(master) ✗ git commit -m "test" -a
scan the source count:1
checking the name
  invalid:test.go:7:ireage.com
  invalid:test.go:8:rentiansheng

```

##### 出现公司IP 提示

``` sh
➜  sensitive_check git:(master) ✗ git commit -m "test" -a
scan the source count:1
checking the name
  OK
checking the ip
  invalid:test.go:8:127.0.0.2

```

##### commit 消息格式错误提示

```

➜  sensitive_check git:(master) ✗ git commit -m "test" -a
scan the source count:1
cat: '/tmp/sensitive_check/.git/hooks/module/*white_name': No such file or directory
checking the name
  OK
checking the ip
  OK
checking the license
  invalid: not license, file name:test.go


➜  sensitive_check git:(master) ✗ git commit -m "fix:test" -a 
scan the source count:1
checking the name
  OK
checking the ip
  OK
checking the license
  invalid: not license, file name:test.go

```

##### 没有 license 提示

``` sh
➜  sensitive_check git:(master) ✗ git commit -m "fix:test issue #1" -a
scan the source count:1
checking the name
  OK
checking the ip
  OK
checking the license
  invalid: not license, file name:test.go



```

