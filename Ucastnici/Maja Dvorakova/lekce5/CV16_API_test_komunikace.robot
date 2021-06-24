"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

"""


*** Settings ***
Library	 RequestsLibrary
Library	 Collections
Library  String


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***


registrace ok
    API Comunicaication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace chyba
    API Comunicaication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace bez emailu     {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  400





#spavny format JSON
#    API Comunicaication  {"targetid":"","kurz":"2","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":false}  200




#chybny format JSON (bez kurzu)
#    API Comunicaication Post Error  {"targetid":"","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Údolni 21, Brno","ico":"1","count":"1","comment":null,"souhlas":false}    HTTPError: 400 Client Error:*
#
#
#chybny telefon (moc dlouhy)
## Internal server error je chyba, správně se má očekávat odmítnití ze strny serveru 400
##    API comunicaication post error  {"targetid":"","kurz":"2","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"77712312300000000000","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":false}   HTTPError: 500 Server Error:*
#    API Comunicaication Post Error  {"targetid":"","kurz":"2","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"77712312300000000000","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":false}   HTTPError: 400 Client Error:*
#
#
#chybne cislo kurzu
#    API Comunicaication  {"targetid":"","kurz":"5","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":false}  400
#
#
#nevyplneny kurz
#    API Comunicaication Post Error  {"targetid":"","kurz":"","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":false}  HTTPError: 500 Server Error*
#
#
##Háčky a carky - problém s českými znaky v Request Library
###    ${str} =      Set Variable     {"targetid":"","kurz":"3","name":"DalsiJanž","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":"nic","souhlas":true}
###    ${JSON} =	Encode String To Bytes	${str}	UTF-8
###    API comunicaication          ${JSON}    200
##    API comunicaication  {"targetid":"","kurz":"3","name":"Janž","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":"nic","souhlas":true}  200
#






*** Keywords ***




API Comunicaication
    [Arguments]         ${json}    ${error_resp}

   # zapis jako DATA
   ${json_string}=    catenate    ${json}

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp} =    Post on Session    apilogin  ${app}    data=${json_string}  headers=${header}       expected_status=Anything

  Status Should Be    ${error_resp}


















#API Comunicaication
#  [Arguments]  ${json}  ${resp_status_code}
#
#   # zapis jako DATA
#   ${json_string}=    catenate    ${json}
#
#   # zapis jako JSON
##   ${json_string}=    Create Dictionary  kurz=1  name=Jan  surname=Novak  email=jan.novak@abc.cz  phone=608123123  person=fyz  address=Brno  ico=234563234  count=1  comment=${EMPTY}  souhlas=${TRUE}
#
#  #vytoření hlavičky (header) zprávy
#  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8
#
#  #vytvoření spojení (session)
#  CreateSession       apilogin            ${url}
#
#  # odeslání zprávy a uložení odpovědi do ${resp}
#  ${resp} =           Post on Session     apilogin   ${app}   data=${json_string}   headers=${header}
#  Log	              Responce: @{resp}
##  Log                  ${resp.json()}[response]
##  Log                  ${resp.json()}[name]
##  Should Be Equal
#
#
#  Status Should Be    ${resp_status_code}
#
#
#
#API Comunicaication Post Error
#  [Arguments]  ${json}  ${error_string}
#
#
#  ${json_string}=     catenate    ${json}
#
#  #vytoření hlavičky (header) zprávy
#  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8
#
#  #vytvoření spojení (session)
#  CreateSession       apilogin            ${url}
#
#  Run Keyword And Expect Error   ${error_string}   Post on Session   apilogin   ${app}   data=${json_string}   headers=${header}
#
#
