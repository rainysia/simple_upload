<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta name="author" content="xyl" />
    <title><?php echo getMultiLang('简易文件上传');?></title>
</head>
<style type="text/css">
* {margin:0;padding:0;}
body {color:#333;font-size:12px;font-family:'微软雅黑','宋体';}
a {text-decoration:none;}
a:hover {color:red;text-decoration:underline;}
.upload_file {text-decoration:none;font:bold 1em 'Trebuchet MS',Arial, Helvetica;text-align:center;color:#757575;border:0px solid #9c9c9c;
    text-shadow: 0 1px 0 rgba(0,0,0,0.4);
    box-shadow: 0 0 .05em rgba(0,0,0,0.4);
    -moz-box-shadow: 0 0 .05em rgba(0,0,0,0.4);
    -webkit-box-shadow: 0 0 .05em rgba(0,0,0,0.4);
}
.btnOrder {text-decoration:none;text-align:center;color:black;
    text-shadow: 0 1px 0 rgba(0,0,0,0);
    box-shadow: 0 0 .05em rgba(0,0,0,0.4);
    -moz-box-shadow: 0 0 .05em rgba(0,0,0,0.4);
    -webkit-box-shadow: 0 0 .05em rgba(0,0,0,0.4);
}
.button:hover .upload_file:hover {
    box-shadown:0 0 .1em rgba(0,0,0,0.4);
    -moz-box-shadow:0 0 .1em rgba(0,0,0,0.4);
    -webkit-box-shadown:0 0 .1em rgba(0,0,0,0.4);
}
#form1 {padding:10px 0 10px 20px;
    background:#DAFFEE;
    background:-moz-linear-gradient(top,#DAFFEE,#FFFFFF);
    background:-o-linear-gradient(top,#DAFFEE,#FFFFFF);
    background:-webkit-gradient(linear, 0 0, 0 bottom, from(#DAFFEE), to(#FFFFFF));
    filter:progid:DXImageTransform.Microsoft.gradient(startcolorstr=#DAFFEE,endcolorstr=#FFFFFF,gradientType=0);
    *zoom:1;
}
#form1 .choose1 {margin:0 0 0 20px;}
#form1 .file1 {margin:10px 0 5px 30px;}
#form1 .btn1 {margin:0px 0 0 30px;}
#form1 .btn1 input {padding:0 4px 0 4px;}
#typeAll {padding:10px 0px 0px 50px;}
#typeAll .hr1 {width:85%;height:5px;margin:2px 2px 2px 0;background:rgba(21, 121, 64, 0.85)!important;
	-moz-box-shadow:0px 0px 1px #c3c3c3;
	-webkit-box-shadow:0px 0px 1px #c3c3c3;
    -box-shadow:0px 0px 1px #c3c3c3;}
#typeAll a {text-decoration:none;font-weight:bold;font-size:18px;color:#000000;}
#typeAll a:hover {text-decoration:underline;color:#277C5F;font-size:18px;}
.table1tr1 {display:block;background:#909090;color:#FFFFFF;width:85%;margin-bottom:5px;
}
#table1 {margin:0px 0 0 50px;}
#table1 th {text-align:left;margin-bottom:20px;}
#table1 .th_no {text-align:center;}
#table1 th .th1 {display:block;padding-bottom:10px;text-align:left;margin-left:10px;}
#table1 th .th2 {display:block;padding-bottom:10px;text-align:left;}
#table1 .td_del a {color: #489A6B; font-weight: bold;}
#table1 .td_del a:hover {color: red; font-weight: bold;}

#table1 tr td span a {color:#3a3a3a;text-decoration:none;font-size:14px;font-weight:none;}
#table1 tr td span a:hover {color:#277C5F;text-decoration:underline;font-size:14px;font-weight:bold;}
#tbody1 .td_no {color:rgba(6, 105, 64, 0.85);text-align:center}
#tbody1 .td_content {padding-top:2px;}
</style>
<body>
<div id="form1">
<form enctype="multipart/form-data" action="" method="post" name="form1" >
        <div class="choose1"><?php echo getMultiLang('请选择文件');?>:</div>
            <input type="hidden" class="sortType" id="sortType" name="sortType" value="<?php echo $_REQUEST['sortType'] = isset($_REQUEST['sortType']) ? $_REQUEST['sortType'] : 'desc'; ?>" />
            <input type="hidden" class="sortName" id="sortName" name="sortName" value="<?php echo $_REQUEST['sortName'] = isset($_REQUEST['sortName']) ? $_REQUEST['sortName'] : ''; ?>" />
        <div class="file1"><input name="upload_file" class="upload_file" type="file"></div>
        <div class="btn1"><input type="submit" name="btnOrder" class="btnOrder" value="<?php echo getMultiLang('上传文件');?>"></div>
<!--        <iframe name="hidden_frame" id="hidden_frame"></iframe>-->
</form>
</div>
<?php
/**
 * Uploads.php
 *
 * @package    SimplePHPFile.
 * @subpackage UploadsDownload.
 * @author     tommyx <admin@btroot.com>
 * @copyright  2006-2015 SNX.Team
 * @license    http://www.btroot.com/user_guide/license.html V1
 * @createTime 2013-11-12 16:57:54
 * @lastChange 2015-06-01 10:30:14
 */

/**
 * GetFileTree.
 *
 * @param string $path 路径.
 *
 * @return array
 */
function getFileTree($path)
{
    $tree = array();
    $ctime = array();
    $merge = array();
    foreach (glob($path.'/*') as $single) {
        if (is_dir($single)) {
            $tree = array_merge($tree,getFileTree($single));
        } else {
            $tree[] = $single;
            $ctime = date('Y-m-d H:i:s', filectime($single));
            $merge[$ctime] = $single;
        }
    }
    return $tree;
}

$d_root = $_SERVER['DOCUMENT_ROOT'];
// 上传文件的储存位置
$storeDirName = 'uploads';
$store_dir = $d_root.DIRECTORY_SEPARATOR.$storeDirName.DIRECTORY_SEPARATOR;
if (!is_dir($store_dir)) {
    mkdir($store_dir, 0777, true);
}
$filePathArr = getFileTree($store_dir);

/**
 * GetFileSize.
 *
 * @param string $file 文件路径.
 *
 * @return string.
 */
function getFileSize($file)
{
    $filesize = filesize($file);
    if ($filesize >= 1073741824) {
        $filesize = round($filesize / 1073741824 * 100) / 100 . ' GB';
    } elseif ($filesize >= 1048576) {
        $filesize = round($filesize / 1048576 * 100) / 100 . ' MB';
    } elseif ($filesize >= 1024) {
        $filesize = round($filesize / 1024 * 100) / 100 . ' kB';
    } else {
        $filesize = $filesize. ' B';
    }
    return $filesize;
}

/**
 * DeleteArrayValue.
 *
 * @param array  $arr Comments.
 * @param string $var Comments.
 *
 * @return array.
 */
function arrayRemoveValue(&$arr, $var)
{
    foreach ($arr as $key => $value) {
        if (is_array($value)) {
            arrayRemoveValue($arr[$key], $var);
        } else {
            $value = trim($value);
            if ($value === $var) {
                unset($arr[$key]);
            } else {
                $arr[$key] = $value;
            }
        }
    }
}

ini_set('upload_max_filesize', '2048M');
ini_set('post_max_size', '2048M');
ini_set('max_input_time', '600');
ini_set('max_execution_time', '600');
ini_set('memory_limit', '-1');
$ctime = array();
$fileNewArr = array();
$mc = 1;
foreach ($filePathArr as $k => $v) {
    $ctime[] = filectime($v)+$mc;
    $fileNewArr[] = $v;
    $mc++;
}
$newArr = array_combine($ctime, $fileNewArr);
$admin_del_arr = array('tommyx', 'superadmin');
$del_privilege = false;
if (isset($_REQUEST['user']) && in_array($_REQUEST['user'],  $admin_del_arr)) {
    $del_privilege = true;
}
if (isset($_REQUEST['del_file']) && !empty($_REQUEST['del_file'])) {
    try {
        unlink($_REQUEST['del_file']);
        unset($_REQUEST['del_file']);
        echo '<script type="text/javascript" charset="utf-8">location.replace("'.$_SERVER['HTTP_REFERER'].'")</script>';
        exit();
    } catch ( Exception $e) {
        echo $e->getMessage();
    }
}
if (isset($_REQUEST['sortType']) && !empty($_REQUEST['sortType'])) {
    if (empty($_REQUEST['sortName'])) {
        unset($_REQUEST['sortName']);
    }
    if ($_REQUEST['sortType'] == 'asc') {
        ksort($newArr);
    } elseif ($_REQUEST['sortType'] == 'desc') {
        krsort($newArr);
    }
} elseif (isset($_REQUEST['sortName'])) {
    if (empty($_REQUEST['sortType'])) {
        unset($_REQUEST['sortType']);
    }
    if ($_REQUEST['sortName'] == 'az') {
        asort($newArr);
    } elseif ($_REQUEST['sortName'] == 'za') {
        arsort($newArr);
    }
} else {
    krsort($newArr);
}
echo '<div id="typeAll">';
    echo '<div class="type1" style="margin:0 20px 0 0px;float:left;"><a class="a1" href="#" onClick="changeSortByName();"><span>'.getMultiLang("文件名排序").'</span></a></div>';
    echo '<div class="type2" style="margin:0 20px 0 600px;"><a class="a2" href="#" onClick="changeSortType();" style=""><span>'.getMultiLang("时间排序").'</span></a></div>';
    echo '<div class="hr1"></div>';
    echo '</div>';
    echo '<p style="clear:both;"></p>';
if ($del_privilege == true) {
    echo '<div id="table1"><table><tr><th class="th_no" style="width:40px;">'.getMultiLang("序号").'</th><th class="th1">'.getMultiLang("下载链接").'</th><th class="th2">'.getMultiLang("上传时间").'</th><th class="th3">'.getMultiLang("大小").'</th><th class="th4">'.getMultiLang("删除").'</th></tr><tbody id="tbody1">';
} else {
    echo '<div id="table1"><table><tr><th class="th_no" style="width:40px;">'.getMultiLang("序号").'</th><th class="th1">'.getMultiLang("下载链接").'</th><th class="th2">'.getMultiLang("上传时间").'</th><th class="th3">'.getMultiLang("大小").'</th></tr><tbody id="tbody1">';
}
foreach ($newArr as $r => $t) {
    $d_root_no = strlen($d_root);
    $l = substr($t, $d_root_no);
    if (is_file($t) && $del_privilege == true) {
        echo '<tr><td class="td_no"></td><td class="td_content"><span style="display:block;width:570px;height:18px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;"><a class="download_url" href="'.$l.'">'.substr($l, strlen($storeDirName) + 3).'</a></span></td><td><span style="display:block;width:180px;">'.date('Y-m-d H:i:s', $r).'</span></td><td>'.getFileSize($t).'</td><td class="td_del"><a href="?del_file='.$t.'">DELETE</a></td></tr>';
    } else {
        echo '<tr><td class="td_no"></td><td class="td_content"><span style="display:block;width:570px;height:18px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;"><a class="download_url" href="'.$l.'">'.substr($l, strlen($storeDirName) + 3).'</a></span></td><td><span style="display:block;width:180px;">'.date('Y-m-d H:i:s', $r).'</span></td><td>'.getFileSize($t).'</td></tr>';
    }
}
echo '</tbody></table></div>';
$upload_file = isset($_FILES['upload_file']['tmp_name']) ? $_FILES['upload_file']['tmp_name'] : '';
$upload_file_name = isset($_FILES['upload_file']['name']) ? $_FILES['upload_file']['name'] : '';
$upload_file_size = isset($_FILES['upload_file']['size']) ? $_FILES['upload_file']['size'] : '';
if ($upload_file) {
    // 2000M限制文件上传最大容量(bytes)
    $file_size_max = 1000 * 1000 * 1000 * 2;
    if (!is_dir($store_dir)) {
        mkdir($store_dir,0777,true);
    }
    // 是否允许覆盖相同文件
    $accept_overwrite = 1;
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
    // 复制文件到指定目录
    if (!move_uploaded_file($upload_file,$store_dir.$upload_file_name)) {
        echo "复制文件失败";
        exit;
    }
}
if (isset($_FILES['upload_file']) && !empty($_FILES['upload_file']['name'])) {
    echo "<p>你上传了文件:";
    echo isset($_FILES['upload_file']['name']) ? $_FILES['upload_file']['name'] : '';
    echo "<br>";
    // 客户端机器文件的原名称。

    echo "文件的 MIME 类型为:";
    echo isset($_FILES['upload_file']['type']) ? $_FILES['upload_file']['type'] : '';
    // 文件的 MIME 类型，需要浏览器提供该信息的支持，例如“image/gif”。
    echo "<br>";

    echo "上传文件大小:";
    echo isset($_FILES['upload_file']['size']) ? $_FILES['upload_file']['size'] : '';
    // 已上传文件的大小，单位为字节。
    echo "<br>";

    echo "文件上传后被临时储存为:";
    echo isset($_FILES['upload_file']['tmp_name']) ? $_FILES['upload_file']['tmp_name'] : '';
    // 文件被上传后在服务端储存的临时文件名。
    $erroe = isset($_FILES['upload_file']['error']) ? $_FILES['upload_file']['error'] : '';
    switch($erroe){
        case 0:
            echo "上传成功";
            break;
        case 1:
            echo "上传的文件超过了 php.ini 中 upload_max_filesize 选项限制的值.";
            break;
        case 2:
            echo "上传文件的大小超过了 HTML 表单中 MAX_FILE_SIZE 选项指定的值。";
            break;
        case 3:
            echo "文件只有部分被上传";
            break;
        case 4:
            echo "没有文件被上传";
            break;
        case 6:
            echo "没有缓存目录";
            break;
        case 7:
            echo "上传目录不可读";
            break;
        case 8:
            echo "上传停止";
            break;
        default:
            echo "没有选择上传文件";
            break;
    }
    echo "<script language=JavaScript>location.replace(location.href);</script>";
}

/**
 * 多语言函数.
 *
 * @param string $key 语言内容.
 *
 * @return string.
 */
function getMultiLang($key)
{
    // 定义语言数组
    $langArr = array(
        'key' => '值',
        'SimpleFileUploadAndDownload' => '简易文件上传',
        'PleaseChooseFile' => '请选择文件',
        'Upload' => '上传文件',
        'Download' => '下载链接',
        'Upload Time' => '上传时间',
        'Size' => '大小',
        'Sort by Time' => '时间排序',
        'ASC' => '顺序',
        'DESC' => '倒序',
        'asc' => '顺序',
        'desc' => '倒序',
        'Sort by Name' => '文件名排序',
        'No' => '序号',
        'Action' => '删除'

    );
    // 中文.UTF-8, GBK \x80-\xff GB2312 \xa1-\xff
    $zhLang = preg_match("/^[\{4e00}-\x{9fa5}]+$/u", $key);
    // 英文.
    $enLang = preg_match("/^[a-zA-Z]+$/u", $key);
    // 判断浏览器语言
    $browserLang = substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, 4);
    if (preg_match("/zh-c/i", $browserLang)) {
        // echo '简体中文';
        if ($zhLang) {
            return $key;
        } else {
            if (in_array($key, $langArr)) {
                return $langArr[$key];
            } else {
                return 'NULL ZH';
            }
        }
    } elseif (preg_match("/en/i", $browserLang)) {
        // echo '英文';
        if ($enLang) {
            return $key;
        } else {
            if (in_array($key, $langArr)) {
                return array_search($key, $langArr);
            } else {
                return 'NULL EN';
            }
        }
    }
}

?>
<script type="text/javascript" charset="utf-8">
window.onload = function(){
    var oTable = document.getElementById("tbody1");
    for(var i=0;i<oTable.rows.length;i++){
        oTable.rows[i].cells[0].innerHTML = (i+1);
        if(i%2==0){
            oTable.rows[i].className = "td_no1";
        }  //偶数行
    }
}
function changeSortType(){
    var sortType = document.getElementById("sortType").value;
    if (sortType == 'desc') {
        document.getElementById("sortName").value = null;
        document.getElementById("sortType").value = "asc";
    } else {
        document.getElementById("sortName").value = null;
        document.getElementById("sortType").value = "desc";
    }
    document.all("btnOrder").click();
}
function changeSortByName(){
    var sortName = document.getElementById("sortName").value;
    if (sortName == 'az') {
        document.getElementById("sortType").value = null;
        document.getElementById("sortName").value = "za";
    } else {
        document.getElementById("sortType").value = null;
        document.getElementById("sortName").value = "az";
    }
    document.all("btnOrder").click();
}
</script>
</body>
</html>
