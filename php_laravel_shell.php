<?php
echo "<h1 style='color:grey;text-align:center;font-family:cursive;'>Run project shell</h1><hr style='border-width:4px;' />";
$instruction = <<<TF
    Default user is <b>apache</b><br />
    Default key is empty <br />
    You should input link like this: <br />
TF;
echo "<span style='color:#d64d8c;font-family:cursive;'>",$instruction.'</span><br />';
echo "<h3 style='color:#b36aad;font-family:cursive;'>",$_SERVER['SERVER_NAME'],$_SERVER["SCRIPT_NAME"],'?user=apache&path=/opt/app/nginx/html/env{x1}/project{x2}&command={x3}&key={x4}<br />';
echo "<h3 style='color:#b36aad;font-family:cursive;'>It will run <b>sudo -u apache php artisan ", $_SERVER["DOCUMENT_ROOT"], '/env{x}/project{x} $key</b><br />';
echo "i.e.:  <br />
http://shell.test.com/index.php?user=apache&path=/opt/app/nginx/html/env1/test&command=TestCommand&key=true<br />
";

$_user    = (isset($_GET['user']) && !empty($_GET['user'])) ? trim($_GET['user']) : 'apache';
$_command = (isset($_GET['command']) && !empty($_GET['command'])) ? trim($_GET['command']) : null;
$_param   = (isset($_GET['key']) && !empty($_GET['key'])) ? trim($_GET['key']) : '';
$_path    = (isset($_GET['path']) && !empty($_GET['path'])) ? trim($_GET['path']) : null;


if (empty($_path) || !is_dir($_path)) {
    echo "<h2 style='color:red;text-align:center;font-family:cursive;'>Wrong project path !!!</h1>";
}

$run = "sudo -u $_user php $_path/artisan $_command $_param";
//$run = "php $_path/artisan $_command $_param";
//$run = "php $_path $_command $_param";
echo "<pre><div style='color:#ca81b3;font-family:cursive;'>";
if (empty($_command) || empty($_path)) {
    echo 'user:',$_user,'; path:',$_path,'; command:',$_command,'; param:',$_param.'<br />';
    echo 'You will run command:<br />';
    echo '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp<b>',$run,'</b><br />';
    echo 'empty command or nonexist path<br />';
} else {
    echo 'user:',$_user,'; path:',$_path,'; command:',$_command,'; param:',$_param.'<br />';
    echo 'You will run command:<br />';
    echo '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp<b>',$run,'</b><br />';
    ini_set('memory_limit', '256M');
    set_time_limit(0);
    exec($run, $res, $rc);
    print_r($res);
    print_r($rc==1 ? 'Run Success' : 'Run Fail');
}

echo '</div></pre>';
