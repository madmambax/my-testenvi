*** Variables ***
#Test data
${username}         marek.kure82
${pwd}              Mpls6868


# Page objects
${URL}                  https://cloud.memsource.com/web

#login
${url_login}                ${URL}/login
${SEL_logged}               title
${TXT_logged}               Projects - Memsource
${SEL_bad_login}            div > .errors
${TXT_bad_login}            Sorry, we were not able to find a user with that username and password.
${SEL_empty_input}          .ms-text-field-wrapper--error
${SEL_empty_input_un}       ${SEL_empty_input} input#username
${SEL_empty_input_pw}       ${SEL_empty_input} input#password
${SEL_input_username}       id=username
${SEL_input_password}       id=password
${TXT_web_title}            Memsource


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
    Get Title           contains            ${TXT_web_title}
    Type Text           ${SEL_input_username}   ${username}
    Type Text           ${SEL_input_password}   ${password}
    Click               ${button_submit}


Login
    [Documentation]     Evaluates Login with username and password
    [Arguments]         ${validation_id}    ${validation_text}  ${username}     ${password}
    Login Page          ${username}         ${password}
    Get Text            ${validation_id}    ==                  ${validation_text}
    Take Screenshot


