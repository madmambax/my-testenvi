#"""
#Tento příklad potřebuje robotframework-requests balíček
#instalace:
#pip install robotframework-requests
#CVIČENÍ 2: vytvořte další testy, 1 pozitivní a 1 negativní test



*** Settings ***
Library	 RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes
#Library	 Collections


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***

registrace (fyzická osoba - adresa)
    API Comunication   {"targetid":"","kurz":"2","name":"Daniel","surname":"Vašeg","email":"dan.vasek125555@seznam.cz","phone":"777454333","person":"fyz","address":"Sázavská 5 - Brno1","count":"1","comment":null,"souhlas":true}  200

registrace (právnická osoba ICO)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"aaabb.bbbbbb@seznam.cz","phone":"777454111","person":"pra","ico":"25596641","count":"1","comment":null,"souhlas":true}  200

registrace dlouhé jménoo víe jak 30 znaků
    API Comunication   {"targetid":"","kurz":"3","name":"Janaaaaaaaaaaaaaaaaaaaaaaaaaaann","surname":"Novak","email":"dan.vasek123@seznam.cz","phone":"724814555","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   200

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"dan.vasek123@seznam.cz","phone":"777454111","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

registrace - chybný formát json (kurz není)
    API Comunication   {"targetid":"","name":"Jan","surname":"Novak","email":"dan.vasek4444@seznam.cz","phone":"777454111","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

registrace volby telefonu (prázdný)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"dan.vasek123@seznam.cz","phone":"","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

registrace chybny telefon (moc dlouhy)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"dan.vasek123@seznam.cz","phone":"666888999666333","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

registrace chybny email (tohleneniemail.cz)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"dan.vasek123.cz","phone":"724814555","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

registrace speciální znaky (mezera v telefonu)
    API Comunication   {"targetid":"","kurz":"3","name":"Jan","surname":"Novak4","email":"dan.vasek555@seznam.cz","phone":"724814555 ","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}
    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String
    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Log                 ${resp.json()}
    Status Should Be    ${error_resp}


API Comunicaication Post on Session
    [Arguments]       ${json}     ${error_resp}
   #převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String
  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8
  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}
  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything
  Status Should Be    ${error_resp}

