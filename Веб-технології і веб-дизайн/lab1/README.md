# Лабораторна робота №1

**Тема:** Налаштування середовища PHP розробки
**Виконавець:** Горецький Максим  
**Група:** KNms1-B23  
**Дата виконання:** 06.04.2025  
**Варіант:** 6

---

## Завдання 1

**Умова:**  
Розрахунок часу виконання коду для обчислення добутку чисел від 1 до 10.

```php
<?php
$start = microtime(true); 

$product = 1;
for ($i = 1; $i <= 10; $i++) {
    $product *= $i;
}

$end = microtime(true); 
$executionTime = $end - $start;

echo "Добуток чисел від 1 до 10: $product <br>";
echo "Час виконання скрипту: " . number_format($executionTime, 10) . " секунд";
?>
```

[Перейти до коду](lab1_task1.php)

**Результат:**

![Скріншот Завдання 1](./screenshots/task1.png)

---

## Завдання 2

**Умова:**  
Виведення залишку від ділення числа (35 на 4).

```php
<?php
$dividend = 35;
$divisor = 4;
$remainder = $dividend % $divisor;

echo "Залишок від ділення $dividend на $divisor: $remainder";
?>
```

[Перейти до коду](lab1_task2.php)

**Результат:**

![Скріншот Завдання 2](./screenshots/task2.png)
