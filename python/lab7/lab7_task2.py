def remove_duplicates(lst):
    result = []
    for item in lst:
        if item not in result:
            result.append(item)
    return result

numbers = [1, 2, 3, 2, 4, 1, 5, 3, 6]
print("Оригінальний список:", numbers)
print("Без дублікатів:", remove_duplicates(numbers))

words = ['apple', 'banana', 'apple', 'orange', 'banana', 'grape']
print("\nОригінальний список:", words)
print("Без дублікатів:", remove_duplicates(words))