*** Test Cases ***

*** Settings ***

Library  OperatingSystem
Library  String


*** Test Cases ***

First test positive
    ${res} =  run           help dir
    log             ${res}
    Should Contain  ${res}  Displays a list of files and subdirectories in a directory.


Second test negative
    ${res} =  run           help Hello
    log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.