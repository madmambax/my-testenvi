*** Settings ***
Documentation   Funkce pro logina a logout
Library  Browser

Resource    ../Data/TestData.robot
Resource    ../Configuration/Configuration.robot
Library     DebugLibrary


*** Keywords ***

Ukazka Logovani
    Log     Ahoj                INFO
    Log     moc se nepoužívá    HTML
    Log     varovani            WARN
    Log     chyba               ERROR
    Log     trace               TRACE
    Log     debug               DEBUG

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}
    Get Title           contains                            Vítejte
    Click               ${SEL_LoginOtherVariant}
    Type Text           ${SEL_LoginUsername}                ${email}
    Type Text           ${SEL_LoginPassword}                ${heslo}
    Click               ${SEL_LoginButton}
#        Get Text            //span[text()="${validation}"]          ########### na stránce je teď jméno přihlášeného dvakrát
#        Get Text     ${log}=             Get Text                            //span[text()="${validation}"]
#            Log                 Url: ${URL} ${\n} user: ${log} ${\n} login: ${email} ${\n} password: ${heslo}


Logout
    [Arguments]         ${validation}
    Click               //span[text()="${validation}"]
    Click               ${SEL_Logout}
    Get Title           contains                            Vítejte




Otevřu kalkulačku
    [Arguments]         ${calculator}
    Get Text            //p[contains(text(),"${calculator}")]
    Click               //p[contains(text(),"${calculator}")]

Je aktivní krok
    [Arguments]         ${step}
    Get Text            //div[contains(@class,'Stepper__item Stepper__item--active')]/span[contains(text(),"${step}")]

Zadám kalkulaci vozidla
    [Arguments]         ${car}
    ${json_cars}        evaluate    json.loads('''${json_string_cars}''')    json
    ${json_values}      evaluate    json.loads('''${json_string_values}''')    json
    Type Text           id=regPlate     ${json_cars}[${car}][regPlate]
    Type Text           id=vin          ${json_cars}[${car}][vin]
    Click               //label[contains(@for,"Radio-type.${json_cars}[${car}][type]")]
    Type Text           id=react-select-2-input    ${json_cars}[${car}][manufacturer]
    Keyboard Key        press                      Enter
    Type Text           id=react-select-3-input    ${json_cars}[${car}][model]
    Keyboard Key        press                      Enter
    Click               //label[contains(@for,"Radio-fuel.${json_cars}[${car}][fuel]")]
    Type Text           id=firstRegistered         ${json_cars}[${car}][firstRegistered]
    Type Text           id=weight                  ${json_cars}[${car}][weight]
    Type Text           id=capacity                ${json_cars}[${car}][capacity]
    Type Text           id=seats                   ${json_cars}[${car}][seats]
    Type Text           id=power                   ${json_cars}[${car}][power]
    Type Text           id=mileage                 ${json_cars}[${car}][mileage]
    Type Text           id=cic.carValue            ${json_cars}[${car}][cic][cic-carValue]


Zadám pojistníka
    [Arguments]         ${parties}
    ${json_parties}     evaluate    json.loads('''${json_string_parties}''')    json
    Click               //label[contains(@for,"Radio-policyHolder.type.${json_parties}[${parties}][policyHoldertype]")]
    type Text           id=react-select-5-input        ${json_parties}[${parties}][country]
    Keyboard Key        press                      Enter
    type Text           id=policyHolder.birthNumber        ${json_parties}[${parties}][birthNumber]
    Click               id=policyHolder.birthNumber-findButton
    Type Text           id=street                 ${json_parties}[${parties}][street]
    Type Text           id=districtHouseNo                 ${json_parties}[${parties}][districtHouseNo]
    Type Text           id=HouseNo                 ${json_parties}[${parties}][HouseNo]
    Type Text           id=zip                 ${json_parties}[${parties}][zip]
    Type Text           id=town                 ${json_parties}[${parties}][town]




