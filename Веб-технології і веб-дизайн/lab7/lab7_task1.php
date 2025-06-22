<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "EventManager";
// Підключення
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Помилка з'єднання: " . $conn->connect_error);
}

$message = '';
$message_type = '';

// Додавання події
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $title = trim($_POST['title'] ?? '');
    $event_date = trim($_POST['event_date'] ?? '');
    $location = trim($_POST['location'] ?? '');
    $participants = intval($_POST['participants'] ?? 0);
    if ($title && $event_date && $location) {
        $stmt = $conn->prepare("INSERT INTO events (title, event_date, location, participants) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("sssi", $title, $event_date, $location, $participants);
        if ($stmt->execute()) {
            $message = 'Подію додано успішно!';
            $message_type = 'success';
            // Очищення форми після успішного додавання
            $_POST = array();
        } else {
            $message = 'Помилка: ' . $stmt->error;
            $message_type = 'error';
        }
    } else {
        $message = 'Заповніть усі поля.';
        $message_type = 'error';
    }
}
?>

<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Manager</title>
</head>
<body>
    <div class="container">
        <?php if ($message): ?>
            <div class="message <?= $message_type ?>">
                <?= htmlspecialchars($message) ?>
            </div>
        <?php endif; ?>
        
        <h2>Додати подію</h2>
        <form method="POST" class="event-form">
            <div class="form-group">
                <label>Назва події</label>
                <input type="text" name="title" value="<?= htmlspecialchars($_POST['title'] ?? '') ?>" required>
            </div>
            
            <div class="form-group">
                <label>Дата</label>
                <input type="date" name="event_date" value="<?= htmlspecialchars($_POST['event_date'] ?? '') ?>" required>
            </div>
            
            <div class="form-group">
                <label>Місце проведення</label>
                <input type="text" name="location" value="<?= htmlspecialchars($_POST['location'] ?? '') ?>" required>
            </div>
            
            <div class="form-group">
                <label>Кількість учасників</label>
                <input type="number" name="participants" min="0" value="<?= htmlspecialchars($_POST['participants'] ?? '0') ?>" required>
            </div>
            
            <button type="submit" class="submit-btn">Додати подію</button>
        </form>
    </div>
</body>
</html>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
    background: #f8f9fa;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    color: #495057;
}

.container {
    background: white;
    border-radius: 4px;
    padding: 40px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    width: 100%;
    max-width: 400px;
    border: 1px solid #e9ecef;
}

h2 {
    color: #343a40;
    margin-bottom: 32px;
    font-size: 20px;
    font-weight: 500;
    text-align: center;
}

.event-form {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

label {
    color: #6c757d;
    font-weight: 400;
    font-size: 14px;
    margin-bottom: 4px;
}

input {
    padding: 12px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    font-size: 16px;
    transition: border-color 0.15s ease;
    background: white;
    color: #495057;
    width: 100%;
}

input:focus {
    outline: none;
    border-color: #6c757d;
}

input:hover {
    border-color: #adb5bd;
}

.submit-btn {
    background: #6c757d;
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 4px;
    font-size: 16px;
    font-weight: 400;
    cursor: pointer;
    transition: background-color 0.15s ease;
    margin-top: 8px;
    width: 100%;
}

.submit-btn:hover {
    background: #5a6268;
}

.submit-btn:active {
    background: #545b62;
}

.message {
    padding: 12px;
    border-radius: 4px;
    margin: 16px 0;
    font-weight: 400;
    text-align: center;
    font-size: 14px;
}

.message.success {
    background: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
}

.message.error {
    background: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
}

@media (max-width: 480px) {
    .container {
        padding: 30px 20px;
        margin: 10px;
    }
    
    h2 {
        font-size: 18px;
    }
}
</style>