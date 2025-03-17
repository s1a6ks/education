<?php
$array = [3, 6, 4, 8, 2, 5, 9]; 

foreach ($array as &$value) {
    if ($value > 5) {
        $value = 0.2;
    }
}

print_r($array); 