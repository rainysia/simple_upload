<?php

echo "<h1 style='color:grey;text-align:center;font-family:cursive;'>Sync XXX Log</h1><hr style='border-width:4px;' />";

exec('/bin/bash /data1/sh/sync_log.sh', $res, $rc);

echo '<pre>';
print_r($res);
print_r($rc==1 ? 'Sync Success' : 'Sync Fail');
echo '</pre>';

echo '<a href="./" target="_blank" style="color:red;font-weight:bold; font-size:16px; text-decoration: none; font-family: sans-serif; " >Click Here to return LOG page</a>';
echo '<a href="./xxx1/" target="_blank" style="color: #712edc;font-weight:bold; font-size:14px; text-decoration: none; font-family: sans-serif; display:block; margin-top: 35px; ">1. Click Here to xxx1 LOG page</a>';
echo '<a href="./xxx2/" target="_blank" style="color: #287b5d;font-weight:bold; font-size:14px; text-decoration: none; font-family: sans-serif; display:block; margin-top: 15px; ">2. Click Here to xxx2 LOG page</a>';
echo '<a href="./xxx3/" target="_blank" style="color: #e49b2e;font-weight:bold; font-size:14px; text-decoration: none; font-family: sans-serif; display:block; margin-top: 15px; ">3. Click Here to xxx3 LOG page</a>';
echo '<a href="./xxx4/" target="_blank" style="color: #865b4b;font-weight:bold; font-size:14px; text-decoration: none; font-family: sans-serif; display:block; margin-top: 15px; ">4. Click Here to xxx4 LOG page</a>';
