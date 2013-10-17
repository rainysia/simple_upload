<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<meta name="author" content="xyl" />
	<title>简易文件上传</title>
</head>
<style type="text/css">
</style>
<body>
<form enctype="multipart/form-data" action="" method="post">
请选择文件： <br>
	<input name="upload_file" type="file"><br>
	<input type="submit" value="上传文件">
</form>
<br />
<br />
<br />
<br />
<?
/*
 * uploads.php
 * @name:       simeple php file upload && download tool
 * @author:     rainysia
 * @copyright:  Copyright (c) 2006 - 2013, BTROOT, Inc.
 * @version:    Version 1.0
 * @createTime: 2013-09-17 23:31:02
 * @lastChange: 2013-10-17 15:55:40
 */
function file_list($dir,$pattern=""){
	$arr=array();
	$dir_handle=opendir($dir);
	if($dir_handle){
		while(($file=readdir($dir_handle))!==false){
			if($file==='.' || $file==='..'){
				continue;
			}
			$tmp=realpath($dir.'/'.$file);
			if(is_dir($tmp)){
				$retArr=file_list($tmp,$pattern);
				if(!empty($retArr)){
					$arr[]=$retArr;
				}
			} else {
				if($pattern==="" || preg_match($pattern,$tmp)){
					$arr[]=$tmp;
				}
			}
		}
		closedir($dir_handle);
	}
	return $arr;
}
$d_root = $_SERVER['DOCUMENT_ROOT'];
$store_dir = "$d_root/uploads/";// 上传文件的储存位置
if (!is_dir($store_dir)) {
	mkdir($store_dir,0777,true);
}
$file_arr = file_list($store_dir);
foreach ($file_arr as $v=>$k) {
	$d_root_no = strlen($d_root);
	$l = substr($k,$d_root_no);
	echo $v.'号文件下载地址为:&nbsp;&nbsp;<a class="download_url" style="color:#01BCC8;text-decoration:none;font-size:16px;font-weight:bold;" href="'.$l.'">'.$_SERVER['SERVER_ADDR'].$l.'<a/><br />';
}
$upload_file=isset($_FILES['upload_file']['tmp_name'])?$_FILES['upload_file']['tmp_name']:'';
$upload_file_name=isset($_FILES['upload_file']['name'])?$_FILES['upload_file']['name']:'';
$upload_file_size=isset($_FILES['upload_file']['size'])?$_FILES['upload_file']['size']:'';
if($upload_file){
	$file_size_max = 1000*1000*200;// 200M限制文件上传最大容量(bytes)
	if (!is_dir($store_dir)) {
		mkdir($store_dir,0777,true);
	}
	$accept_overwrite = 1;//是否允许覆盖相同文件
	// 检查文件大小
	if ($upload_file_size > $file_size_max) {
		echo "对不起，你的文件容量大于规定";
		exit;
	}
	// 检查读写文件
	if (file_exists($store_dir . $upload_file_name) && !$accept_overwrite) {
		echo "存在相同文件名的文件";
		exit;
	}
	//复制文件到指定目录
	if (!move_uploaded_file($upload_file,$store_dir.$upload_file_name)) {
		echo "复制文件失败";
		exit;
	}
}
if (isset($_FILES['upload_file'])) {
	echo "<p>你上传了文件:";
	echo isset($_FILES['upload_file']['name'])?$_FILES['upload_file']['name']:'';
	echo "<br>";
	//客户端机器文件的原名称。

	echo "文件的 MIME 类型为:";
	echo isset($_FILES['upload_file']['type'])?$_FILES['upload_file']['type']:'';
	//文件的 MIME 类型，需要浏览器提供该信息的支持，例如“image/gif”。
	echo "<br>";

	echo "上传文件大小:";
	echo isset($_FILES['upload_file']['size'])?$_FILES['upload_file']['size']:'';
	//已上传文件的大小，单位为字节。
	echo "<br>";

	echo "文件上传后被临时储存为:";
	echo isset($_FILES['upload_file']['tmp_name'])?$_FILES['upload_file']['tmp_name']:'';
	//文件被上传后在服务端储存的临时文件名。
	$erroe = isset($_FILES['upload_file']['error'])?$_FILES['upload_file']['error']:'';
	switch($erroe){
	case 0:
		echo "上传成功"; break;
	case 1:
		echo "上传的文件超过了 php.ini 中 upload_max_filesize 选项限制的值."; break;
	case 2:
		echo "上传文件的大小超过了 HTML 表单中 MAX_FILE_SIZE 选项指定的值。"; break;
	case 3:
		echo "文件只有部分被上传"; break;
	case 4:
		echo "没有文件被上传"; break;
	case 6:
		echo "没有缓存目录"; break;
	case 7:
		echo "上传目录不可读"; break;
	case 8:
		echo "上传停止"; break;
	default :
		echo "没有选择上传文件"; break;
	}
	echo "<script language=JavaScript>location.replace(location.href);</script>";
}
?>
</body>
</html>
