<?php
$start = microtime(true); // Початок вимірювання часу

$product = 1;
for ($i = 1; $i <= 10; $i++) {
    $product *= $i;
}

$end = microtime(true); // Кінець вимірювання часу
$executionTime = $end - $start;

echo "Добуток чисел від 1 до 10: $product <br>";
echo "Час виконання скрипту: " . number_format($executionTime, 10) . " секунд";
?>