# loop for handling cookies

*** Settings ***
Library  Browser
Library  String


*** Variables ***
${URL}                    https://czc.cz
${Title}                  CZC


*** Test Cases ***

Login
    New Browser    chromium         headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
    New Page                        ${URL}
    Get Title      contains         ${Title}
    Cookie                          Přijmout pouze nezbytné


*** Keywords ***

Cookie
   [Arguments]         ${type}
    IF  "${type}" == "Přijmout pouze nezbytné"
        Click           xpath=//*[@id="ccp-popup"]/div/div[2]/button[1]
    ELSE
        Click           xpath=//*[@id="ccp-popup"]/div/div[2]/button[3]
    END

    sleep               5