from math import sin, cos

# Анонімна функція wel
wel = lambda x: x ** 2 + 1

# Введення даних
a = float(input("Введіть a: "))
b = float(input("Введіть b: "))

# Обчислення результату
result = (wel(sin(a) * 1.57) - wel(cos(a) ** 2 * b ** 2) + wel(a - 1 * b) + wel((b - a) * a)) / abs(a * b)

print("Результат:", result)