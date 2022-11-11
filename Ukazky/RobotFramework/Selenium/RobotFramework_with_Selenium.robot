*** Settings ***
Library     Selenium2Library
Resource    /steps/keywords.txt

*** Variables ***
${URL}         http://www.google.com

*** Keywords ***
Open browser with URL
    [arguments]     ${url}
    Open Browser    ${url}  browser=gc

Set input on text box
    [arguments]     ${xpath}    ${text}
    Input text      ${xpath}    ${text}

Push button
    [arguments]     ${button}
    Click Button    ${button}

*** Test Cases ***
Google Access
    Open browser with URL   ${URL}
    Set input on text box   //*[@id="gbqfq"]    Critical Software
    Push button             //*[@id="gbqfba"]

    #Close Browser    