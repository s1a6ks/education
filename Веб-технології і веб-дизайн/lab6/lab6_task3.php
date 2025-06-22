<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "Products";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Помилка з'єднання: " . $conn->connect_error);
}

if (isset($_GET['delete_id'])) {
    $id = intval($_GET['delete_id']);
    $stmt = $conn->prepare("DELETE FROM ProductDetails WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
}

$sql = "SELECT * FROM ProductDetails WHERE stock_quantity = 0";
$result = $conn->query($sql);

echo "<h3>Продукти з нульовим запасом:</h3>";
if ($result->num_rows > 0) {
    echo "<table border='1'>
            <tr><th>ID</th><th>Назва</th><th>Категорія</th><th>Ціна</th><th>Дія</th></tr>";
    while ($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$row['id']}</td>
                <td>{$row['name']}</td>
                <td>{$row['category']}</td>
                <td>{$row['price']}</td>
                <td><a href='?delete_id={$row['id']}'>Видалити</a></td>
              </tr>";
    }
    echo "</table>";
} else {
    echo "Немає продуктів з нульовим запасом.";
}

$conn->close();
?>
