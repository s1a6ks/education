from math import tan, cos, sin, pi

a = float(input("Введіть a: "))

if a < -2*pi/3:
    G = tan(a) - cos(a)
elif a < -pi/3:
    G = cos(a) - sin(a)
elif a < pi/3:
    G = 1/tan(a) - sin(a)
else:
    G = abs(a)

print("G(a) =", G)