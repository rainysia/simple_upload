<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;
use DB;
use App\Utils\Constants;
use App\Helper\Common;

class CountColumn extends Command
{
    /**
     * The name and signature of the console command.
     *
    select 
    concat_ws(',', 
                concat("'", TABLE_SCHEMA, "'"), 
                concat("'", TABLE_NAME, "'"), 
                concat("'", COLUMN_NAME, "'"), 
                concat("'", DATA_TYPE, "'"), 
                concat("'", CHARACTER_MAXIMUM_LENGTH, "'"), 
                concat("'", CHARACTER_OCTET_LENGTH, "'"), 
                concat("'", CHARACTER_SET_NAME, "'"), 
                concat("'", COLLATION_NAME, "'"), 
                concat("'", COLUMN_TYPE, "'")
                ) 
    from INFORMATION_SCHEMA.COLUMNS 
    where TABLE_SCHEMA='test' and DATA_TYPE not in ('int', 'tinyint', 'bigint', 'decimal', 'timestamp', 'date', 'datetime', 'enum') limit 5000;
     *
     * @var string
     */
    protected $signature = 'CountColumn';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Count column overrun the column maximum length';

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $this->process();
    }

    /**
     * Get the column length, only calculate the data_type in varchar, text, longtext, char
     *
     * @return boolean
     */
    private function process()
    {
        $test_conn = 'test_system';
        $condition = [];

        $column_arr = $this->getColumnFile();
        if (count($column_arr) > 0) {
            $n = 1;
            foreach ($column_arr as $k => $v) {
                // select * from xxx where length(xxx_column)=(select max(length(xxx_column)) from xxx);
                $table_name = trim($v['TABLE_NAME'], "'");
                //$sql = "select * from $table_name where length({$v['COLUMN_NAME']})=(select max(length({$v['COLUMN_NAME']})) from $table_name);";
                $column_name = trim($v['COLUMN_NAME'], "'");
                $sql = "select max(length(`$column_name`)) as maxlen from `$table_name`;";
                try {
                    $_res = DB::connection($test_conn)->select($sql, $condition);
                } catch (Exception $e) {
                    echo $sql. " can't execute causing ".$e->getMessage()." \n";
                    continue;
                }
                $_length = $_res[0]->maxlen;

                if ($_length / trim($v['CHARACTER_MAXIMUM_LENGTH'], "'") >  0.5) {

                    $sql_res = "select * from `$table_name` where length(`$column_name`)=(select max(length(`$column_name`)) as maxlen from `$table_name`);";
                    //$sql_res = DB::connection($test_conn)->select($sql_res, $condition);
                    //echo json_encode($sql_res)."\n";
                    echo $sql_res."\n";
                    echo 'table:'.$v['TABLE_NAME'].', column:'.$v['COLUMN_NAME']
                        .', column_type:'. $v['COLUMN_TYPE']
                        .', nearly overrun length:'. $_length
                        ."\n";
                    $n++;
                }
            }
            echo 'total'. $n. "\n";
        }
    }

    /**
     * Get column file as array.
     *
     * @return array 
     *      [TABLE_SCHEMA] => 'xxxdb'
     *      [TABLE_NAME] => '_tot'
     *      [COLUMN_NAME] => 'comment'
     *      [DATA_TYPE] => 'varchar'
     *      [CHARACTER_MAXIMUM_LENGTH] => '1024'
     *      [CHARACTER_OCTET_LENGTH] => '3072'
     *      [CHARACTER_SET_NAME] => 'utf8'
     *      [COLLATION_NAME] => 'utf8_general_ci'
     *      [COLUMN_TYPE] => 'varchar(1024)'
     */
    private function getColumnFile()
    {
        $column_file = dirname(dirname(dirname(dirname(__FILE__)))) . DIRECTORY_SEPARATOR.'doc'.DIRECTORY_SEPARATOR.'sql_column_file.txt';
        $arr_content = [];
        if (file_exists($column_file)) {
            $filesize = filesize($column_file);
            if ($filesize >= 1073741824) {
                if ($filesize > 2147483648) {
                    return false;
                }
                $filesize = round($filesize / 1073741824 * 100 / 100 / 1024)  . 'G';
                @ini_set('max_execution_time', '360');
            } elseif ($filesize >= 1048576) {
                $filesize = (round($filesize / 1048576 * 100) / 100 + 100) . 'M';
                @ini_set('max_execution_time', '180');
            } elseif ($filesize >= 1024) {
                $filesize = round(($filesize / 1024 * 100 / 100 + 100 * 1024) / 1024) . 'M';
            } else {
                $filesize = round(($filesize + 50 * 1024 * 1024) / (1024 * 1024)). 'M';
            }
            @ini_set('memory_limit', $filesize);

            $handle = @fopen($column_file, "r");
            if ($handle) {
                while(!feof($handle)){
                    // error_log(var_export(array('php_memory' => $this->convert(memory_get_usage(true)) ), 1)."\n", 3, "/var/log/php_errors.log");
                    $buffer = fgets($handle, 4096 * 5);
                    if (!feof($handle)) {
                        $arr_content[] = explode(",", $buffer);
                    }
                }
            }
            fclose($handle);
        }
        $res = [];
        if (count($arr_content) > 0) {
            $column_fileds = array_shift($arr_content);
            if (count($column_fileds) == count($arr_content[0])) {
                $count = count($column_fileds);
                foreach ($arr_content as $k => $v) {
                    for ($i = 0; $i < $count; $i++) {
                        if ($i == $count - 1) {
                            $res[$k][preg_replace('/\r|\n/', '', $column_fileds[$i])] = preg_replace('/\r|\n/','', $v[$i]);
                        } else {
                            $res[$k][$column_fileds[$i]] = $v[$i];
                        }
                    }
                }
            }
        }
        return $res;
    }

    /**
     * Transfer memory unit
     *
     * @param integer $size bytes
     *
     * @return string. XXb,kb,mb,gb
     */
    private function convert($size) {
        $unit=array('b','kb','mb','gb','tb','pb');
        return @round($size/pow(1024,($i=floor(log($size,1024)))),2).' '.$unit[$i];
    }


    /*
     * file
        TABLE_SCHEMA,TABLE_NAME,COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,CHARACTER_OCTET_LENGTH,CHARACTER_SET_NAME,COLLATION_NAME,COLUMN_TYPE
        'db','game','role','varchar','1000','3000','utf8','utf8_general_ci','varchar(1000)'
        'db','game','name','varchar','45','135','utf8','utf8_general_ci','varchar(45)'"
        'db','game','reason','varchar','100','300','utf8','utf8_general_ci','varchar(100)'"
    */

}
