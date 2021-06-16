#testovaci data pro mojecviceni.robot

*** Variables ***
#ValidTestData
${USER1_NAME}                       TesterNotARobot12@gmail.com
${USER1_PWD}                        hesloNeniPassword34
${USER1_SHORT}                      TT

#InvalidTestData
${BAD_USER1}                        jsemprihlasen
${BAD_USER1_PWD}                    passwordispassword

#ErrorMessages
${ERROR_TEXT_FillCorrectEmail}      Zadejte platný email
${ERROR_TEXT_IncorrectEmailOrPwd}   Zadal(a) jste nesprávný e-mail nebo heslo.


${URL}                              http://rohlik.cz
${BROWSER}                          Chrome


#Login
${SEL_HeaderLogin}          id=headerLogin
${SEL_TTBtn}                xpath=//*[@id="headerUser"]/div
${SEL_UserBoxLogoutBtn}     xpath=//*[@id="header"]/div[1]/div[1]/div/div[2]/div/div[2]/div[5]/a/x-translation
${SEL_LoginValidEmail}      xpath=//*[@id="email"]
${SEL_LoginValidPwd}        xpath=//*[@id="password"]
${SEL_BtnSignIn}            xpath=//*[@id="header"]/div[1]/div[1]/div/div[2]/div/div[2]/div/div[1]/form/button/x-translation




