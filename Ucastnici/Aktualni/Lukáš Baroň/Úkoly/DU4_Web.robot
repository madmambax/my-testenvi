*** Settings ***
Library  Browser

*** Variables ***
${URL}         https://www.vonavazastavka.cz/
${URL_client}  https://www.vonavazastavka.cz/klient/
${URL_trash}   https://www.vonavazastavka.cz/kosik/



*** Test Cases ***
Přidání zboží do košíku
    Login                     lukasbaron@seznam.cz        tajneheslo
    Přidání zboží             mýdlo       181        1
    Odstranění zboží          mýdlo       181        1
    Logout

Negativní testy
    Login                     neco@seznam.cz        tajneheslo


*** Keywords ***
Login
    [Arguments]         ${email}                            ${heslo}

    Open Browser        ${URL}                              headless=false
    Sleep               0
    Get Title           contains                            Voňavá zastávka
    Sleep               0
    Cookie              AcceptAll


    Click               css=[data-testid=signin]

    Type Text           css=[name="email"]          ${email}
    Type Text           css=[name="password"]        ${heslo}
    Click               xpath=//*[@id="formLoginIncluded"]/div[3]/div/button
    Sleep               0
#    Get Text            xpath=//*[@id="content"]/div/h1  contains  Klientské centrum
#    ${log}   Get Text   xpath=//*[@id="content-wrapper"]/div[2]/aside/div/div/ul/li[1]/a/strong
#    Log                 ${log}
#    Take Screenshot
    ${URL_actual}  Get Url
    IF    "${URL_actual}" == "${URL_client}"
        ${log}   Get Text   xpath=//*[@id="content-wrapper"]/div[2]/aside/div/div/ul/li[1]/a/strong
    Log                 ${log}
    Take Screenshot
    ELSE
    Log    Neplatné přihlášení

    END
Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           data-testid=btnCookiesAccept
    ELSE
        Click           data-testid=btnCookiesReject
    END
    sleep               1

Logout
    Go To               ${URL_client}
    Click               css=[data-testid="signout"]

Přidání zboží
    [Arguments]         ${Zbozi}     ${Value}     ${Pocet_ks}
    Click               data-testid=searchIcon
    Type Text           data-testid=searchInput        ${Zbozi}
    Click               data-testid=searchBtn
    Click               css=[data-micro-product-id="${Value}"] >> data-testid=addToCart
    Click               id=cboxClose
    Sleep               2

Odstranění zboží
    [Arguments]        ${Zbozi}     ${Value}     ${Pocet_ks}
    Go To              ${URL_trash}
    Click              css=[class="remove-item"]
    Sleep              2
    




