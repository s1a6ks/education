matrix = [
    [1.2, 3.4, 5.6, 7.8, 9.0],
    [2.1, 4.3, 6.5, 8.7, 0.9],
    [9.8, 7.6, 5.4, 3.2, 1.0]
]

print("Оригінальна матриця:")
for row in matrix:
    print(row)

matrix[0], matrix[2] = matrix[2], matrix[0]

print("\nПісля обміну 1-го та 3-го рядків:")
for row in matrix:
    print(row)

col_index = 2  
third_column = [row[col_index] for row in matrix]

third_column.sort(reverse=True)

for i in range(len(matrix)):
    matrix[i][col_index] = third_column[i]

print("\nПісля впорядкування 3-го стовпця по спаданню:")
for row in matrix:
    print(row)
