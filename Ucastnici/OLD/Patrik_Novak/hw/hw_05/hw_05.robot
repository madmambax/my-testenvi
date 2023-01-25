*** Settings ***
Library  Browser

Resource  test_data.robot
Resource  keywords.robot

Test Setup  MySetup


*** Test Cases ***

Login Bad Email
    Login                     dsadsad@sdas.cz         ${USER1_PASSWORD}      ${TEXT_PrihlasitSe}
Login Bad Password
    Login                     ${USER1_EMAIL}          dasdas                 ${TEXT_PrihlasitSe}
Login Success
    Login                     ${USER1_EMAIL}          ${USER1_PASSWORD}      ${TEXT_MujUcet}
Adding To Cart
    ${kusu} =	              Set Variable	          5
    Add To Cart               ${ZBOZI01_NAME}         ${ZBOZI01_ID}          ${kusu}
