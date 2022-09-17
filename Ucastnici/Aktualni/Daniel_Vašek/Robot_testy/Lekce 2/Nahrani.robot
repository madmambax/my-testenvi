*** Test Cases ***

Prvni test
    Log to console    Ahoj                                      #vypíše Ahoj


Druhý test
    Log                     ahoj

    Should be Equal         9                   9               #je rovno (dva texty, čísla)
    Should Contain          ahoj Dobrý den      ahoj            #obsahuje daný text, tedy není nutná přesnost
    Should be True          10 < 11                             #je to pravda - to be true