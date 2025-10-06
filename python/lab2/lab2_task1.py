n = int(input("Введіть кількість членів прогресії n: "))
b = float(input("Введіть перший член b: "))
q = float(input("Введіть знаменник q: "))

geometric_progression = []

current = b
for i in range(n):
    geometric_progression.append(current)
    current *= q  

print("Члени геометричної прогресії:")
for term in geometric_progression:
    print(term)

