*** Settings ***
Library     OperatingSystem


*** Variables ***
${VypisAdresare}		        dir
${VypisAdresareNeex}		    dir x
${IPconfig}		                ipconfig
@{Hodnota1}                     Directory of
@{Hodnota2}                     File Not Found
@{Hodnota3}                     Windows IP Configuration        Ethernet adapter Ethernet:      Connection-specific DNS Suffix  . : cz.csw.local        Link-local IPv6 Address . . . . . : fe80::a914:2ab:19fc:9e7d%2      IPv4 Address. . . . . . . . . . . : 172.17.2.133        Subnet Mask . . . . . . . . . . . : 255.255.248.0       Default Gateway . . . . . . . . . : 172.17.1.1

*** Test Cases ***

Test pozitivni upraveno z předchozího cvičení
    Spusť příkaz        ${VypisAdresare}            @{Hodnota1}

Test negativni upraveno z předchozího cvičení
    Spusť příkaz        ${VypisAdresareNeex}        @{Hodnota2}

Nový test pozitivní
    Spusť příkaz        ${IPconfig}                 @{Hodnota3}

*** Keywords ***
Spusť příkaz
    [Arguments]                 ${Prikaz}           @{KontrolniHodnoty}
    Log To Console              ${\n}Bude spuštěn příkaz: ${Prikaz}
    ${output} =                 run                 ${Prikaz}
    FOR    ${KontrolniHodnota}    IN   @{KontrolniHodnoty}
        Log    ${KontrolniHodnota}
        Log To Console              Kontrola - výstup obsahuje text: ${KontrolniHodnota}
        Should Contain              ${output}           ${KontrolniHodnota}
        Log                         Výstup: ${output}
    END
   # Log To Console              Kontrola - výstup obsahuje text: ${KontrolniHodnota}
   # Should Contain              ${output}           ${KontrolniHodnota}
   # Log                         Výstup: ${output}


