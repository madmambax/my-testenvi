# Práce s RobotFrameworkem

*** Settings ***
Library     OperatingSystem


# Sekce se označují pomocí 3 hvězdiček názvu a opět 3 hvězdičky jako
# Příklady:
#           *** Settings ***
#           *** Variables ***
#           *** Test Cases ***
#           *** Keywords ***
#           *** Comments ***


*** Variables ***
${Greet}    Hello
${Name}     Daniel

*** Test Cases ***

První test negativní
# Každy krok testu se zapisuje do "tabulky" která se odděluje pomocí tabelátorů nebo alespoň 2 mezer
    ${res} =        run     dir adr_ktery_neexistuje
    Log             ${res}
    Log To Console             ${NAZEV_PROMENNE}
    Should Contain  ${res}  Specifies that you want to change to the parent directory


*** Keywords ***
#použijeme později, slouží k definování vlastních klíčových slov


*** Comments ***
#sekce obsahující komentáře a tedy část kterou Robot Framework ignoruje