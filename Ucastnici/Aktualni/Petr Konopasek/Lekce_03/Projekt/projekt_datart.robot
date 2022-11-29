"""
●	Cvičení č.1:
○	vytvořit automatický test na přihlášení do webové aplikace (stránky) a také odhlášení
○	použijte vaši aplikaci, kterou chcete testovat nebo rohlik.cz
○	vytvořte klíčové slovo pro přihlášení můžete použít soubor Cviceni/CV09_BrowserLib_cv.robot
○	uložte do gitu do svého adresáře pod názvem projekt.robot

●	Cvičení č.2:   ( druhý selektor:text= na řádcích 58, 59, 70, 72 )
○	v aplikaci použijte min 2 druhy selektorů (možnosti jsou data-text, id, xpath, text... více zde)
○	použijte copy -> selector v DEV TOOLS chrome

"""
*** Settings ***
Library  Browser

*** Variables ***

${URL}          https://www.datart.cz/

# Login DATART
${USER_mail}        nabopob356@nubotel.com
${USER_pass}        LRmbyrT8QNGPqd2
${USER_name}        Iris Kadimera
${USER_mail_wrong}  Neplatný-format.cz
${USER_pass_wrong}  password1234

${USER_error_pass-em}           Špatný e-mail nebo heslo.

# SELECTORs Ověření Login
${SEL_GetText_IK}               xpath=/html//snippet[@id='snippet--header-user']//span[@class='login-user-name']

# SELECTORs Hover
${SEL_Hover_Login}              xpath=/html//snippet[@id='snippet--header-user']//span[.='Můj DATART']
${SEL_Hover_UnLogin}            xpath=/html//snippet[@id='snippet--header-user']//span[@class='login-user-name']
${SEL_hover_popup_bonus}        xpath=//*[@id="exponea-customer-input-email"]

# SELECTORs - nastavení cookies
${SEL_cook_souhlas}             xpath=/html//button[@id='c-p-bn']   #css=.button#c-p-bn ● text="Souhlasím a pokračovat"
${SEL_cook_podrobne}            xpath=/html//button[@id='c-s-bn']   #css=.button#c-s-bn ● text=" text="Souhlasím a pokračovat"
${SEL_cook_odmitnout}           xpath=/html//button[@id='c-t-bn']   #css=.button#c-t-bn ● text="Odmítnout volitelné cookies"

# SELECTORs - podrobné cookies
${SEL_cook_podr_pers}           xpath=//*[@id="s-bl"]/div[3]/div[1]/label/input
${SEL_cook_podr_rekl}           xpath=//*[@id="s-bl"]/div[4]/div[1]/label/input
${SEL_cook_podr_anal}           xpath=//*[@id="s-bl"]/div[5]/div[1]/label/input
${SEL_cook_podr_pokracovat}     xpath=//*[@id="s-all-bn"]
${SEL_cook_podr_save}           xpath=//*[@id="s-sv-bn"]
${SEL_cook_podr_reject}         xpath=//*[@id="s-rall-bn"]

# SELECTORs Login
${SEL_Login}                    xpath=//*[@id="snippet--header-user"]/div[1]/div[1]/span
${SEL_TypeT_email}              xpath=/html//input[@id='frm-login']
${SEL_TypeT_password}           xpath=/html//input[@id='frm-password']
${SEL_prihlasit}                xpath=//snippet[@id='snippet--header-loginForm-dialog']/form//button[@type='submit']

# SELECTORs unLogin
${SEL_UnLogin}                  xpath=/html//snippet[@id='snippet--header-user']//div[@class='login-menu-content']/ul//a[@href='/zakaznik/odhlaseni']
${SEL_UnLogin_text}             text="Odhlásit se"
${SEL_UnLog_IrisK}              text=${USER_name}

# SELECTORs basket - košík
${SEL_bas_search}		xpath=//*[@id="main-header"]/div[3]/div/div/form/div/input
${SEL_bas_sea_hledat}           xpath=//*[@id="btnSearch"]/span
${SEL_bas_sea_Ip14}             Iphone 14
${SEL_bas_add_item_Ip14}        xpath=//*[@id="snippet--searchProductList"]/div/div/div[1]/div/div/div[2]/div[2]/div[2]/div[2]/div[1]/button
${SEL_bas_sea_Ss22}             Samsung s22
${SEL_bas_item_ip14_}		xpath=//*[@id="snippet--searchProductList"]/div/div/div[1]/div/div/div[2]/div[2]/div[2]/div[2]/div[1]/button/span
${SEL_bas_add_item_Ss22}        xpath=//*[@id="snippet--searchProductList"]/div/div/div[1]/div/div/div[2]/div[2]/div[2]/div[2]/div[1]/button/span
${SEL_bas_Close_rew}            xpath=//*[@id="modal-snippet--modal"]/div/div/div/div[1]/button
${SEL_bas_goto_basket}          text="Do košíku"  #  ●●●	Cvičení č.2:  použit druhý selektor Selektor typu TEXT ●●●
${SEL_bas_recykle}              xpath=/html/body/div[2]/div[5]/div[1]/a[2]
${SEL_bas_recykle_text}         text="Zahodit košík"

# SELECTORs PopUp - Získat slevu
${SEL_PopUp_add_bonus}		xpath=//*[@id="welcome-banner"]/div[3]/div[3]/div/div[1]/div[2]/button[2]
${SEL_PopUp_select_b400}	xpath=//*[@id="discount-700-choice"]/h4
${SEL_PopUp_sent_b400}		Xpath=//*[@id="welcome-banner"]/div[3]/div[2]/div[2]/div[1]/div[2]/button[2]


*** Test Cases ***
Prihlaseni OK
    Login           ${USER_mail}            ${USER_pass}            ${USER_name}

# ● ● ● ř 84 až 92 Režim OFF  ● ● ●
#       Tady to musím poladit a zakomponovat negativní test. 
#       Je tam hover slide un/login menu...  Tak na tom zkusim zapracovat.
#
#Login - Email format wrong
#    Login           ${USER_mail_wrong}      ${USER_pass}            ${USER_name}
#
##Login - password wrong
#    Login           ${USER_mail}            ${USER_pass_wrong}      ${USER_name}
# ● ● ● ř 84 až 93 Režim OFF  ● ● ●

*** Keywords ***
Login
    [Arguments]     ${USER_mail}        ${USER_pass}        ${USER_name}

    Log             ${USER_mail}
    Log             ${USER_pass}
    Log             ${USER_name}

#Browser
    New Browser    chromium    headless=false
    New Page       ${URL}
    Get Title      contains    DATART - Opravdový elektrospecialista | DATART

    Set Strict Mode    False   # Does not fail if selector points to one or more elements

    #Vybrat cookies podrobné   Souhlas - Podrobné - Odmítnout :  OFF-ON-OFF
    #Souhlasím a pokračovat

    #Click    ${SEL_cook_souhlas}   # Souhlasím a pokračovat
#    Click    ${SEL_cook_podr_pokracovat}    # Souhlasím a pokračovat
# Podrobné nastavení cookies
    Click    ${SEL_cook_podrobne}           # Souhlasím a pokračovat
    Click    ${SEL_cook_podr_pers}          # Personalizované cookies ON/OFF
    Click    ${SEL_cook_podr_rekl}          # Reklamní cookies ON/OFF
    Click    ${SEL_cook_podr_anal}          # Analytické cookies ON/OFF
    Click    ${SEL_cook_podr_save}          # Uložit podrobné nastavení cookies
#    Click    ${SEL_cook_podr_reject}        # Odmítnout volitelné cookies

#Přihlášení
    Hover           ${SEL_Hover_Login}
    Sleep       2
    Type Text       ${SEL_TypeT_email}       ${USER_mail}
    Type Text       ${SEL_TypeT_password}    ${USER_pass}
    Sleep       2
    Click           ${SEL_prihlasit}
    Sleep       2
    Take Screenshot
#Ověření přihlášení
    #ověření přihlášený data-test=header-user-icon musí obsahovat Iris Kadimera
    Get Text        ${SEL_GetText_IK}  ==  ${USER_name}
    Hover           ${SEL_Hover_UnLogin}

# basket - vyhledání  položky
     #Vyhledat Iphone14
    Hover               ${SEL_bas_search}
    Type text	        ${SEL_bas_search}           ${SEL_bas_sea_Ip14}  # vloží do hledání text "Iphone 14"
    Click               ${SEL_bas_sea_hledat}
    Sleep               2

#Přidat Iphone14 do košíku
    Click               ${SEL_bas_add_item_Ip14}
    sleep               2
    Take Screenshot
    Click               ${SEL_bas_Close_rew}
    Sleep               1
#Vyčištění SearchBar
    Scroll To Element   ${SEL_bas_search}
    Clear Text          ${SEL_bas_search}
    sleep               2
#Vyhledat Samsung S22
    Type text	        ${SEL_bas_search}            ${SEL_bas_sea_Ss22}  # vloží do hledání text "Samsung S22"
    Click               ${SEL_bas_sea_hledat}
    Sleep               2

#Přidat Samsung S22 do Košíku
    Click               ${SEL_bas_add_item_Ss22}
    sleep               2
    Take Screenshot
#Zobrazit košík
    Click               ${SEL_bas_goto_basket}
    sleep               2
#Zahodit košík
    Scroll To Element   ${SEL_bas_recykle}
    sleep               2
    Click               ${SEL_bas_recykle_text}
    sleep               3
    Click               text="na hlavní stránku"
    sleep               1

#Unlogin
    Log                 Variables
    Hover               ${SEL_UnLog_IrisK}
    Click               ${SEL_UnLogin_text}
    sleep               5

*** Comments ***
Jeste na tom zapracuji.
Sleep mohu  dát také do ${var}, ale zatím jsem je přiznal.


