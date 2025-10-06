start = 1.0
end = 8.0
step = 0.4

print(f"{'Число':>6} | {'Квадрат':>8}")
print("-" * 18)

x = start
while x <= end + 1e-9:  
    print(f"{x:6.2f} | {x**2:8.2f}")
    x += step
