<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $input_text = $_POST['text'];
    echo "<h3>Результат:</h3>";

    echo "<p><strong>Введений текст:</strong> $input_text</p>";

    if (ctype_digit($input_text)) {
        echo "Текст містить лише цифри.";
    } else {
        echo "Текст містить не лише цифри.";
    }
}
?>

<form action="lab5_task2.php" method="POST">
    <label for="text">Введіть текст:</label>
    <input type="text" id="text" name="text" required>
    <input type="submit" value="Перевірити">
</form>
