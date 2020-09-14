<?php
$new = new SimpleFile(['store_dir' => 'uploads']);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta name="author" content="tommyx" />
    <title><?php echo $new->getMultiLang('简易文件上传');?></title>
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
#tbody1 .tr_no1 {background-color: #f5f5f5;}
#tbody1 .td_content {padding-top:2px;}
#bg_return {
    margin:-8px -8px;
    padding:10px 0 10px 20px;
    background:#DAFFEE;
    background:-moz-linear-gradient(top,#DAFFEE,#FFFFFF);
    background:-o-linear-gradient(top,#DAFFEE,#FFFFFF);
    background:-webkit-gradient(linear, 0 0, 0 bottom, from(#DAFFEE), to(#FFFFFF));
    filter:progid:DXImageTransform.Microsoft.gradient(startcolorstr=#DAFFEE,endcolorstr=#FFFFFF,gradientType=0);
    *zoom:1;
}
</style>

<script type="text/javascript" charset="utf-8">
function changeSortName(sortName){
    var sortType= document.getElementById("sortType").value;
    if (sortType == 'asc') {
        document.getElementById("sortType").value = "desc";
    } else {
        document.getElementById("sortType").value = "asc";
    }
    console.log(sortType);
    document.getElementById("sortName").value = sortName;
    document.all("btnOrder").click();
}
</script>
<body>
<div id="form1">
<form enctype="multipart/form-data" action="" method="post" name="form1" >
        <div class="choose1"><?php echo $new->getMultiLang('请选择文件');?>:</div>
            <input type="hidden" class="sortName" id="sortName" name="sortName" value="<?php echo $_REQUEST['sortName'] = isset($_REQUEST['sortName']) ? $_REQUEST['sortName'] : 'ctime'; ?>" />
            <input type="hidden" class="sortType" id="sortType" name="sortType" value="<?php echo $_REQUEST['sortType'] = isset($_REQUEST['sortType']) ? $_REQUEST['sortType'] : 'desc'; ?>" />
            <input type="hidden" class="user" id="user" name="user" value="<?php echo $_REQUEST['user'] = isset($_REQUEST['user']) ? $_REQUEST['user'] : null; ?>" />
        <div class="file1"><input name="upload_file" class="upload_file" type="file"></div>
        <div class="btn1"><input type="submit" name="btnOrder" class="btnOrder" value="<?php echo $new->getMultiLang('上传文件');?>"></div>
</form>
<!--<div class="hints" style="display:none;"></div>-->
</div>
<?php
/**
 * SimplePHPFile
 *
 * PHP version 7.0.27-0+deb9u1
 *
 * @filename   new_index.php
 * @category   Tools
 * @package    UploadsDownload
 * @author     Rainy Sia <rainysia@gmail.com>
 * @copyright  2006-2018 BTROOT.ORG
 * @license    http://www.wikipedia.org/user_guide/license.html V1
 * @version    GIT: 3.0.1
 * @createTime 2013-11-12 16:57:53
 * @lastChange 2018-02-08 13:45:51
 *
 * @link http://www.btroot.org
**/

/**
 * Generated php file
 *
 * @category Tools
 * @package  UploadsDownload
 * @author   Rainy Sia <rainysia@gmail.com>
 * @license  https://opensource.org/licenses/MIT license
 *
 * @link http://www.btroot.org
 */
class SimpleFile
{
    public $storeDir;
    public $user;

    private $image;
    private $imageInfo;

    protected $hiddenFiles;
    protected $serverDir;
    protected $saveDir;

    const STORE_DIR = 'uploads';
    const FILE_SIZE_MAX = 1000 * 1000 * 1000 * 2;

    private $_hiddenFiles = [
        'test.pptx'
    ];
    private $_adminGroup = [
        'iamadmin' => true,
        'superadmin' => true,
    ];
    private $_sortType = [
        'ctime' => true,
        'size'  => true,
        'name'  => true,
    ];

    /**
     * Construct.
     *
     * @param array $initial ['server_root', 'store_dir', 'hidden_files']
     *
     * @return void
     */
    public function __construct($initial)
    {
        $this->hiddenFiles = isset($initial['hidden_files']) ? $initial['hidden_files'] : [];
        $this->storeDir = isset($initial['store_dir']) ? $initial['store_dir'] : self::STORE_DIR;
        $this->serverDir = isset($initial['server_root']) ? $initial['server_root'] : $_SERVER['DOCUMENT_ROOT'];
        $this->saveDir = $this->serverDir . DIRECTORY_SEPARATOR . $this->storeDir . DIRECTORY_SEPARATOR;
        if (!is_dir($this->saveDir)) {
            mkdir($this->saveDir, 0777, true);
        }
        $this->user = (isset($_REQUEST['user']) && !empty($_REQUEST['user'])) ? $_REQUEST['user'] : null;
        $this->_deleteFile();
        $this->_uploadFile();
    }

    /**
     * Display Files.
     *
     * @return array
     */
    public function displayFiles()
    {
        $rawFiles = $this->_getFiles($this->saveDir);
        // sortName= ctime/size/name
        if (isset($_REQUEST['sortName']) && !empty($_REQUEST['sortName'])) {
            $name = $_REQUEST['sortName'];
        }
        // sortType= asc/desc
        if (isset($_REQUEST['sortType']) && !empty($_REQUEST['sortType'])) {
            $sort = $_REQUEST['sortType'];
        }
        // name=ctime/size/name
        return $this->_sort($rawFiles, $sort, $name);
    }

    /**
     * Get Files Tree.
     *
     * @param string $path Folder Path.
     *
     * @return array
     */
    private function _getFiles($path)
    {
        $ctime = [];
        $result = [];
        $adminPrivilege = $this->adminPrivilege();
        $hideFiles = $this->hiddenFiles;

        foreach (glob($path.'/*') as $single) {
            if (is_dir($single)) {
                $result = array_merge($result, $this->_getFiles($single));
            } else {
                $_tmp_single = pathinfo($single);
                if (isset($hideFiles[$_tmp_single['basename']])) {
                    continue;
                }
                $ctime = filectime($single);
                $fileSize = $this->_getFileSize($single);
                $result[$single] = array_merge(
                    [
                        'name' => $single,
                        'ctime'        => $ctime,
                        'ctimeFormat'  => date('Y-m-d H:i:s', $ctime),
                        'size'         => $fileSize['raw'],
                        'sizeFormat'   => $fileSize['format'],
                        'relativeFile' => substr($single, strlen($this->saveDir) + 1),
                    ], $_tmp_single);
            }
        }
        return $result;
    }

    /**
     * Privilege
     *
     * @return boolean
     */
    public function adminPrivilege()
    {
        $adminGroup = $this->_adminGroup;
        if (isset($_REQUEST['user']) && isset($adminGroup[$_REQUEST['user']]) && $adminGroup[$_REQUEST['user']] == true) {
            return true;
        }
        return false;
    }

    /**
     * Remove files.
     *
     * @return void
     */
    private function _deleteFile()
    {
        if (isset($_REQUEST['del_file']) && !empty($_REQUEST['del_file'])) {
            if ($this->adminPrivilege() == false) {
                echo 'Can\'t delete others file, System permission deny!';
                echo '<script type="text/javascript" charset="utf-8">location.replace("'.$_SERVER['SCRIPT_NAME'].'")</script>';
                exit;
            }
            try {
                // $_GET will transfer + to space
                $_del_file = base64_decode(str_replace(" ", "+", $_REQUEST['del_file']));
                if (is_file($this->saveDir.$_del_file)) {
                    $_del_tmp_file = $this->saveDir.$_del_file;
                    unlink($_del_tmp_file);
                    echo 'Delete '.$_del_file.' successful!';
                    unset($_REQUEST['del_file'], $_del_tmp_file, $_del_file);
                    echo '<script type="text/javascript" charset="utf-8">location.replace("'.$_SERVER['HTTP_REFERER'].'")</script>';
                } else {
                    echo $_REQUEST['del_file']." is not a real file!";
                }
            } catch (Exception $e) {
                echo 'delete file error:'.$e->getMessage();
                echo '<script type="text/javascript" charset="utf-8">location.replace("'.$_SERVER['HTTP_REFERER'].'")</script>';
            }
            exit;
        }
    }

    /**
     * Upload file.
     *
     * @return void
     */
    private function _uploadFile()
    {
        if (!empty($_FILES)) {
            $upload_file = isset($_FILES['upload_file']['tmp_name']) ? $_FILES['upload_file']['tmp_name'] : '';
            $upload_file_name = isset($_FILES['upload_file']['name']) ? $_FILES['upload_file']['name'] : '';
            $upload_file_size = isset($_FILES['upload_file']['size']) ? $_FILES['upload_file']['size'] : '';
            if ($upload_file) {
                // set upload parameters
                ini_set('upload_max_filesize', '2048M');
                ini_set('post_max_size', '2048M');
                ini_set('max_input_time', '600');
                ini_set('max_execution_time', '600');
                ini_set('memory_limit', '-1');

                // allow overwrite
                $accept_overwrite = 1;

                try {
                    // can't excess the FILE_SIZE_MAX
                    if ($upload_file_size > self::FILE_SIZE_MAX) {
                        echo 'Sorry for the file size exceed '. self::FILE_SIZE_MAX;
                    }
                    if (file_exists($this->saveDir . $upload_file_name) && !$accept_overwrite) {
                        echo 'Exists the same name file';
                    }
                    // copy fileds
                    if (!move_uploaded_file($upload_file, $this->saveDir.$upload_file_name)) {
                        echo 'Copy file failed!';
                    }
                    $this->fontMark($this->saveDir.$upload_file_name, '@凉拌回锅肉醋溜小番茄', '/usr/share/fonts/simhei.ttf', 16, 2, $fontColor = [255, 255, 255], $showOrTransfer = false);
                } catch (Exception $e) {
                    echo 'Error upload:'.$e->getMessage();
                }
                echo '<script type="text/javascript" charset="utf-8">location.replace("'.$_SERVER['HTTP_REFERER'].'")</script>';
                exit;
            }
        }
    }

    /**
     * Sort the files.
     *
     * @param array  $fileTree File tree
     * @param string $sort     asc/desc
     * @param string $name     Sort Type ctime/size/name
     *
     * @return array
     */
    private function _sort($fileTree, $sort, $name = 'ctime')
    {
        $sortType = $this->_sortType;
        $sortConstant = SORT_DESC;
        $sortKey = 'ctime';

        if ($sort == 'asc') {
            $sortConstant = SORT_ASC;
        }

        if (isset($sortType[$name])) {
            $sortKey = $name;
        }
        array_multisort(array_column($fileTree, $sortKey), $sortConstant, $fileTree);

        return $fileTree;
    }

    /**
     * Get File Size.
     *
     * @param string $file File directly path.
     *
     * @return array ['format', 'raw']
     */
    private function _getFileSize($file)
    {
        $rawSize = $fileSize = filesize($file);
        if ($fileSize >= 1073741824) {
            $fileSize = round($fileSize / 1073741824 * 100) / 100 . ' GB';
        } elseif ($fileSize >= 1048576) {
            $fileSize = round($fileSize / 1048576 * 100) / 100 . ' MB';
        } elseif ($fileSize >= 1024) {
            $fileSize = round($fileSize / 1024 * 100) / 100 . ' kB';
        } else {
            $fileSize = $fileSize. ' B';
        }
        return ['raw' => $rawSize, 'format' => $fileSize];
    }

    /**
     * Get match name.
     *
     * @param string $key content.
     *
     * @return string.
     */
    public function getMultiLang($key)
    {
        $langArr = [
            'key'                         => '值',
            'SimpleFileUploadAndDownload' => '简易文件上传',
            'Please Choose File'          => '请选择文件',
            'Upload'                      => '上传文件',
            'Download'                    => '下载链接',
            'Upload Time'                 => '上传时间',
            'Size'                        => '大小',
            'Sort by Time'                => '时间排序',
            'ASC'                         => '顺序',
            'DESC'                        => '倒序',
            'asc'                         => '顺序',
            'desc'                        => '倒序',
            'Sort by Name'                => '文件名排序',
            'Sort by Size'                => '大小排序',
            'No'                          => '序号',
            'Action'                      => '删除'
        ];
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

    /**
     * Add Font Mark.
     *
     * @param string  $imageSrc       Image full path with imagename and extension.
     * @param string  $text           Font Mark Text
     * @param string  $fontSrc        Font full path with font name and extension.
     * @param integer $fontSize       Font Size
     * @param integer $position       1 Top-Left 2, Bottom-Left
     * @param array   $fontColor      RGB [255, 255, 255]
     * @param boolean $showOrTransfer true will show directly, false will transfer and show
     *
     * @return void
     */
    public function fontMark($imageSrc, $text, $fontSrc = '/usr/share/fonts/simhei.ttf', $fontSize = 20, $position = 2, $fontColor = [255, 255, 255], $showOrTransfer = false)
    {
        $positionArr = [1, 2, 3, 4, 5]; // 1 Top-Left 2, Bottom-Left, 3, Top-Right, 4, Botton-Right, 5, Middle
        $imageInfo = getimagesize($imageSrc);
        $imageType = image_type_to_extension($imageInfo[2], false);

        $displayType = pathinfo($imageSrc, PATHINFO_EXTENSION);

        if ($displayType != $imageType) {
            $newImageSrc = pathinfo($imageSrc, PATHINFO_DIRNAME).DIRECTORY_SEPARATOR.pathinfo($imageSrc, PATHINFO_FILENAME).'.'.$imageType;
            copy($imageSrc, $newImageSrc);
            unlink($imageSrc);
            $imageSrc = $newImageSrc;
        }

        if (!in_array($imageType, ['png', 'jpg', 'jpeg', 'gif'])) {
            return true;
        }
        $this->imageInfo = $imageInfo;
        $this->imageInfo['type'] = $imageType;
        $fun = "imagecreatefrom".$imageType;
        $this->image = $fun($imageSrc);
        $imageColor = imagecolorallocate($this->image, $fontColor[0], $fontColor[1], $fontColor[2]);

        if (!in_array($position, $positionArr)) {
            $position = 2;
        }

        $fontX = 20;
        $fontY = 30;
        switch ($position) {
            case 1:
                break;
            case 2:
                $fontY = $imageInfo[1] - $fontY;
                break;
            default:
                break;
        }
        imagettftext($this->image, $fontSize, 0, $fontX, $fontY, $imageColor, $fontSrc, $text);

        $fun2 = 'image'.$this->imageInfo['type'];
        if ($showOrTransfer == true) {
            header('Content-Type:'. $this->imageInfo['mime']);
            $fun2($this->image);
        } else {
            $fun2($this->image, $imageSrc);
            //$fun($this->image);
        }
        return true;
    }
}

$newArr = $new->displayFiles();
//error_log(var_export(['na' => $newArr ], 1)."\n", 3, "/var/log/php_errors.log");
$adminPrivilege = $new->adminPrivilege();

// output Sort th
echo '<div id="typeAll">';
    echo '<div class="type1" style="margin:0 20px 0 0px;float:left;"><a class="a1" href="#" onClick="changeSortName('. '\'name\');"><span>'.$new->getMultiLang("文件名排序").'</span></a></div>';
    echo '<div class="type2" style="margin:0 20px 0 600px;"><a class="a2" href="#" onClick="changeSortName('. '\'ctime\');" style=""><span>'.$new->getMultiLang("时间排序").'</span></a></div>';
    echo '<div class="type3" style="margin:-25px 20px 0 780px; float:left;"><a class="a3" href="#" onClick="changeSortName('. '\'size\');" style=""><span>'.$new->getMultiLang("大小排序").'</span></a></div>';
    echo '<div class="hr1"></div>';
echo '</div>';
echo '<p style="clear:both;"></p>';

// output th
echo '<div id="table1">
        <table>
            <tr>
                <th class="th_no" style="width:40px;">'.$new->getMultiLang("序号").'</th>
                <th class="th1">'.$new->getMultiLang("下载链接").'</th>
                <th class="th2">'.$new->getMultiLang("上传时间").'</th>
                <th class="th3">'.$new->getMultiLang("大小").'</th>';
        if ($adminPrivilege == true) {
            echo '<th class="th4">'.$new->getMultiLang("删除").'</th>';
        }
        echo '</tr><tbody id="tbody1">';

foreach ($newArr as $full_path => $file) {
    echo '<tr>
                <td class="td_no"></td>
                <td class="td_content">
                    <span style="display:block;width:570px;height:18px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;">
                        <a class="download_url" href="'.$new->storeDir.DIRECTORY_SEPARATOR.$file['relativeFile'].'">'.$file['relativeFile'].'</a>
                    </span>
                </td>
                <td><span style="display:block;width:180px;">'.$file['ctimeFormat'].'</span></td>
                <td>'.$file['sizeFormat'].'</td>';

        if (is_file($full_path) && $adminPrivilege == true) {
            echo '<td class="td_del"><a href="?del_file='.base64_encode($file['relativeFile']).'&user='.$_REQUEST['user'].'">DELETE</a></td>';
        }
    echo '</tr>';
}
echo '</tbody></table></div>';
?>
<script type="text/javascript" charset="utf-8">
window.onload = function(){
    var oTable = document.getElementById("tbody1");
    for(var i=0;i<oTable.rows.length;i++){
        oTable.rows[i].cells[0].innerHTML = (i+1);
        if(i%2==0){
            oTable.rows[i].className = "tr_no1";
        }
    }
}
</script>
</body>
</html>
