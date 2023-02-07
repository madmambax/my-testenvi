*** Settings ***
Library     OperatingSystem
Library     String
Library     Browser


***Variables***
${hostname}  DESKTOP-DL3VO3P



***Keywords***


*** Test Cases ***
# cviceni 1
Run hostname command
    ${result} =  Run  hostname
    Log  ${result}
    Should Contain  ${result}    ${hostname}

# cviceni 2
Run whoami command
    ${result} =  Run  whoami
    Log  ${result}
    Should Contain  ${result}    vojta


# cviceni 3


# cviceni 4
Starting a browser with a page
   New Browser    chromium    headless=false
   New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
   Get Title      ==    Browser

