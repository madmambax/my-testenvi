# tento soubor obsahuje všechna testovací data pro Projekt

*** Variables ***
# User
${USER_LOGIN}               stepanka.rosprimova
${USER_PASSWORD}            Vorman1793
${USER_FULLNAME}            Štěpánka Rosprimová

# Text
${TEXT_LOGIN}               Přihlásit se
${TEXT_TITLE}               ČJF | Jezdecký Informační Systém

# Browser
${BROWSER_NAME}             chromium
${BROWSER_HEADLESS}         false

# Selector for LOGIN
${SEL_LOGIN_USERNAME}       css=input#id_username
${SEL_LOGIN_PASSWORD}       css=input#id_password
${SEL_LOGIN_BUTTON}         id=login-button

# Selector for LOGOUT
${SEL_LOGOUT_BUTTON}        id=logout-button

# Selector for HEADER
${SEL_HEADER_BUTTON}        id=cms-auth
${SEL_HEADER_TEXT}          css=#cms-auth > div:nth-child(1) > a