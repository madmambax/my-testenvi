*** Variables ***
#Test data
${username}         ben_ling2
${pwd}              mpls6868


# Page objects
${URL}                  https://cloud.memsource.com/web

#login
${url_login}            ${URL}/login
${logged_id}            title
${logged_txt}           Jobs - Memsource
${bad_login_id}         div > .errors
${bad_login_txt}        Sorry, we were not able to find a user with that username and password.
${empty_input}          .ms-text-field-wrapper--error
${empty_input_un}       ${empty_input} input#username
${empty_input_pw}       ${empty_input} input#password
${input_username}       id=username
${input_password}       id=password
${web_title}            Memsource


${url_setup}            ${URL}/setup
${button_submit}        id=submit
${menu_timezone}
${menu_language}        text=language
${input_language}       id=locale
${button_save}          id=create

#general keywords
*** Keywords ***



