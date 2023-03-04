# necessary libraries
*** Settings ***
Library  Browser
Library  String

#resources data and config
Resource   ../L5_Project/DataConfig/DU5_configrobo.robot
Resource   ../L5_Project/DataConfig/DU5_TestDataM.robot
Resource   ../L5_Project/DataConfig/DU5_keywords.robot


Test Setup      Before_Test
Test Teardown   After_Test

*** Variables ***

#variables from resource files


*** Test Cases ***
 # basic tests for czc
Test czc bad user
        Login               ${DATA_BadLoginName}              ${DATA_Password}             ${DATA_NoUser}

#Test czc bad password
#        Login1             ${DATA_login}                    ${DATA_BadPassword}          ${DATA_NoUser}

Test czc
        Login2              ${DATA_login}                    ${DATA_Password}             ${DATA_UserMatch}
