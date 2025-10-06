
symbols = ['a', '+', 'b', '*', '+', '*', 'c', '+']  

plus_count = 0
star_count = 0

for s in symbols:
    if s == '+':
        plus_count += 1
    elif s == '*':
        star_count += 1

print(f'Кількість "+" = {plus_count}')
print(f'Кількість "*" = {star_count}')
