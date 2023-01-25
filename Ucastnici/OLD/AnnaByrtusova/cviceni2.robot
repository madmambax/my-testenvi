*** Settings ***
Documentation

*** Variables ***

${pozdrav}=   Hello
@{auta}=    BMW Skoda Opel
@{seznam}=  Chrome    Firefox   Edge
#zde pisu promenne ktere pouzivam ve vice testech
#${SCALAR}            13
#@{LIST}              one  two  three  four
#&{DICTIONARY}        login=novak    password=saddvv12

*** Test Cases ***

Scalarni promenne

    ${pozdrav}=   Set Variable      Hello
    Log to Console     ${pozdrav}

Seznamy
    @{auta}=   Create List    BMW   Skoda   Opel
    Log To Console       ${auta}[1]
    Log Many            @{auta}


Slovniky
    &{ceny}=    Create Dictionary    jablko=49     maliny=45
    Log To Console    ${ceny.maliny}
    Log Many            &{ceny}

Promenne prostredi
    Log To Console      %{USERNAME}
    Log To Console      %{OS}



Test pro vypsani všech položek seznamu do logu
    @{seznam} =     Create List    Chrome    Firefox   Edge
    Log Many        @{seznam}

#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
    Log To Console    ${seznam}[1]

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    Should Contain    ${seznam}[0]  Chrome

#nezapomen ze prvni polozka seznamu je 0


*** Keywords ***

Prvni
    Log To Console    Cus

Pozdrav
    [Arguments]     ${jmeno}
    Log To Console    Ahoj ${jmeno}

Secti
    [Arguments]     ${x}   ${y}
    ${v}=           Evaluate    ${x}    +    ${y}
    [return]        ${v}


*** Test Cases ***

Ukazka pouziti klicoveho slova
    Log     Ahoj
    Prvni


KS s parametrem
    Pozdrav     Karle