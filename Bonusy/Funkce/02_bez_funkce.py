#!/usr/bin/env python

#
# ZJEDNODUSENI CODU  + ZAPSANI ALGORITMU
#

# Úkolem je zjisti nejvyší číslo u 5 seznamů

#První seznam
aList1 = [28, 6, 8, 32, 24, 12, 2]
largest1 = aList1[0]

for x in aList1:
    if x > largest1:
        largest1 = x


#Druhý seznam
aList2 = [1, 8, 33, 2, 44, 112, 12]
largest2 = aList1[0]

for x in aList2:
    if x > largest2:
        largest2 = x

#Třetí seznam
aList3 = [8, 26, 18, 2, 24, 12, 122]
largest3 = aList3[0]

for x in aList3:
    if x > largest3:
        largest3 = x


#Čtvrtý seznam
aList4 = [128, 6, 8,2, 124, 10, 21]
largest4 = aList4[0]

for x in aList4:
    if x > largest4:
        largest4 = x


#Pátý seznam
aList5 = [1, 2, 3, 4, 5, 6, 7]
largest5 = aList5[0]

for x in aList5:
    if x > largest5:
        largest5 = x


print("Nejvyšší číslo 1. seznamu je: ", largest1)
print("Nejvyšší číslo 2. seznamu je: ", largest2)
print("Nejvyšší číslo 3. seznamu je: ", largest3)
print("Nejvyšší číslo 4. seznamu je: ", largest4)
print("Nejvyšší číslo 5. seznamu je: ", largest5)