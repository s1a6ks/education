<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "Products";

$conn = new mysqli($servername, $username, $password);
if ($conn->connect_error) {
    die("Помилка з'єднання: " . $conn->connect_error);
}

$sql = "CREATE DATABASE IF NOT EXISTS $dbname";
if ($conn->query($sql) === TRUE) {
    echo "Базу даних створено<br>";
} else {
    echo "Помилка створення БД: " . $conn->error;
}

$conn->select_db($dbname);

$sql = "CREATE TABLE IF NOT EXISTS ProductDetails (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price FLOAT,
    stock_quantity INT
)";
if ($conn->query($sql) === TRUE) {
    echo "Таблицю створено<br>";
} else {
    echo "Помилка створення таблиці: " . $conn->error;
}

$conn->close();
?>
