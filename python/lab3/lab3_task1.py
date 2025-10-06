
arr = [3, -1, 0, 7, -5, 2, -8] 


positive = []  
negative = []  

for num in arr:
    if num > 0:
        positive.append(num)
    elif num < 0:
        negative.append(num)

print("Додатні елементи:", positive)
print("Від'ємні елементи:", negative)
