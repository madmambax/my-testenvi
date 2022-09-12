*** Test Cases ***

Prvni test
    Log     Ahoj


Druhý test
    Log                     ahoj

    Should be Equal         ahoj                ahoj
    Should Contain          ahoj Dobrý den      ahoj Dobrý den
    Should be True          10 < 11