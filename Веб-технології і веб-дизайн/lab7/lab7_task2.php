<?php
$host = "localhost";
$user = "root";
$password = "";
$dbname = "event_system";

$conn = new mysqli($host, $user, $password, $dbname);
if ($conn->connect_error) {
    die("Помилка з'єднання: " . $conn->connect_error);
}

$title = $description = $date = "";
$errors = [];
$success_message = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $title = trim($_POST["title"]);
    $description = trim($_POST["description"]);
    $date = trim($_POST["date"]);

    if (empty($title)) $errors[] = "Поле 'Назва події' є обов'язковим.";
    if (empty($date)) $errors[] = "Поле 'Дата' є обов'язковим.";

    if (empty($errors)) {
        $stmt = $conn->prepare("INSERT INTO events (title, description, date) VALUES (?, ?, ?)");
        $stmt->bind_param("sss", $title, $description, $date);
        if ($stmt->execute()) {
            $success_message = "Подію додано успішно!";
            $title = $description = $date = ""; // очищення форми
        } else {
            $errors[] = "Помилка при додаванні: " . $stmt->error;
        }
        $stmt->close();
    }
}
?>

<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Додати подію</title>
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
            padding: 40px;
            border-radius: 8px;
            padding-left: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h2 {
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
        
        form {
            margin-top: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 20px;
            font-weight: bold;
            color: #333;
        }
        
        input[type="text"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            margin-top: 5px;
        }
        
        textarea {
            height: 100px;
            resize: vertical;
        }
        
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Форма додавання події</h2>
        
        <?php if ($success_message): ?>
            <div class="message success"><?php echo $success_message; ?></div>
        <?php endif; ?>
        
        <?php foreach ($errors as $error): ?>
            <div class="message error"><?php echo $error; ?></div>
        <?php endforeach; ?>
        
        <form method="post">
            <label>Назва події:
                <input type="text" name="title" value="<?= htmlspecialchars($title) ?>">
            </label>

            <label>Опис:
                <textarea name="description"><?= htmlspecialchars($description) ?></textarea>
            </label>

            <label>Дата:
                <input type="date" name="date" value="<?= htmlspecialchars($date) ?>">
            </label>

            <input type="submit" value="Додати подію">
        </form>
    </div>
</body>
</html>