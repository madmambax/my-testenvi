*** Settings ***
Library  RequestsLibrary     #klíčová slova pro práci s API
Library	Collections          #je třeba pro klíčové slovo: Dictionary Should Contain Key

*** Variables ***
${url}    http://testovani.kitner.cz/
${app}    login_app/userauth.php
#&{d} =    Create Dictionary     prvni=hodnota   druhy=hodnota

*** Test Cases ***



API test - TestLogin
#  Log To Console  ${d.prvni}

  # vytoření JSON zprávy
  ${json}=  catenate  {"username":"novak","password":"tajnenovak"}

  # vytoření hlavičky (header) zprávy
  &{header}=   Create Dictionary   Content-Type=application/json

  # vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp} =  Post on Session  apilogin  ${app}  data=${json}  headers=${header}

  # Přístup k datům v odpovědi (Response) - výstup do konzole
  Log To Console  \nData v odpovědi (Response):
  Log To Console  \$\{resp\}:\t\t ${resp}
  Log To Console  \$\{resp.status_code\}:\t ${resp.status_code}
  Log To Console  \$\{resp.json()\}:\t ${resp.json()}
  Log To Console  \$\{resp.content\}:\t ${resp.content}
  Log To Console  \$\{resp.headers\}:\t ${resp.headers}
  Log To Console  \$\{resp.ok\}:\t ${resp.ok}
  Log To Console  \$\{resp.url\}:\t ${resp.url}

  # Přístup k datům v odpovědi (Response) - výstup do logu
  Log  ${resp}
  Log  ${resp.status_code}
  Log  ${resp.json()}
  Log  ${resp.content}

  # vyhodnocení ruzných částí odpovědi

  Status Should Be                  200                           # status code na request (dotaz)
  Should Be Equal As Strings        200  ${resp.status_code}      # status code na request (dotaz) - verze 2
  Should Be Equal As Strings        {'response': '200', 'reason': 'correct', 'agent': []}  ${resp.json()}  #celý JSON
  Dictionary Should Contain Key	    ${resp.json()}      response          # klíč v JSONu
  Dictionary Should Contain Item    ${resp.json()}      response    200   #klíč s konkrétní hodnotou  v JSONu
