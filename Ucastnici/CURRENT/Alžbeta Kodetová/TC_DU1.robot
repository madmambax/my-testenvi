*** Settings ***
Library  OperatingSystem

*** Variables ***

*** Test Cases ***
#Pozitivní test první
#  ${instalovano}       run                 pip list
#  Log                   ${instalovano}
#  Log To Console        ${instalovano}
#
#Pozitivní test druhý
#  ${instalovano}        run                 pip show robotframework
#  Log                   ${instalovano}
#  Log To Console        ${instalovano}

Negativní test první
  ${instalovano}        run                 pip show takovaknihovnaneexistuje
  Log                   ${instalovano}
  Log To Console        ${instalovano}


*** Keywords ***
