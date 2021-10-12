*** Settings ***

*** Variables ***

*** Test Cases ***
Pozitivní test první
  ${instalovnano}       run                 pip
  Log To Console        ${instalovano}

*** Keywords ***
