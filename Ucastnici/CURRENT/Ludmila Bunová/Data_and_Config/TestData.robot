*** Variables ***
${USER1_Email}       testerkabunova@seznam.cz
${USER1_Password}    Testerka2021
${USER1_Short}       Luci2021

#Strings
${TEXT_MainTitle}                   ČSFD.cz

#Invalid Email and Password
${INVALID_Email}        testtest@seznam.cz
${INVALID_Password}     ghjghj

#Login

${SEL_Icon1}                css=#page-wrapper > header > div.header-main > ul > li:nth-child(2) > a > i
${SEL_Icon2}                css=#page-wrapper > header > div.header-main > ul > li:nth-child(5) > a > div > img
${SEL_LoginLink}            css=#page-wrapper > header > div.header-main > ul > li:nth-child(2) > div > ul.blue > li:nth-child(1) > a
${SEL_LoginFormEmail}       css=#frm-loginForm-username
${SEL_LoginFormPwd}         css=#frm-loginForm-password
${SEL_BtnSignIn}            css=#frm-loginForm > div.footer > button
${SEL_LoginVerifying}       css=#page-wrapper > header > div.header-main > ul > li:nth-child(5) > div > ul:nth-child(2) > li:nth-child(1) > a
${SEL_LogoutLink}           css=#page-wrapper > header > div.header-main > ul > li:nth-child(5) > div > ul:nth-child(6) > li > a
