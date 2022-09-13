*** Settings ***
# načtení knihovny OperatingSystem
Library     OperatingSystem

*** Variables ***
${path} =   C:\Users
@{list} =   Host Name   OS Name     OS Version
${user} =   rosprimova

*** Keywords ***
DisplayContent
    [Arguments]      ${pathArgument}
    [Documentation]  Displays the contents of the current folder
    ${folder} =      run  dir ${pathArgument}
    [return]         ${folder}

*** Test Cases ***
First positive test
    # vytvoření proměnné folder
    ${folder} =  DisplayContent        ${path}

    # proměnná (folder, path, user) je zalogována
    log  ${folder}
    log  ${path}
    Log  ${user}

    # proměnná folder je otestována
    Should Contain  ${folder}   ${user}

Second positive test
    # vytvoření proměnné systemInfo
    ${systemInfo} =  run  systeminfo

    # proměnná (systemInfo, list) je zalogována
    log       ${systemInfo}
    Log Many  @{list}

    # proměnná systemInfo je otestována
    Should Contain  ${systemInfo}   ${list}[0]
    Should Contain  ${systemInfo}   ${list}[1]
    Should Contain  ${systemInfo}   ${list}[2]




