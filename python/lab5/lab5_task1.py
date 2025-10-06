import random

with open("words.txt", "r", encoding="utf-8") as f:
    words = [line.strip() for line in f if line.strip()]  

num_words = random.randint(1, len(words))

sample = random.sample(words, num_words)  

print("Випадкова вибірка слів:")
for word in sample:
    print(word)
