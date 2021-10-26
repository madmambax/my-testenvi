# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser


*** Variables ***
${URL}      https://www.alza.cz/


*** Test Cases ***

Prvni
    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}
    Get Title           contains                            Alza

    Type Text           id=edtSearch                        notebook
    Click               id=btnSearch

    Sleep               3
    Take                Screenshot