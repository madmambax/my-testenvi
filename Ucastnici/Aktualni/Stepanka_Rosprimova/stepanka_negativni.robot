*** Settings ***
# načtení knihovny OperatingSystem
Library     OperatingSystem

*** Variables ***
${path} =           C:\rosprimova
${hostName} =       Host Name
${fileNotFound} =   File Not Found

*** Keywords ***
DisplayContent
    [Arguments]      ${pathArgument}
    [Documentation]  Displays the contents of the current folder
    ${folder} =      run  dir ${pathArgument}
    [return]         ${folder}

*** Test Cases ***
First negative test
    # vytvoření proměnné folder
    ${folder} =  DisplayContent    ${path}

    # proměnná (folder, path, fileNotFound) je zalogována
    log  ${folder}
    log  ${path}
    Log  ${fileNotFound}

    # proměnná folder je otestována
    Should Contain  ${folder}   ${fileNotFound}

Second negative test
    # proměnná systemInfo je vytvořená
    ${systemInfo} =  run  info

    # proměnná (systemInfo, hostName) je zalogována
    log  ${systemInfo}
    log  ${hostName}

    # proměnná systemInfo je otestována
    Should Not Contain  ${systemInfo}   ${hostName}
