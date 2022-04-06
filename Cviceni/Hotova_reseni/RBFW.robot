# Prace s RobotFrameworkem

*** Test Cases ***

Název testu
    ${res} =        run     help
    log             ${res}
    Should Contain  ${res}  For more information on a specific command, type HELP command-name


Nápověda pro příkaz CD (help cd)
    ${res} =        run     help cd
    log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.