*** Settings ***
Library   Browser

Resource    InputData.robot

*** Keywords ***
Begin web test
    New Browser     ${BROWSER}      headless=False     slowMo=00:00:00

End web test
    Close Browser