<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "EventManager";
// Підключення до БД
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Помилка з'єднання: " . $conn->connect_error);
}
// Отримання подій
$sql = "SELECT * FROM events ORDER BY event_date ASC";
$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Manager - Список подій</title>
</head>
<body>
    <div class="container">
        <h2>Список подій</h2>
        <?php if ($result->num_rows > 0): ?>
            <div class="table-container">
                <table class="events-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Назва</th>
                            <th>Дата</th>
                            <th>Місце</th>
                            <th>Кількість учасників</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($row = $result->fetch_assoc()): ?>
                            <tr>
                                <td><?= $row['id'] ?></td>
                                <td><?= htmlspecialchars($row['title']) ?></td>
                                <td><?= $row['event_date'] ?></td>
                                <td><?= htmlspecialchars($row['location']) ?></td>
                                <td><?= $row['participants'] ?></td>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        <?php else: ?>
            <div class="empty-state">
                <p>Подій поки що немає.</p>
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
    max-width: 1000px;
    margin: 0 auto;
    background: white;
    border-radius: 4px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    border: 1px solid #e9ecef;
    overflow: hidden;
}

h2 {
    color: #343a40;
    font-size: 20px;
    font-weight: 500;
    padding: 24px;
    border-bottom: 1px solid #e9ecef;
    background: #f8f9fa;
}

.table-container {
    overflow-x: auto;
}

.events-table {
    width: 100%;
    border-collapse: collapse;
}

.events-table th {
    background: #f8f9fa;
    color: #495057;
    font-weight: 500;
    font-size: 14px;
    padding: 16px 12px;
    text-align: left;
    border-bottom: 1px solid #dee2e6;
    white-space: nowrap;
}

.events-table td {
    padding: 16px 12px;
    border-bottom: 1px solid #f1f3f4;
    color: #495057;
    font-size: 14px;
    vertical-align: middle;
}

.events-table tbody tr:hover {
    background: #f8f9fa;
}

.events-table tbody tr:last-child td {
    border-bottom: none;
}

.events-table th:first-child,
.events-table td:first-child {
    color: #6c757d;
    font-size: 13px;
    width: 60px;
}

.empty-state {
    padding: 48px 24px;
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
        border-radius: 0;
        border-left: none;
        border-right: none;
    }
    
    h2 {
        padding: 20px 16px;
        font-size: 18px;
    }
    
    .events-table th,
    .events-table td {
        padding: 12px 8px;
        font-size: 13px;
    }
    
    .empty-state {
        padding: 40px 16px;
    }
}

@media (max-width: 480px) {
    .events-table th:first-child,
    .events-table td:first-child {
        display: none;
    }
    
    .events-table th,
    .events-table td {
        padding: 10px 6px;
        font-size: 12px;
    }
}
</style>