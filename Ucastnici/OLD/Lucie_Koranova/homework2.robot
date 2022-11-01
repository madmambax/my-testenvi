*** Settings ***
Library     OperatingSystem

*** Variables ***
${NegativniVyhodnoceni}    This command is not supported by the help utility.
${PozitivniVyhodnoceni}    Windows IP Configuration

*** Keywords ***



*** Test Cases ***
Prvni test negativní
    @{prohlizec} =      Create List    Chrome
    Log Many            @{prohlizec}
    Log to Console      ${prohlizec}, ${NegativniVyhodnoceni}, ${PozitivniVyhodnoceni}
    Should Contain     ${prohlizec}[0]  Chrome