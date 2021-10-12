*** Settings ***
Library  OperatingSystem

*** Variables ***

*** Test Cases ***
Pozitivní test první
  ${instalovnano}       run                 pip list
  Log To Console        ${instalovano}

*** Keywords ***
