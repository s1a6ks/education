<?php
$array = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4];
$frequency = array_count_values($array);

echo "<h3>Частотність елементів масиву:</h3>";
foreach ($frequency as $key => $value) {
    echo "$key зустрічається $value разів<br>";
}
?>