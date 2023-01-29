
*** Settings ***
Library    String
Library    OperatingSystem

*** Variables ***


*** Test Cases ***

Pozitivní test 1
    ${result} =      Run  help dir
    Log   ${result}
    Should Contain   ${result}      Display the list of currently

Pozitivní test 2
    ${result} =      Run  python --version
    Log   ${result}
    Should Contain   ${result}      Python 2.7.16

Negativní test 1
    ${result} =      Run  help ahoj
    Log   ${result}
    Should Contain   ${result}  no help topics match `ahoj'

Negativní test 2
    ${result} =      Run  open /Users/oldrichlenhart/Video/Breeze_170815192130_001.JPG
    Log   ${result}
    Should Contain   ${result}  does not exist


#Obsah složky - NEFUNGUJE
#    ${result} =      Run  cd /Users/oldrichlenhart/Documents/TESTER/Bash.skripty
#    Log   ${result}
#    Should Contain   ${result}  ZalohaNaSd.txt
