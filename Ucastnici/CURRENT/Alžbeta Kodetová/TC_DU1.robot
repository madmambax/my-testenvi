*** Settings ***
Library  OperatingSystem
Library  BuiltIn

*** Variables ***
${ciselko}              20
@{list_of_standard_libraries}    Create list    BuiltIn     Collection      DateTime    Dialogs

*** Test Cases ***
Pozitivní test první
  ${instalovano}               run                 pip list
  BuiltIn.Should Contain       pip list            selenium
  Log                          ${instalovano}
  Log To Console               ${instalovano}

pozitivní test druhý
  Should Contain          @{list_of_standard_libraries}        Builtin
  Log                          ${instalovano}
  Log To Console               ${instalovano}

#Pozitivní test druhý
#  ${status} =           0 < ${ciselko} < 21
#  Log                   ${status}
#  Log To Console        ${status}

Negativní test první
  ${instalovano}        run                 pip list

  Log                   ${instalovano}
  Log To Console        ${instalovano}


*** Keywords ***
