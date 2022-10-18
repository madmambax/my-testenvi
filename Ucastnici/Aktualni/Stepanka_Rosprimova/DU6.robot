*** Settings ***
Library	 RequestsLibrary
Library  JSONLibrary
Library  String

*** Variables ***
${BASE_URL}		        http://testovani.kitner.cz
${FORM_URL}             regkurz/formsave.php
${FORM_BASE_URL}        ${BASE_URL}/${FORM_URL}

*** Test Cases ***
Uspesna registrace
    &{data}=            Get API Data    ''   3   Stepanka    Rosprimova      RosprimovaStepanka@seznam.cz    608936189   fyz     Sokolov    49494949     1       nic     true
    Log Many            &{data}
    ${json_data}=       Convert Json To String      ${data}
    Log                 ${json_data}

    Send API Data       ${json_data}    200

Bez vyberu kurzu
    &{data}=            Get API Data    ''   ''   Stepanka    Rosprimova      RosprimovaStepanka@seznam.cz    608936189   fyz     Sokolov    49494949     1       nic     true
    Log Many            &{data}
    ${json_data}=       Convert Json To String      ${data}
    Log                 ${json_data}

    Send API Data       ${json_data}    500

Neplatny e-mail
    &{data}=            Get API Data    ''   3   Stepanka    Rosprimova      RosprimovaStepankaseznam.cz    608936189   fyz     Sokolov    49494949     1       nic     true
    Log Many            &{data}
    ${json_data}=       Convert Json To String      ${data}
    Log                 ${json_data}

    Send API Data       ${json_data}    500

Bez parametru jmeno
    &{data}=            Get API Data    ''   3   Stepanka    Rosprimova      RosprimovaStepanka@seznam.cz    608936189   fyz     Sokolov    49494949     1       nic     true
    Log Many            &{data}
    ${json_data}=       Convert Json To String      ${data}
    ${json_data}=       Replace String              ${json_data}        "name": "Stepanka"      "surname": "Rosprimova"

    Log                 ${json_data}

    Send API Data       ${json_data}    500

Souhlas
    &{data}=            Get API Data    ''   3   Stepanka    Rosprimova      RosprimovaStepanka@seznam.cz    608936189   fyz     Sokolov    49494949     1       nic     false
    Log Many            &{data}
    ${json_data}=       Convert Json To String      ${data}
    Log                 ${json_data}

    Send API Data       ${json_data}    200

Specialni znaky
    &{data}=            Get API Data    ''   3   ********    %%%%%%%%%%      RosprimovaStepanka@seznam.cz    *********   fyz     Sokolov    49494949     *       nic     true
    Log Many            &{data}
    ${json_data}=       Convert Json To String      ${data}
    Log                 ${json_data}

    Send API Data       ${json_data}    500

*** Keywords ***
Get API Data
    [Arguments]     ${targetid}      ${kurz}     ${name}      ${surname}     ${email}     ${phone}     ${person}     ${address}     ${ico}     ${count}     ${comment}     ${souhlas}
    &{data}=        Create Dictionary   targetid=${targetid}  kurz=${kurz}  name=${name}  surname=${surname}   email=${email}     phone=${phone}     person=${person}    address=${address}    ico=${ico}   count=${count}  comment=${comment}   souhlas=${souhlas}
    [return]        &{data}

Send API Data
    [Arguments]             ${json_data}     ${status}
    ${json_data_utf8}=      Encode String To Bytes      ${json_data}            UTF-8
    ${response}=            POST  ${FORM_BASE_URL}      data=${json_data_utf8}  expected_status=${status}
    Log                     ${response.json()}
    Status Should Be        ${status}