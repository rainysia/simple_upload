simple_upload
=============

It's a php file ,you can use it upload file or download file from your web-server/uploads.it's very simple.


Usage
----------------------------------------

There is including DB file, file list, file manager, shell scripts

Support big file need to change your nginx/apache, and php upload file part configuration.
```
nginx
    keepalive_timeout 600;
    client_max_body_size 2000m;
    fastcgi_connect_timeout 3000;
    fastcgi_send_timeout 3000;
apache
    Timeout 3000
php
    post_max_size = 2048M
    file_uploads = On
    upload_max_filesize = 2048M
```



###uploads.php or uploads_new.php
```
http://ip or domain/uploads.php
```
![uploads.php](https://cloud.githubusercontent.com/assets/1259324/13483267/ea6aa5f0-e12d-11e5-8096-2d17480d405d.png)


```
http://ip or domain/uploads.php?user=superadmin
```
![uploads.php can delete](https://cloud.githubusercontent.com/assets/1259324/13483279/03fe57fa-e12e-11e5-877e-0af62cb7cc5a.png)


###adminer.php

```
http://ip or domain/adminer.php
```
![adminer.php](https://cloud.githubusercontent.com/assets/1259324/13483259/e19efb10-e12d-11e5-9907-ad58c2ed7514.png)


###file.php
```
http://ip or domain/file.php
```
![file.php](https://cloud.githubusercontent.com/assets/1259324/13483264/e67c7a40-e12d-11e5-976b-9552946f7d12.png)

###punctuation_cn_to_en.sh
It will translate all chinese punctuation to english punctuation, run 
```
./punctuation_cn_to_en.sh path[absolute path or relative path or filename]
```
[**Chinese punctuation in Wikipedia**](https://zh.wikipedia.org/wiki/%E6%A0%87%E7%82%B9%E7%AC%A6%E5%8F%B7 "Wikipedia")
![punc](https://cloud.githubusercontent.com/assets/1259324/15665993/dc4cc724-2740-11e6-9043-8e7ad7fb7879.png)

###sync_git.sh
This script can sync all the folder git project.
```
./sync_git.sh path[absolute path or relative path or filename]
```
![sync_git](https://cloud.githubusercontent.com/assets/1259324/20429429/884ffb18-adc9-11e6-8af7-8cbcd6509aa7.png)


Contact
----------------------------------------
<rainysia@gmail.com>


Requirements
----------------------------------------

    php > 5.2, nginx or apache


Update
----------------------------------------
2015-05-12 14:59:04 add basic READ.md<br />
2015-06-01 10:50:58 add file.php<br />
2016-03-03 10:47:38 modify uploads.php<br />
