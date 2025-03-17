<?php
$start = microtime(true); 

$product = 1;
for ($i = 1; $i <= 10; $i++) {
    $product *= $i;
}

$end = microtime(true); 
$executionTime = $end - $start;

echo "Добуток чисел від 1 до 10: $product <br>";
echo "Час виконання скрипту: " . number_format($executionTime, 10) . " секунд";
?>