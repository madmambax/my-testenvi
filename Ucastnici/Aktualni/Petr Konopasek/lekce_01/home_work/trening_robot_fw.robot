*** Settings ***
Library    OperatingSystem

*** Variables ***
${first_txt}         robot.txt
${second_txt}        framework.txt

*** Test Cases ***

Prvni test pozitivní

    create file                 ${first_txt}        Robot Framework is open source and supported by Robot Framework Foundation
    create file                 ${second_txt}       There is a huge community of contributors around the tool.
    ${res_1} =  get file        ${first_txt}
    ${res_2} =  get file        ${second_txt}
    log file                    ${first_txt}
    log file                    ${second_txt}
    should contain              ${res1}             Robot Framework is open source and supported by Robot Framework Foundation
    should contain              ${res2}             There is a huge community of contributors around the tool.

Druhý test pozitvní
    file should exist           ${first_txt}
    file should exist           ${second_txt}
    file should not be empty    ${first_txt}
    file should not be empty    ${second_txt}

Třetí test negativní - robot.txt

    remove file                 ${first_txt}
    file should not exist       ${first_txt}
    Log To Console                                  File robot.txt has bean removed

Čtvrtý test negativní - framework.txt
    remove file                 ${second_txt}
    file should not exist       ${second_txt}
    Log To Console                                  File framework.txt has bean removed





*** Comments ***


Zapisuji jak robot pracuje krok co krok to řádek :-)

 2.ř. - načtení knihovny  -  OperatingSystem
 4.ř. - Vytvořím Variables
 5.ř. - ${first_txt}         robot.txt
 6.ř. - ${second_txt}        framework.txt

Prvni test pozitivní

12.ř. - Vytvoří soubor s názvem greece.txt obsahující text: Robot Framework is open source and supported by Robot Framework Foundation
13.ř. - Vytvoří soubor s názvem greece.txt obsahující text: There is a huge community of contributors around the tool.
14.ř. - Pomoci  >>> get file <<< uložím obsah textu v soub. robot.txt do proměnné ${res_1}
15.ř. - Pomoci  >>> get file <<< uložím obsah textu v soub. framework.txt do proměnné ${res_2}
16.ř. - Zaloguje ${first_txt}
17.ř. - Zaloguje ${second_txt}
18.ř. - Porovoná obsah robot.txt , zda obsahuje spravný text.
19.ř. - Porovoná obsah framework.txt , zda obsahuje spravný text.

Druhý test pozitvní

22.ř. - Ověří existenci souboru soubor robot.txt
23.ř. - Ověří existenci souboru soubor framework.txt
24.ř. - ověři zda soubor robot.txt není prazdný
25.ř. - ověři zda soubor framework.txt není prazdný

Třetí test negativní - greece.txt

29.ř. - odstraní soubor robot.txt
30.ř. - Ověří,že soubor nexistuje
31.ř. - Vypíše zprávu do konsole o tom, že soubor byl odstraněn.

Třetí test negativní -  framework.txt

34.ř. - odstraní soubor framework.txt
35.ř. - Ověří,že soubor nexistuje
36.ř. - Vypíše zprávu do konsole o tom, že soubor byl odstraněn.
