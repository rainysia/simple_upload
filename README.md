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


### uploads.php or uploads_new.php
--------
It will help you to support simple file manager(ftp) in your web server with only one php file.
```
http://ip or domain/uploads.php  (old version)
http://ip or domain/uploads_new.php  // (new version, recommend this one)
```

![uploads.php](https://cloud.githubusercontent.com/assets/1259324/13483267/ea6aa5f0-e12d-11e5-8096-2d17480d405d.png)

```
http://ip or domain/uploads.php?user=superadmin
```

![uploads.php can delete](https://cloud.githubusercontent.com/assets/1259324/13483279/03fe57fa-e12e-11e5-877e-0af62cb7cc5a.png)

```
Add the font mark when upload an image.
http://ip or domain/uploads.php?user=superadmin&mark_type=1&mark=@helloworld&size=18&position=1&color=255,255,255&show=0&date=1
```
![uploads.php with image fontmark](https://user-images.githubusercontent.com/1259324/93190145-94ecc280-f775-11ea-878b-63c576592f2a.jpeg)
```
Support image mark when upload an image.
http://ip or domain/uploads.php?user=superadmin&mark_type=2&zoom=4
```


### adminer.php
-----------
Simple DB manager file with one php file.
```
http://ip or domain/adminer.php
```
![adminer.php](https://cloud.githubusercontent.com/assets/1259324/13483259/e19efb10-e12d-11e5-9907-ad58c2ed7514.png)


### file.php
---------
Simple file manager with one php file.
```
http://ip or domain/file.php
```
![file.php](https://cloud.githubusercontent.com/assets/1259324/13483264/e67c7a40-e12d-11e5-976b-9552946f7d12.png)

### punctuation_cn_to_en.sh
---------
It will translate all chinese punctuation to english punctuation, run
```
./punctuation_cn_to_en.sh path[absolute path or relative path or filename]
```
[**Chinese punctuation in Wikipedia**](https://zh.wikipedia.org/wiki/%E6%A0%87%E7%82%B9%E7%AC%A6%E5%8F%B7 "Wikipedia") <br />
![punc](https://cloud.githubusercontent.com/assets/1259324/15665993/dc4cc724-2740-11e6-9043-8e7ad7fb7879.png)

### sync_git.sh
--------
This script can sync all the folder git project.
```
./sync_git.sh path[absolute path or relative path or filename]
```
![sync_git](https://cloud.githubusercontent.com/assets/1259324/20429429/884ffb18-adc9-11e6-8af7-8cbcd6509aa7.png)

### php_laravel_shell.php
---------
This php script can run laravel command via http
```
put it into you web-server and run it/php_laravel_shell.php
```

### Remove merged branch
------------
This script will delete upstream or origin remote repository branch
**Need to set keep_keywords, default_branch, protect_branches_arr**
```
./xxx/git_branch_clean.sh /xxx/project_folder/ remote_name
./xxx/git_branch_clean.sh /xxx/project_folder/ upstream
```
![git_branch_clean](https://user-images.githubusercontent.com/1259324/54344563-1abd1880-467c-11e9-82f6-059d890d8d10.png)

### Count DB's table's column is out-of-design or not.
--------------
This script will query schema table to calculate the column defined and do mathematics, can set the tolerance in line 412.
0.8 means reach/over the design capacity 80%.
**Need to set $DBsetting and $checkDBName**
```
http://ip or domain/countDBColumn.php
```
![countDBColumn](https://user-images.githubusercontent.com/1259324/58074758-984f5880-7bd8-11e9-9f0f-49156972d834.png)

### Backup debian system configuration
------------
This script will backup system coonfiguration
Need to set host_dir, path_user
```
/bin/bash ./xxx/bak_debian.sh
```
![bak_debian.sh](https://user-images.githubusercontent.com/1259324/61096730-31894580-a48b-11e9-80cc-e1d4165734de.png)

### Re-new XMind Zen for debian
------------
This script will help to change XMind Zen register timestamp
Need to set user_who
```
/bin/bash ./xxx/xmind_re_lease.sh
```
![xmind_re_lease.sh](https://user-images.githubusercontent.com/1259324/66371866-25a01780-e9d7-11e9-9bc1-45e9f1149e02.png)

### Sync git projects
----------
This script will help to sync all projects under the folder
```
/bin/bash ./xxx/sync_git_projects.sh projects_foler origin
```
![sync_git_projects.sh](https://user-images.githubusercontent.com/1259324/70901054-ff30d500-2034-11ea-8209-03a2de40fefd.png)

### Update debian go/bin execute script
----------
This script will help to update golang version also the thirdparty package with their command
Need to set the golang_package, golang_path,thid_packages_path, and the packages you want to build and install
```
/bin/bash ./go_update.sh
```
![go_update.sh](https://user-images.githubusercontent.com/1259324/76006266-2e295980-5f47-11ea-9092-927c819c9553.png)

Contact
----------------------------------------
<rainysia@gmail.com>

Requirements
----------------------------------------
    php > 5.3, nginx or apache

Update
----------------------------------------
2015-05-12 14:59:04 add basic READ.md<br />
2015-06-01 10:50:58 add file.php<br />
2016-03-03 10:47:38 modify uploads.php<br />
2018-03-02 15:28:54 add uploads_new.php<br />
2018-11-12 14:00:36 add laravel web-shell.php<br />
2019-03-07 15:51:22 add git_branch_clean.sh<br />
2019-05-21 14:44:24 add countDBcolumn.php<br />
2019-07-12 09:56:17 add bak_debian.sh<br />
2019-12-16 18:49:25 add sync_git_projects.sh<br />
2020-03-06 01:07:49 add go_update.sh<br />
2020-09-14 18:48:22 support font mark<br />
2021-09-22 15:30:58 support image mark<br />
