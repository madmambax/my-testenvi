"""
Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests
"""

*** Settings ***
Library	 RequestsLibrary
Library	 Collections
Library   String


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php

#${json}   - JSON formát
# {
#   "targetid":"",
#   "kurz":"2",         číslo kurzu - 1 (Jak se stát testerem), 2 (Testování v agilním prostředí), 3 (Základy testování softwaru)
#   "name":"Josef",                       jméno účastníka
#   "surname":"Papousek",                 přijmení účastníka
#   "email":"pepa.papouch@seznam.cz",     email na účastníka
#   "phone":"723234897",                  telefon na účastníka
#   "person":"fyz",                       rozlišení fyzická nebo právnická osoba
#   "address":"Ostava",                   adresa na účastníka (používá se v případě fyzické osoby)
#   "ico":"234563234",                    identifikační číslo právnického subjektu (používá se v případě právnické osoby)
#   "count":"5",                          počet účastníků
#   "comment":null,                       komentář
#   "souhlas":true                        souhlas se zpracováním - true/false
# }


*** Test Cases ***

bonus test
   GET     https://www.seznam.cz
   Status Should Be    200

registrace úspěšná  #200
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"gabriela.zakova@seznam.cz","phone":"604904589","person":"fyz","address":"Praha","ico":"123456789","count":"5","comment":null,"souhlas":false}  200

registrace nevyplněný kurz  #500
   API Comunication   {"targetid":"","kurz":"","name":"Gabriela","surname":"Zakova","email":"gabriela.zakova@seznam.cz","phone":"604904589","person":"fyz","address":"Praha","ico":"123456789","count":"5","comment":null,"souhlas":false}   500

registrace nevyplněné jméno  #500
   API Comunication   {"targetid":"","kurz":"3","name":"","surname":"Zakova","email":"gabriela.zakova@seznam.cz","phone":"604904589","person":"fyz","address":"Praha","ico":"123456789","count":"5","comment":null,"souhlas":false}  500

registrace nevyplněné přijmení  #500
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"","email":"gabriela.zakova@seznam.cz","phone":"604904589","person":"fyz","address":"Praha","ico":"123456789","count":"5","comment":null,"souhlas":false}  500

registrace nevyplněná osoba  #500
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"gabriela.zakova@seznam.cz","phone":"604904589","person":"","address":"Praha","ico":"123456789","count":"5","comment":null,"souhlas":false}  500

registrace nevyplněný email  #500
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"","phone":"604904589","person":"fyz","address":"Praha","ico":"123456789","count":"5","comment":null,"souhlas":false}  500

registrace nevyplněný telefon  #500
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"gabriela.zakova@seznam.cz","phone":"","person":"fyz","address":"Praha","ico":"123456789","count":"5","comment":null,"souhlas":false}  500

registrace nevyplněný počet osob  #500
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"gabriela.zakova@seznam.cz","phone":"604904589","person":"fyz","address":"Praha","ico":"123456789","count":"","comment":null,"souhlas":false}  500

registrace nevyplněný komentář  #200
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"gabriela.zakova@seznam.cz","phone":"604904589","person":"fyz","address":"Praha","ico":"123456789","count":"5","comment":"","souhlas":false}  200

registrace nezaškrtnutý souhlas  #200
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"gabriela.zakova@seznam.cz","phone":"604904589","person":"fyz","address":"Praha","ico":"123456789","count":"5","comment":null,"souhlas":""}  200

registrace nevyplněná adresa  #500
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"gabriela.zakova@seznam.cz","phone":"604904589","person":"fyz","address":"","ico":"123456789","count":"5","comment":null,"souhlas":false}  500

registrace nevyplněné IČO  #200
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"gabriela.zakova@seznam.cz","phone":"604904589","person":"fyz","address":"Praha","ico":"","count":"5","comment":null,"souhlas":false}  200

registrace příliš dlouhý telefon  #500
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"gabriela.zakova@seznam.cz","phone":"600443897501284750808379904589","person":"fyz","address":"Praha","ico":"123456789","count":"5","comment":null,"souhlas":false}   500

registrace příliš dlouhý počet osob  #500
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"gabriela.zakova@seznam.cz","phone":"604904589","person":"fyz","address":"Praha","ico":"123456789","count":"1000000000000000000000000","comment":null,"souhlas":false}  500

registrace email bez zavináče  #500
   API Comunication   {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"gabriela.zakovaseznam.cz","phone":"604904589","person":"fyz","address":"Praha","ico":"123456789","count":"5","comment":null,"souhlas":false}  500

chybny format JSON (bez targetid)  #200
    API Comunication   {"kurz":"3","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

chybny format JSON (beze jména)  #500
    API Comunication   {"targetid":"","kurz":"3","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Háčky a čárky - problém s českými znaky v Request Library  #200
    API Comunication  {"targetid":"","kurz":"3","name":"Gabriela","surname":"Žáková","email":"gabriela.zakova@seznam.cz","phone":"604904589","person":"fyz","address":"Hradec Králové","ico":"123456789","count":"5","comment":"změna adresy","souhlas":false}  200

Háčky a čárky - v emailu  #500
    API Comunication  {"targetid":"","kurz":"3","name":"Gabriela","surname":"Zakova","email":"gabriela.žáková@seznam.cz","phone":"604904589","person":"fyz","address":"Praha","ico":"123456789","count":"5","comment":null,"souhlas":false}  500
  

*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}

   #převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp} =    Post on Session    apilogin  ${app}    data=${json_utf8}  headers=${header}       expected_status=Anything

  Status Should Be    ${error_resp}
