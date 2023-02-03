*** Settings ***
Documentation   DU2 part2
Library         Selenium2Library

*** Variables ***
${HOMEPAGE}      https://www.google.com
@{listbrowser}   Edge  Chrome
${Element}       id:L2AGLb


*** Test Cases ***
# test open google page
Open Browser1
    open the browser1
    Maxim
    Sleep               5
    Clicker             ${Element}


Open Browser2
    open the browser2
    Maxim
    Sleep                5
    Clicker              ${Element}

*** Keywords ***
# pre-defined Selenium2Library keyword
open the browser1
     Open Browser   ${HOMEPAGE}  ${listbrowser}[0]


open the browser2
     Open Browser   ${HOMEPAGE}  ${listbrowser}[1]

Maxim
     Maximize Browser Window

Clicker
     [Arguments]         ${X}
     Click Element       ${X}