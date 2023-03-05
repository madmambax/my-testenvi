*** Settings ***
Library  Browser
Resource  Projekt/TestData.robot
Resource  Projekt/Configuration.robot

*** Variables ***


*** Test Cases ***
Přidání zboží do košíku
    Login                     ${USER1_NAME}      ${USER1_PASSWORD}
    Přidání zboží             ${ARTICLE01}       ${ARTICLE01ID}        ${ARTICLE01PCS}
    Odstranění zboží          ${ARTICLE01}       ${ARTICLE01ID}        ${ARTICLE01PCS}
    Logout

Negativní testy
    Login                     ${USER2_NAME}      ${USER2_PASSWORD}


*** Keywords ***
Login
    [Arguments]         ${email}                            ${heslo}

    Open Browser        ${URL}                              headless=false
    Sleep               0
    Get Title           contains                            ${TEXT_MainTitle}
    Sleep               0
    Cookie              AcceptAll


    Click               ${SEL_LOGIN}

    Type Text           ${SEL_EMAIL}         ${email}
    Type Text           ${SEL_PASSWORD}      ${heslo}
    Click               ${SEL_LOGIN_BUT}
    Sleep               0
#    Get Text            xpath=//*[@id="content"]/div/h1  contains  Klientské centrum
#    ${log}   Get Text   xpath=//*[@id="content-wrapper"]/div[2]/aside/div/div/ul/li[1]/a/strong
#    Log                 ${log}
#    Take Screenshot
    ${URL_actual}  Get Url
    IF    "${URL_actual}" == "${URL_client}"
        ${log}   Get Text   ${LOG_USER}
    Log                 ${log}
    Take Screenshot
    ELSE
    Log    ${WRONG_LOGIN}

    END
Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END
    sleep               1

Logout
    Go To               ${URL_client}
    Click               ${SEL_LOGOUT}

Přidání zboží
    [Arguments]         ${Zbozi}     ${Value}     ${Pocet_ks}
    Click               ${SEL_SEARCH_ICON}
    Sleep    1
    Type Text           ${SEL_SEARCH_AREA}        ${Zbozi}
    Sleep    2
    Click               ${SEL_SEARCH_BUT}
    Click               ${SEL_PROD_ID}"${Value}"] >> ${SEL_PROD_ADD}
    Click               ${SEL_CLOSEBOX}
    Sleep               2

Odstranění zboží
    [Arguments]        ${Zbozi}     ${Value}     ${Pocet_ks}
    Go To              ${URL_trash}
    Click              ${REMOVE_TRASH}
    Sleep              2
    




