"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

"""


*** Settings ***
Library	Collections
Library	RequestsLibrary


*** Variables ***
${url}		        http://testovani.kitner.cz/


*** Test Cases ***

spávný format JSON
    API comunicaication  {"targetid":"","kurz":"2","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":false}  200


chybny format JSON (bez kurzu)
    API comunicaication post error  {"targetid":"","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Údolni 21, Brno","ico":"1","count":"1","comment":null,"souhlas":false}    HTTPError: 400 Client Error:*


chybný telefon (moc dlouhy)
    API comunicaication  {"targetid":"","kurz":"2","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"77712312300000000000","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":false}   500


chybne cislo kurzu
    API comunicaication  {"targetid":"","kurz":"5","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":null,"souhlas":false}  400


Hacky a carky
    API comunicaication  {"targetid":"","kurz":"3","name":"Janěščřžýáíé","surname":"Novák","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brnoěščřžýáíé","ico":"1","count":"1","comment":"nic","souhlas":true}  200


# POST Request : url=http://testovani.kitner.cz/regkurz/formsave.php
# path_url=/regkurz/formsave.php
# headers={'User-Agent': 'python-requests/2.25.1', 'Accept-Encoding': 'gzip, deflate', 'Accept': '*/*', 'Connection': 'keep-alive', 'Content-Type': 'application/json', 'Content-Length': '206'}
# body={"targetid":"","kurz":"2","name":"Jan787878","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Údolní 21, Brno","ico":"1","count":"1","comment":null,"souhlas":false}

# POST Response : url=http://testovani.kitner.cz/regkurz/formsave.php
# status=400, reason=Bad Request
# headers={'Server': 'nginx/1.14.2', 'Date': 'Mon, 14 Jun 2021 12:51:43 GMT', 'Content-Type': 'text/html; charset=iso-8859-1', 'Content-Length': '311', 'Connection': 'keep-alive'}
# body=<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
#<html><head>
#<title>400 Bad Request</title>
#</head><body>
#<h1>Bad Request</h1>
#<p>Your browser sent a request that this server could not understand.<br />
#</p>
#<hr>
#<address>Apache/2.4.38 (Debian) Server at testovani.kitner.cz Port 80</address>
#</body></html>




*** Keywords ***

API comunicaication
  [Arguments]  ${json}  ${resp_status_code}


  ${json_string}=     catenate    ${json}

   #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp} =           Post on Session     apilogin    /regkurz/formsave.php  data=${json_string}  headers=${header}
   Log	               Responce: @{resp}

#  Should Be Equal As Strings	${resp.status_code}     ${resp_status_code}
  Status Should Be  ${resp_status_code}


API comunicaication post error
  [Arguments]  ${json}  ${error_string}


  ${json_string}=     catenate    ${json}

   #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  Run Keyword And Expect Error  HTTPError: 400 Client Error:*  Post on Session     apilogin    /regkurz/formsave.php  data=${json_string}  headers=${header}

