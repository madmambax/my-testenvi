*** Settings ***
Library	        RequestsLibrary
Library         String

*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

*** Test Cases ***
# "person":"fyz","address":"Brno"   "person":"pra","ico":"25596641"
Positive registration (course 1, phone with 9 numbers, "fyz" person, with comment)
    API Comunication   {"targetid":"","kurz":"1","name":"Kryštof","surname":"Novák","email":"krystof.novak@centrum.cz","phone":"608123123","person":"fyz","address":"Brno", "count":"1","comment":"Přidán komentář 1!","souhlas":true}  200

Positive registration (course 2, phone with "+420", "pra" person, without comment)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Petřina","email":"jan.petrina@gmail.com","phone":"+420608123123","person":"pra","ico":"25596641","count":"15","comment":null,"souhlas":true}  200

Positive registration (course 3, phone with "00420", "fyz" person, without comment)
    API Comunication   {"targetid":"","kurz":"3","name":"Řehoř","surname":"David","email":"jan.novak@seznam.cz","phone":"00420608123123","person":"fyz","address":"Dlouhá ulcie 234, 602 00, Brno","count":"10","comment":null,"souhlas":true}  200

Negative registration (empty course)
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (empty name)
    API Comunication   {"targetid":"","kurz":"1","name":"","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (empty surname)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (empty email)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (empty phone)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (empty person)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"","count":"1","comment":null,"souhlas":true}   500

Negative registration (empty "souhlas")
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":}   500

Negative registration (without agreement - "souhlas":false)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":false}   500

Negative registration (name with 100 letters)
    API Comunication   {"targetid":"","kurz":"1","name":"MarekmareKMarekmareKMarekmareKMarekmareKMarekmareKMarekmareKMarekmareKMarekmareKMarekmareKMarekmareK","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (surname with 100 letters)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"NováknováKNováknováKNováknováKNováknováKNováknováKNováknováKNováknováKNováknováKNováknováKNováknováK","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (wrong value of "kurz")
    API Comunication   {"targetid":"","kurz":"5","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration ("kurz" with letters and special characters)
    API Comunication   {"targetid":"","kurz":"abc?","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (name with numbers and special characters)
    API Comunication   {"targetid":"","kurz":"1","name":"123?","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (surname with numbers and special characters)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"123?","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (wrong email - without @)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novakabc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (email with numbers and special characters behind @)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@123?.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (wrong phone - too long)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123000000000","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (phone with letters and special characters)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"abcdef???","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (wrong value of person)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"wrong","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (address with special characters)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"???","count":"1","comment":null,"souhlas":true}   500

Negative registration (wrong ico - too long)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","ico":"12345678901234567890","count":"1","comment":null,"souhlas":true}   500

Negative registration (ico with letters and special characters)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","ico":"abcd????","count":"1","comment":null,"souhlas":true}   500

Negative registration (wrong value of "souhlas")
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":"ano"}   500

Negative registration (without key and value of "kurz")
    API Comunication   {"targetid":"","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (wrong JSON format - key name without quotation marks)
    API Comunication   {"targetid":"","kurz":"1",name:"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (wrong JSON format - value of name without quotation marks)
    API Comunication   {"targetid":"","kurz":"1","name":Jan,"surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (wrong JSON format - value of "souhlas" with quotation marks)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":"true"}   500

Negative registration (wrong JSON format - without comma between data)
    API Comunication   {"targetid":"""kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (wrong JSON format - without colon)
    API Comunication   {"targetid":"","kurz""1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true}   500

Negative registration (wrong JSON format - without curly brackets)
    API Comunication   "targetid":"","kurz":"1","name":"Jan","surname":"Novák","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","count":"1","comment":null,"souhlas":true   500

*** Keywords ***
API Comunication
    [Arguments]         ${json}     ${error_resp}

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}
    Status Should Be    ${error_resp}