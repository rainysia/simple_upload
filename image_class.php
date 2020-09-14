<?php
/**
 * Short description for file
 *
 * PHP version 7.4.10
 *
 * @filename   image_class.php
 * @category   CategoryName
 * @package    PackageName
 * @author     Rainy Sia <rainysia@gmail.com>
 * @copyright  2013-2020 BTROOT.ORG
 * @license    https://opensource.org/licenses/MIT license
 * @version    GIT: 0.0.1
 * @createTime 2020-09-14 17:16:35
 * @lastChange 2020-09-14 17:16:35
 *
 * @link http://www.btroot.org
**/
namespace ImageCls;

/**
 * Image Class
 *
 * @return void
 */
class ImageCls
{
    private $image;
    private $info;

    /**
     * Construct .
     *
     * @param string $src Image Path.
     *
     * @return void
     */
    public function __construct($src)
    {
        $info = getimagesize($src);
        $type = image_type_to_extension($info[2], false);
        $this->info = $info;
        $this->info['type'] = $type;
        $fun = "imagecreatefrom" .$type;
        $this->image = $fun($src);
    }


    /**
     * Add Font Mark
     *
     * @param integer $fontsize 字体大小
     * @param integer $x        字体在图片中的x位置
     * @param integer $y        字体在图片中的y位置
     * @param array   $color    字体的颜色是一个包含rgba的数组
     * @param string  $text     想要添加的内容
     *
     * @return void
     */
    public function fontMark($fontsize, $x, $y, $color, $text)
    {
        //$col = imagecolorallocatealpha($this->image, $color[0], $color[1], $color[2], $color[3]);
        //imagestring($this->image, $fontsize, $x, $y, $text, $col);

        $canvas = imagecolorallocate($this->image, $color[0], $color[1], $color[2]);
        //使用指定的字体文件绘制文字
        //参数2：字体大小
        //参数3：字体倾斜的角度
        //参数4、5：文字的x、y坐标
        //参数6：文字的颜色
        //参数7：字体文件
        //参数8：绘制的文字
        imagettftext($this->image, $fontsize, 0, $x, $y, $canvas, '/usr/share/fonts/simhei.ttf', $text);
    }

    /*
     * Output the image
     *
     * @return void
     */
    public function show()
    {
        header('content-type:' . $this->info['mime']);
        $fun='image' . $this->info['type'];
        $fun($this->image);
    }

    /**
     * Destruct
     *
     * @return void
     */
    public function __destruct()
    {
        imagedestroy($this->image);
    }
}

//对类的调用
$obj = new ImageCls('./google_map_1.png');
$obj->fontMark(20, 20, 30, [255,255,255], "@凉拌回锅肉醋溜小番茄");
$obj->show();
