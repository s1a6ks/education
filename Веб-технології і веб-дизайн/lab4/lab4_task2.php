<?php
function isPrime($number) {
    if ($number <= 1) {
        return false;
    }
    for ($i = 2; $i <= sqrt($number); $i++) {
        if ($number % $i == 0) {
            return false;
        }
    }
    return true;
}

echo "<h3>Просте число від 1 до 50:</h3>";
for ($i = 1; $i <= 50; $i++) {
    if (isPrime($i)) {
        echo "$i є простим<br>";
    }
}
?>