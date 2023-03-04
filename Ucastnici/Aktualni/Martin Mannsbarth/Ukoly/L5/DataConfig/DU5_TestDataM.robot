*** Variables ***

#Selectors
# cookies etc.
${SEL_Cookies}                   xpath=//*[@id="ccp-popup"]/div/div[2]/button[3]
${SEL_NoRobot}                   xpath=//*[@id="login-form"]/div[3]/label/span

#user login
${SEL_LoginForm}                 css=\#login > svg
${SEL_InputUser}                 xpath=//*[@id="frm-name"]
${SEL_InputPasswd}               xpath=//*[@id="frm-password"]
${SEL_SignIN}                    xpath=//*[@id="login-form"]/div[4]/button

#user logout
${SEL_Logged}                    id=logged-user
${SEL_LogOut}                    xpath=//*[@id="blue-menu-wrapper"]/ul[2]/li[2]/div/div[2]/a[1]

#user check
${SEL_LogonUser}                 xpath=//*[@id="logged-user"]
${SEL_LogOutText}                xpath=//*[@id="login"]


#find goods and handle basket
${SEL_Find}                      id=fulltext
${SEL_ButtonSearch}              xpath=//*[@id="wrapper"]/header/div[2]/div/div[1]/form/button
${SEL_AddToBasket}               css=[data-product-code="272572"][data-label="Přidat zboží do košíku"]
${SEL_OpenBasket}                xpath=//*[@id="basket-preview"]/a
${SEL_IncreaseNumber}            xpath=//*[@id="frm-quantity-272572"]
${SEL_ConfirmIncrease}           xpath=//*[@id="basket-visibility-container"]/h1

#check basket
${SEL_VerifyGoods}               xpath=//*[@id="basket-table"] >> nth=1
${SEL_VerifyItemAmount}          xpath=//*[@id="frm-quantity-272572"]

#clear basket
${SEL_Clear}                     css=[class="btn-circle-remove"][title="Odstranit z košíku"]

#-------------------------------------------------------------------------------------------------------------------#
# DATA
# user
${DATA_UserMatch}                 Martin Mannsbarth (marmanx25)
${DATA_NoUser}                    Přihlášení
${DATA_IncorrectLogonName}        Nesprávné přihlašovací jméno


#user bad login
${DATA_BadLoginName}              somebody@gmail.com

#user bad password
${DATA_BadPassword}                BadPass

#user credentials
${DATA_login}                      martin.manns@gmail.com
${DATA_Password}                   Smoula2023!

# goods, items
${Data_Pcs}                        3
${DATA_Goods}                      Microsoft Bluetooth Mouse, Pastel Blue\n272572
${DATA_item}                       mouse