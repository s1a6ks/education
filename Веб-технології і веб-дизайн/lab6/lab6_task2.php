<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "Products";

// З'єднання з БД
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Помилка з'єднання: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = trim($_POST["name"]);
    $category = trim($_POST["category"]);
    $price = floatval($_POST["price"]);
    $stock = intval($_POST["stock_quantity"]);

    if ($name && $category && $price > 0 && $stock >= 0) {
        $stmt = $conn->prepare("INSERT INTO ProductDetails (name, category, price, stock_quantity) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("ssdi", $name, $category, $price, $stock);
        if ($stmt->execute()) {
            echo "Продукт додано успішно";
        } else {
            echo "Помилка: " . $stmt->error;
        }
    } else {
        echo "Невірні дані";
    }
}
$conn->close();
?>

<form method="POST">
    <label>Назва продукту:</label><br>
    <input type="text" name="name" required><br>
    <label>Категорія:</label><br>
    <input type="text" name="category" required><br>
    <label>Ціна:</label><br>
    <input type="number" name="price" step="0.01" required><br>
    <label>Кількість на складі:</label><br>
    <input type="number" name="stock_quantity" required><br><br>
    <button type="submit">Додати продукт</button>
</form>
