Web login to cloud.memsource.com

*** Settings ***
Documentation   Automatizace Memsource s Browser Library
Library         Browser
Resource        Data_and_Config/resources.robot


Suite Setup         Before Suite   #spustí se před celou suite
Suite Teardown      After Suite    #spustí se po doběhnutí celé suite

*** Variables ***

*** Test Cases ***
Create project
    Click                       xpath=//a[@href="/web/project/create"]
    Fill Text                   id=name                     Test project 1
    Click                       id=targetLangs-cs           clickCount=2
    Select Options By           id=sourceLang               value              en
    Click                       ${button_create}
    Wait For Elements State     id=newJobButton             visible
    Get Text                    css=.main-box > .title      ==          Test project 1
    Take Screenshot


*** Keywords ***

Before Suite
    Open Browser
    Login Page      ${username}     ${pwd}
    Sleep           3s
    Get Url         contains        list

After Suite
    Close Browser