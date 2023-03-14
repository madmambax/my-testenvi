
*** Settings ***
Library  RequestsLibrary
Library  String


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***

#FYZICKÁ OSOBA

Start request tests
    Basic url api test
Registration ok (kurz 2)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
Registration without consent
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":false}  200
Registration without choosing a course
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500
Telephone dialing registration (blank)
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500
Registration with long name    #CHYBA
    Log To Console     Chybí omezení znaků v poli jméno (delší řetězec zařízne na 30 znaků)
    API Comunication   {"targetid":"","kurz":"2","name":"fasdfadfaffffffffffffffffffffffffffffaadfadfadfadfadffdfdafadfadfadfdafadfadfadfadfdfadfadfadfadfadfadfadfadfadfadfadfadfdajj","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
Registration with long surname    #CHYBA
    Log To Console     Chybí omezení znaků v poli příjmení (delší řetězec zařízne na 30 znaků)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"fasdfadfaffffffffffffffffffffffffffffaadfadfadfadfadffdfdafadfadfadfdafadfadfadfadfdfadfadfadfadfadfadfadfadfadfadfadfadfdajj","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
Negative phone number
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"-1","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Negative number in count field
    Log To Console     Lze se zaregistrovat se zaporným číslem v poli počet osob
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"-1","comment":null,"souhlas":true}  500
Count field (blank)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"","comment":null,"souhlas":true}  500
Long number in count field
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"123456781111111","comment":null,"souhlas":true}  500
Telephone with preselection  #CHYBA
    Log To Console     Špatně uloží telefonní číslo s předvolbou
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"+420608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
Long string in the comment field    #CHYBA
    Log To Console     Chybí omezení znaků v poli komentáře a dotazy ke školení
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx","souhlas":true}  500
Long string in the adress field    #CHYBA
    Log To Console     Chybí omezení znaků v poli adresa
    API Comunication   {"targetid":"","kurz":"2","name":"Jan45","surname":"Novak35","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Long string in the email field
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
All field blank
    API Comunication   {"targetid":"","kurz":"","name":"","surname":"","email":"","phone":"","person":"","address":"","ico":"","count":"","comment":null,"souhlas":true}  500
Empty name field
    API Comunication   {"targetid":"","kurz":"2","name":"","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Empty surname field
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Empty email field
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Registration ok (kurz 1)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
Registration ok (kurz 3)
    API Comunication   {"targetid":"","kurz":"3","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
Email without "@"
    API Comunication   {"targetid":"","kurz":"3","name":"Jan","surname":"Novakščěšíů","email":"jan.novakabc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Incorrectly entered email_01
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Incorrectly entered email_02
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Incorrectly entered email_03
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@.","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Incorrectly entered email_04
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@com","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Incorrectly entered email_05
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@.com","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Adress fields with number only    #CHYBA
    Log To Console     Registrace projde s adresou psanou jen čísly
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"555555555","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Incorrect phone number
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"60812312","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
Phone number field filled with letters
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"aaabbbccc","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500


#PRÁVNICKÁ OSOBA

Registration without choosing a course "pra"
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500
Registration ok (kurz 2) "pra"
     API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"49713361","count":"1","comment":null,"souhlas":true}  200
Registration without consent "pra"
     API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"49713361","count":"1","comment":null,"souhlas":false}  200
Negative number in ICO field "pra"
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"-1","count":"1","comment":null,"souhlas":true}  500
One number in ICO field "pra"
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"2","count":"1","comment":null,"souhlas":true}  500
ICO field (blank) "pra"
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"","count":"1","comment":null,"souhlas":true}  500
Registration with long ICO number "pra"
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"497133611","count":"1","comment":null,"souhlas":true}  500
Registration ok (kurz 1) "pra"
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"49713361","count":"1","comment":null,"souhlas":true}  200
Registration ok (kurz 3) "pra"
    API Comunication   {"targetid":"","kurz":"3","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"49713361","count":"1","comment":null,"souhlas":true}  200

# JSON

JSON format without braces
    API Comunication   "targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true  500
JSON with missing quotes in the name
    API Comunication   {targetid:"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
JSON with missing value quotes
    API Comunication   {"targetid":"","kurz":"2","name":Jan,"surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
JSON with missing comma
    API Comunication   {"targetid":"""kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
JSON with missing "kurz"
    API Comunication   {"targetid":"","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
JSON - boolean with an uppercase initial letter
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":True}  500


*** Keywords ***
Basic url api test
    ${resp} =  GET   ${url}
    Status Should Be    OK   ${resp}

API Comunication
    [Arguments]       ${json}     ${error_resp}

    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}

    Status Should Be    ${error_resp}