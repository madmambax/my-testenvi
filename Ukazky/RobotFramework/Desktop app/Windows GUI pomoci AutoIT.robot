#pip install robotframework-autoitlibrary

*** Settings ***
Library  AutoItLibrary

*** Variables ***

#${Notepad}  C:\\Windows\\system32\\notepad.exe
${Notepad}  notepad.exe
${calc}     calc.exe

*** Test Cases ***

Informace
    ${verze} =  Get Version
    Log To Console    ${\n}verze: ${verze}

    ${admin} =  Is Admin
    Log To Console    ${\n}admin: ${admin}

Spusteni Notepadu
    Run              ${Notepad}
    Win Wait Active  Bez názvu – Poznámkový blok
    Send             Tohle je ukázka psaní do Notepadu


Kalkulacka
    Run   ${calc}
    Wait For Active Window   Kalkulačka

#    Click Buttons   4 1 + 1 =
#    Win Wait   Kalkulačka   42
#    ${Ans} =   Get Answer
#    Should Be Equal As Numbers   ${Ans}   42





