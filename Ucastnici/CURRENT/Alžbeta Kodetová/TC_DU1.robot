*** Settings ***
Library  OperatingSystem

*** Variables ***

*** Test Cases ***
Pozitivní test první
  ${instalovano}       run                 pip list
  Log                   ${instalovano}
  Log To Console        ${instalovano}

*** Keywords ***
