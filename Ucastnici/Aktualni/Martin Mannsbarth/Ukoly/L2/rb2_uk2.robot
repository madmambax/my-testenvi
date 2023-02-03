*** Settings ***
Documentation   DU2 part2
Library         Selenium2Library

*** Variables ***
${HOMEPAGE}      http://www.google.com
@{listbrowser}   Edge  Chrome


*** Test Cases ***
# test open google page
Open Browser1
    open the browser1

Open Browser2
    open the browser2

*** Keywords ***
# pre-defined Selenium2Library keyword
open the browser1
    Open Browser   ${HOMEPAGE}  ${listbrowser}[0]

open the browser2
    Open Browser   ${HOMEPAGE}  ${listbrowser}[1]

