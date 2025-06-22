# Лабораторна робота №6

**Тема:** Взаємодія з MySQL. CRUD-операції  
**Виконавець:** Горецький Максим  
**Група:** KNms1-B23  
**Дата виконання:** 15.06.2025  
**Варіант:** 5

---

## Завдання 1

**Умова:**  
Створити базу даних "Products" та таблицю "ProductDetails" зі стовпцями:  
`id`, `name`, `category`, `price`, `stock_quantity`.

```php
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
```
[➡️ Перейти до коду](lab6_task1.php)

**Результат:**  
[![Скріншот Завдання 1](./screenshots/task1.png)](./screenshots/task1.png)

---

## Завдання 2

**Умова:**  
Реалізувати сторінку для створення нового продукту та валідацію введених даних.

```php
<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "Products";

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
```
[➡️ Перейти до коду](lab6_task2.php)

**Результат:**  
[![Скріншот Завдання 2](./screenshots/task2.png)](./screenshots/task2.png)

---

## Завдання 3

**Умова:**  
Додати функціонал для відображення та видалення продуктів, які більше не доступні на складі (stock_quantity = 0).

```php
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
```
[➡️ Перейти до коду](lab6_task3.php)

**Результат:**  
[![Скріншот Завдання 3](./screenshots/task3.png)](./screenshots/task3.png)
