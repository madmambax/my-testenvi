#!/usr/bin/env python

#
# ZJEDNODUSENI CODU  + ZAPSANI ALGORITMU
#

# Úkolem je zjisti nejvyší číslo u 5 seznamů - tentokrát ale chytře s funkcí

# Vytvořím funkci pro nalezení nejvyšího čísla ze seznamu, funkce má jeden parametr
def find_largest(list):
  largest = list[0]
  for x in list:
      if x > largest:
          largest = x
  return largest


largest1 = find_largest ([28, 6, 8, 32, 24, 12, 2])
largest2 = find_largest ([1, 8, 33, 2, 44, 112, 12])
largest3 = find_largest ([8, 26, 18, 2, 24, 12, 122])
largest4 = find_largest ([128, 6, 8,2, 124, 10, 21])
largest5 = find_largest ([1, 2, 3, 4, 5, 6, 7])

print("Nejvyšší číslo 1. seznamu je: ", largest1)
print("Nejvyšší číslo 2. seznamu je: ", largest2)
print("Nejvyšší číslo 3. seznamu je: ", largest3)
print("Nejvyšší číslo 4. seznamu je: ", largest4)
print("Nejvyšší číslo 5. seznamu je: ", largest5)


# s funkci find_largest, je celý kód ohodně jednoduší a přehlednější, také všechny změny se budou dělat na jednom místě