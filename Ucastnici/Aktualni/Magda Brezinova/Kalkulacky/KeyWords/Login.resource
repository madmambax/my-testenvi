*** Settings ***
Documentation   Funkce pro logina a logout
Library  Browser

Resource    ../Data/TestData.robot
Resource    ../Configuration/Configuration.robot
Library  DebugLibrary


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
    Get Text            //span[text()="${validation}"]
    ${log}=             Get Text                            //span[text()="${validation}"]
    Log                 Url: ${URL} ${\n} user: ${log} ${\n} login: ${email} ${\n} password: ${heslo}


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
#    Log To Console      ${json_string_cars}
#    Log To Console      ${json_string_values}
    ${json_cars}        evaluate    json.loads('''${json_string_cars}''')    json
    ${json_values}      evaluate    json.loads('''${json_string_values}''')    json
    Type Text           id=regPlate     ${json_cars}[${car}][regPlate]
    Type Text           id=vin          ${json_cars}[${car}][vin]
     # debug
     Click               id=Radio-type.${json_cars}[${car}][type]   #snaží se klikat pořád dokola
     Type Text           id=react-select-2-input    ${json_cars}[${car}][manufacturer]
     Keyboard Key        press                      Enter
     Click               id=model-group-wrapper
     Keyboard Input      InsertText                 ${json_cars}[${car}][model]
     Keyboard Key        press                      Enter
     Type Text           id=firstRegistered         ${json_cars}[${car}][firstRegistered]
     Type Text           id=weight                  ${json_cars}[${car}][weight]
     Type Text           id=capacity                ${json_cars}[${car}][capacity]
     Type Text           id=seats                   ${json_cars}[${car}][seats]
     Type Text           id=power                   ${json_cars}[${car}][power]
#    Click               id=Radio-fuel.${json_cars}[${car}][fuel]  #snaží se klikat pořád dokola
#    Click               //label[contains(@for,"Radio-fuel.${json_cars}[${car}][fuel]")]
#    Click               id=manufacturer-group-wrapper
#    Sleep               10 s
#    Click               ${json_values}[type]
#    Click               //span[contains(@text, ${json_cars}[${car}][type[${json_values}[type][${json_cars}[${car}][type]]])]

#    async enterCar(car) {
#        var defaults = {
#            usage: "private"
#        };
#        car = Object.assign(defaults, car);
#        await this.enterProperty("vin", car, true);
#        await this.chooseCarType(values.type[car.type], true);
#        await this.chooseProperty("manufacturer", car);
#        await this.chooseProperty("model", car);
#        await this.enterProperty("capacity", car, true);
#        await this.enterProperty("power", car, true);
#        //await this.enterProperty("yearOfConstruction", car, true);
#        //await this.chooseProperty("subtype", car, true);
#        await this.chooseProperty("usage", car, true);
#
#        // backoffice
#        await this.enterProperty("weight", car, true);
#        await this.chooseInRadio(values.fuel[car.fuel]);
#        //await this.enterProperty("mileagePerYear", car, true); id="react-select-4-input"
#        await this.enterProperty("mileage", car, true);
#        await this.enterProperty("seats", car, true);
#
#        await this.enterDateProperty("firstRegistered", car);
#
#        await this.enterPropertyWithPrefix("cic.", "carValue", car, true);
#        // contract draft
#        await this.enterProperty("regPlate", car, true);
#        await this.enterProperty("technicalCardNo", car, true);
#        await this.chooseProperty("category", car, true);
#
#        //CIC - nepoužívané
#        let CICId = this.driver.selectorById("cic-CicEnableApp");
#        if(
#            await this.driver.elementExists(this.driver.selectorById("cic-CicEnableApp")) &&
#            await this.driver.isChecked(CICId)
#        ) {
#            await this.chooseProperty("coveredArea", car.cic);
#            await this.enterProperty("cic-carValue", car.cic);
#            await this.setCheckBox("Pasivní vyhledávání", car.cic['undefinedcic--monitoringDevice']);
#            await this.setCheckBox("Imobilizér", car.cic['undefinedcic--immobiliser']);
#            await this.setCheckBox("Značení skel VIN kódem", car.cic['undefinedcic--vinProtection']);
#            await this.setCheckBox("Autoalarm", car.cic['undefinedcic--carAlarm']);
#            await this.setCheckBox("Blokování hřídele volantu", car.cic['undefinedcic--steeringWheelLock']);
#            await this.setCheckBox("Aktivní vyhledávání", car.cic['undefinedcic--activeLookup']);
#            await this.setCheckBox("Mechanické zabezpečení", car.cic['undefinedcic--mechanicalProtection']);
#        }
#
#        // lose focus
#        await this.driver.loseFocus();
#    }
