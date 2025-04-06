<?php
$alpha = 30; 
$r = 7;      

$sectorArea = ($alpha / 360) * pi() * pow($r, 2);

echo "Площа сектора круга: " . $sectorArea;
?>
