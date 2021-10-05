#!/usr/bin/env python
# Ukázka využití funkce při programování

# definujeme novou funkci pro sčítání
def add(x,y):
    return x+y

#zavoláme funkci s parametry 5 a 7
res = add(5,7)


### Úkol: zde přidejte novou funkci pro násobení !!! ###
#?
#funkce pro nasobeni
def multiply(x,y,z):
    return x*y*z

#volani funkce nasobeni
vysledek = multiply(3,3,3)


#vypíšemy výsledek
print(res)
print("Vysledek nasobeni je:",vysledek)
