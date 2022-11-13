"""

Tento příklad potřebuje:
pip install Robotframework-DatabaseLibrary
pip install mariadb

"""

*** Settings ***
Library         DatabaseLibrary


*** Variables ***
${DBHost}         10.5.6.219
#${DBHost}         10.5.0.13
${DBName}         kitnercz02
${DBPass}         XzLY204zz
${DBPort}         3306
${DBUser}         kitnercz003@10.5.0.13


*** Test Cases ***
Prvni test s DB
    Over ucastnika v DB     2  Jan518  Novak  jan.novak@abc.cz  +420777123123

*** Keywords ***
Over ucastnika v DB
    [Arguments]    ${course}  ${name}  ${surname}  ${email}  ${phone}

    Log  DB
    Connect To Database    mariadb    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
    Check If Exists In Database    SELECT name FROM zakaznik WHERE name = 'Jan518';