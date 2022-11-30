*** Variables ***
${mesto}  Brno

*** Test Cases ***

Priklad pouziti podminky

   #pozor pokud používáte podmínku pro porovnání textu, text musí být v uvozovkách
   IF    "${mesto}" == "Brno"
       Log To Console    podmína platí
   ELSE
       Log To Console    podmínka NEPLATÍ
   END

Priklad pouziti podminky s true
   IF    ${True}
       Log To Console    podmína platí
   ELSE
       Log To Console    podmínka NEPLATÍ
   END


Priklad pouziti podminky nerovnost 2 textu
   IF    "cat" != "dog"
        Log    This line IS executed.
   END
   IF    "cat" == "dog"
        Log    This line is NOT executed.
   END


elese if ukázka
     IF    1 == 1
            Log    This line IS executed.
     ELSE IF    2 == 2
            Log    This line is NOT executed.
     ELSE
            Log    This line is NOT executed.
     END