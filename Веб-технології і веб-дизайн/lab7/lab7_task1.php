<?php
$host = "localhost";
$user = "root";
$password = ""; // У XAMPP стандартно пароль порожній
$dbname = "event_system";

// Підключення до MySQL
$conn = new mysqli($host, $user, $password);

// Перевірка з'єднання
if ($conn->connect_error) {
    die("Помилка з'єднання: " . $conn->connect_error);
}

// Створення бази даних
$sql = "CREATE DATABASE IF NOT EXISTS $dbname";
if ($conn->query($sql) === TRUE) {
    $success_db = "Базу даних '$dbname' створено успішно або вона вже існує.<br>";
} else {
    $error_db = "Помилка при створенні БД: " . $conn->error;
}

// Підключення до новоствореної бази
$conn->select_db($dbname);

// Створення таблиці events
$sql_events = "CREATE TABLE IF NOT EXISTS events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    date DATE NOT NULL
)";
$conn->query($sql_events);

// Створення таблиці participants
$sql_participants = "CREATE TABLE IF NOT EXISTS participants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    event_id INT,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
)";
$conn->query($sql_participants);

// Створення таблиці organizers
$sql_organizers = "CREATE TABLE IF NOT EXISTS organizers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100)
)";
$conn->query($sql_organizers);

$success_tables = "Усі таблиці створено успішно.";

$conn->close();
?>

<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .message {
            padding: 15px;
            margin: 10px 0;
            border-radius: 4px;
        }
        
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Система подій</h1>
        
        <?php if (isset($success_db)): ?>
            <div class="message success"><?php echo $success_db; ?></div>
        <?php endif; ?>
        
        <?php if (isset($error_db)): ?>
            <div class="message error"><?php echo $error_db; ?></div>
        <?php endif; ?>
        
        <div class="message success"><?php echo $success_tables; ?></div>
    </div>
</body>
</html>