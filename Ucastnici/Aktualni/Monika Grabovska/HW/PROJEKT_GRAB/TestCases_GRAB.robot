*** Settings ***
Library  Browser
Library  String

Resource  DataConfig_Grab/Config_Grab.robot
Resource  DataConfig_Grab/keywords_grab.robot
Resource  DataConfig_Grab/Test_data_grab.robot

Suite Setup     Before_set
Suite Teardown  After_set
Test Setup   Before_test
Test Teardown    After_test

*** Variables ***

*** Test Cases ***

Login_success
    Login_with_control               ${DATA_user_name}               ${DATA_user_psw}        ${DATA_login_valid}
    User_logged_in
    Add_to_cart                      ${DATA_item01}                   ${DATA_item01_code}     2
    Remove
    Logout

Login_no_success
    Login_with_control               ${DATA_user_name}               noha         ${DATA_login_invalid}
    User_is_not_logged_in