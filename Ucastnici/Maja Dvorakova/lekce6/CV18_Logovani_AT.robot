"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

"""


*** Settings ***
Library	 RequestsLibrary
Library	 Collections
Library  String
Library  DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php


#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***

test demo
    Ukazka Logovani


registrace ok
    API Comunicaication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace chyba
    API Comunicaication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace chybny telefon (moc dlouhy)
    API Comunicaication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"60812312300000000000000","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   400

chybny format JSON (bez kurzu)
    API Comunicaication   {"targetid":"","kurz":,"name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  400

Háčky a carky - problém s českými znaky v Request Library
    API Comunicaication  {"targetid":"","kurz":"3","name":"Jan+ěščřžýáíéúů","surname":"Novák","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":true}  200





*** Keywords ***


Ukazka logovani
# úrovně logování: TRACE, DEBUG, INFO (default), HTML, WARN, and ERROR
  Log                Log na úrovní ERROR    ERROR
  Log                Log na úrovní WARN     WARN
  Log                Log na úrovní HTML     HTML
  Log                Log na úrovní INFO     INFO
  Log                Log na úrovní DEBUG    DEBUG
  Log                Log na úrovní TRACE    TRACE


  @{list1} =      Create List    first    second    third
  Log             ${list1}[1]
#  Log             @{list1}  #nefunguje
  Log Many  @{list1}

  &{Dict} =	    Create Dictionary	key=value	foo=bar
  Log Many        &{Dict}         #zalogování celeho slovníku (Dictionary)
  Log Many        ${Dict.key}     #zalogování kokrétní hodnoty ze slovníku (Dictionary)



API Comunicaication
    [Arguments]       ${json}     ${error_resp}

  Log                Argumenty json=${json}, error_resp=${error_resp}   TRACE


  Log                Převod na UTF-8: ${json}   level=INFO
  Log                Převod na UTF-8: ${json}   level=DEBUG   formatter=repr


  #převedení do UTF-8
  ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String
  Debug

  Log                Převod na UTF-8: ${json_utf8}   level=INFO
  Log                Převod na UTF-8: ${json_utf8}   level=DEBUG   formatter=repr

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp} =           Post on Session    apilogin       ${app}          data=${json_utf8}  headers=${header}       expected_status=Anything
  Log                 odpověď: ${resp}   level=debug    formatter=repr

  Status Should Be    ${error_resp}

