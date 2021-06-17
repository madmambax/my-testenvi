*** Variables ***
#Test data
${username}         marek.kure82
${pwd}              Mpls6868


# Page objects
${URL}                  https://cloud.memsource.com/web

#login
${url_login}            ${URL}/login
${logged_id}            title
${logged_txt}           Projects - Memsource
${bad_login_id}         div > .errors
${bad_login_txt}        Sorry, we were not able to find a user with that username and password.
${empty_input}          .ms-text-field-wrapper--error
${empty_input_un}       ${empty_input} input#username
${empty_input_pw}       ${empty_input} input#password
${input_username}       id=username
${input_password}       id=password
${web_title}            Memsource


${url_setup}            ${URL}/setup
${url_project}          ${URL}/project/list
${button_submit}        id=submit
${button_create}        id=create


#general keywords
*** Keywords ***

Login Page
    [Documentation]     Opens the login page and fills the username and password
    [Arguments]         ${username}         ${password}
    New Page            ${url_login}
    Get Title           contains            ${web_title}
    Type Text           ${input_username}   ${username}
    Type Text           ${input_password}   ${password}
    Click               ${button_submit}


Login
    [Documentation]     Evaluates Login with username and password
    [Arguments]         ${validation_id}    ${validation_text}  ${username}     ${password}
    Login Page          ${username}         ${password}
    Get Text            ${validation_id}    ==                  ${validation_text}
    Take Screenshot


