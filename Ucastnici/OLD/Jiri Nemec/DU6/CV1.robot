*** Settings ***
Library  RequestsLibrary
Library  String

*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

*** Test Cases ***

registrace ok
    API Comunication   {"targetid":"","kurz":"2","name":"František","surname":"Dobrota","email":"frantisek.dobrota@blizka.cz","phone":"728279674","person":"fyz","address":"Blízká","ico":"337567231","count":"1","comment":"Těším se","souhlas":true}  200

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"František","surname":"Dobrota","email":"frantisek.dobrota@blizka.cz","phone":"728279674","person":"fyz","address":"Blízká","ico":"337567231","count":"1","comment":"Těším se","souhlas":true}  500

registrace volby telefonu (prázdný)
    API Comunication   {"targetid":"","kurz":"","name":"František","surname":"Dobrota","email":"frantisek.dobrota@blizka.cz","phone":"","person":"fyz","address":"Blízká","ico":"337567231","count":"1","comment":"Těším se","souhlas":true}  500

registrace chybny telefon (moc dlouhy)
    API Comunication   {"targetid":"","kurz":"2","name":"František","surname":"Dobrota","email":"frantisek.dobrota@blizka.cz","phone":"728279674728279674","person":"fyz","address":"Blízká","ico":"337567231","count":"1","comment":"Těším se","souhlas":true}  500

registrace chybny email (tohleneniemail.cz)
    API Comunication   {"targetid":"","kurz":"2","name":"František","surname":"Dobrota","email":"frantisek.dobrotablizka.cz","phone":"728279674","person":"fyz","address":"Blízká","ico":"337567231","count":"1","comment":"Těším se","souhlas":true}  500

registrace chybny format JSON (bez klíče a hodnoty kurzu)
    API Comunication   {"targetid":"","name":"František","surname":"Dobrota","email":"frantisek.dobrota@blizka.cz","phone":"728279674","person":"fyz","address":"Blízká","ico":"337567231","count":"1","comment":"Těším se","souhlas":true}  500

registrace chybny format JSON (vymyslet jinou chybu JSON dat)
    # text name bez "
    API Comunication   {"targetid":"","kurz":"2","name":František,"surname":"Dobrota","email":"frantisek.dobrota@blizka.cz","phone":"728279674","person":"fyz","address":"Blízká","ico":"337567231","count":"1","comment":"Těším se","souhlas":true}  500
    # odstranen oteviraci {
    API Comunication   "targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
    # null
    API Comunication   {"targetid":"","kurz":null,"name":"Jan","surname":"Nova","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
    # '
    API Comunication   {"targetid":'',"kurz":"2","name":"František","surname":"Dobrota","email":"frantisek.dobrota@blizka.cz","phone":"728279674","person":"fyz","address":"Blízká","ico":"337567231","count":"1","comment":"Těším se","souhlas":true}  500

registrace chybny telefon (specialni znak)
    # ¶ misto tel čísla
    API Comunication   {"targetid":"","kurz":"2","name":"František","surname":"Dobrota","email":"frantisek.dobrota@blizka.cz","phone":"¶","person":"fyz","address":"Blízká","ico":"337567231","count":"1","comment":"Těším se","souhlas":true}  500


*** Keywords ***
API Comunication
    [Arguments]       ${json}     ${error_resp}

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}

    Status Should Be    ${error_resp}
