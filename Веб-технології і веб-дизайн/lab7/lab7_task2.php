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
// Видалення події
if (isset($_GET['delete_id'])) {
    $id = intval($_GET['delete_id']);
    $conn->query("DELETE FROM events WHERE id = $id");
    header("Location: lab7_task3.php");
    exit();
}
// Оновлення події
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['update_id'])) {
    $id = intval($_POST['update_id']);
    $title = trim($_POST['title']);
    $date = $_POST['event_date'];
    $location = trim($_POST['location']);
    $participants = intval($_POST['participants']);
    $stmt = $conn->prepare("UPDATE events SET title=?, event_date=?, location=?, participants=? WHERE id=?");
    $stmt->bind_param("sssii", $title, $date, $location, $participants, $id);
    $stmt->execute();
    header("Location: lab7_task3.php");
    exit();
}
// Отримання всіх подій
$events = $conn->query("SELECT * FROM events ORDER BY event_date ASC");
?>

<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Адмінка - Керування подіями</title>
</head>
<body>
    <div class="container">
        <h2>Адмінка: Керування подіями</h2>
        
        <?php if ($events->num_rows > 0): ?>
            <div class="table-container">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Назва</th>
                            <th>Дата</th>
                            <th>Місце</th>
                            <th>Учасники</th>
                            <th>Дії</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($row = $events->fetch_assoc()): ?>
                            <tr>
                                <form method="POST" class="table-form">
                                    <input type="hidden" name="update_id" value="<?= $row['id'] ?>">
                                    <td class="id-cell"><?= $row['id'] ?></td>
                                    <td>
                                        <input type="text" name="title" value="<?= htmlspecialchars($row['title']) ?>" required>
                                    </td>
                                    <td>
                                        <input type="date" name="event_date" value="<?= $row['event_date'] ?>" required>
                                    </td>
                                    <td>
                                        <input type="text" name="location" value="<?= htmlspecialchars($row['location']) ?>" required>
                                    </td>
                                    <td>
                                        <input type="number" name="participants" value="<?= $row['participants'] ?>" min="0" required>
                                    </td>
                                    <td class="actions-cell">
                                        <button type="submit" class="btn-update">Оновити</button>
                                        <a href="?delete_id=<?= $row['id'] ?>" class="btn-delete" onclick="return confirm('Видалити цю подію?')">Видалити</a>
                                    </td>
                                </form>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        <?php else: ?>
            <div class="empty-state">
                <p>Подій немає.</p>
            </div>
        <?php endif; ?>
    </div>
</body>
</html>
<?php $conn->close(); ?>

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
    padding: 20px;
    color: #495057;
}

.container {
    max-width: 800px;
    margin: 0 auto;
}

h2 {
    color: #343a40;
    font-size: 20px;
    font-weight: 500;
    margin-bottom: 24px;
    text-align: center;
}

.events-container {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.event-card {
    background: white;
    border-radius: 4px;
    border: 1px solid #e9ecef;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    overflow: hidden;
}

.event-form {
    padding: 20px;
}

.form-group {
    margin-bottom: 16px;
}

.form-group:last-of-type {
    margin-bottom: 20px;
}

label {
    color: #6c757d;
    font-weight: 400;
    font-size: 14px;
    margin-bottom: 4px;
    display: block;
}

input[type="text"],
input[type="date"],
input[type="number"] {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    font-size: 14px;
    transition: border-color 0.15s ease;
    background: white;
    color: #495057;
}

input:focus {
    outline: none;
    border-color: #6c757d;
}

input:hover {
    border-color: #adb5bd;
}

.actions {
    display: flex;
    gap: 12px;
    align-items: center;
}

.btn-update {
    background: #6c757d;
    color: white;
    border: none;
    
    padding: 10px 16px;
    border-radius: 4px;
    font-size: 14px;
    margin-top: 21px;
    margin-left: 5px;
    font-weight: 400;
    cursor: pointer;
    transition: background-color 0.15s ease;
}

.btn-update:hover {
    background: #5a6268;
}

.btn-delete {
    color: #dc3545;
    text-decoration: none;
    font-size: 14px;
    padding: 10px 16px;
    border-radius: 4px;
    transition: background-color 0.15s ease;
}

.btn-delete:hover {
    background: #f8f9fa;
    color: #c82333;
}

.empty-state {
    background: white;
    border-radius: 4px;
    border: 1px solid #e9ecef;
    padding: 40px;
    text-align: center;
}

.empty-state p {
    color: #6c757d;
    font-size: 16px;
}

@media (max-width: 768px) {
    body {
        padding: 10px;
    }
    
    .container {
        margin: 0;
    }
    
    h2 {
        font-size: 18px;
        margin-bottom: 20px;
    }
    
    .event-form {
        padding: 16px;
    }
    
    .actions {
        flex-direction: column;
        align-items: stretch;
    }
    
    .btn-update,
    .btn-delete {
        text-align: center;
        width: 100%;
    }
}

@media (max-width: 480px) {
    .events-container {
        gap: 12px;
    }
    
    .event-form {
        padding: 12px;
    }
    
    .form-group {
        margin-bottom: 12px;
    }
    
    input[type="text"],
    input[type="date"], 
    input[type="number"] {
        padding: 8px 10px;
        font-size: 16px;
    }
}
</style>