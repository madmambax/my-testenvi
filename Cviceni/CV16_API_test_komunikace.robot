"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

"""


*** Settings ***
Library	 Collections
Library	 RequestsLibrary
Library  String


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php


*** Test Cases ***



spávný format JSON
    API Comunicaication  {"targetid":"","kurz":"2","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":false}  200


chybny format JSON (bez kurzu)
    API Comunicaication Post Error  {"targetid":"","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Údolni 21, Brno","ico":"1","count":"1","comment":null,"souhlas":false}    HTTPError: 400 Client Error:*


chybný telefon (moc dlouhy)
# Internal server error je chyba, správně se má očekávat odmítnití ze strny serveru 400
#    API comunicaication post error  {"targetid":"","kurz":"2","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"77712312300000000000","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":false}   HTTPError: 500 Server Error:*
    API Comunicaication Post Error  {"targetid":"","kurz":"2","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"77712312300000000000","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":false}   HTTPError: 400 Client Error:*


chybne cislo kurzu
    API Comunicaication  {"targetid":"","kurz":"5","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":false}  400



#Háčky a carky - problém s českými znaky v Request Library
##    ${str} =      Set Variable     {"targetid":"","kurz":"3","name":"DalsiJanž","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":"nic","souhlas":true}
##    ${JSON} =	Encode String To Bytes	${str}	UTF-8
##    API comunicaication          ${JSON}    200
#    API comunicaication  {"targetid":"","kurz":"3","name":"Janž","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":"nic","souhlas":true}  200







*** Keywords ***


API Comunicaication
  [Arguments]  ${json}  ${resp_status_code}


  ${json_string}=     catenate    ${json}

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp} =           Post on Session     apilogin   ${app}   data=${json_string}   headers=${header}
  Log	              Responce: @{resp}

  Status Should Be  ${resp_status_code}



API Comunicaication Post Error
  [Arguments]  ${json}  ${error_string}


  ${json_string}=     catenate    ${json}

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  Run Keyword And Expect Error   ${error_string}   Post on Session   apilogin   ${app}   data=${json_string}   headers=${header}


