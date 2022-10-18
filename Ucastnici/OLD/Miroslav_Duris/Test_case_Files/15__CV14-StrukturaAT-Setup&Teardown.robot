*** Comments ***
Opravit selektory.

*** Settings ***
Documentation   Zkouska funkci 'Setup' a 'Teardown'
Library         Browser
Resource        /home/miki/PycharmProjects/jak_automatizovat_testy/Ucastnici/OLD/Miroslav_Duris/Data&Config/TestDataUpdated.robot
Resource        /home/miki/PycharmProjects/jak_automatizovat_testy/Cviceni/Data_and_Config/Configuration.robot
Resource        /home/miki/PycharmProjects/jak_automatizovat_testy/Cviceni/Data_and_Config/Selektory-CV13.robot
# Suite Setup     Pred_celou_test_sadou      Spustí se jednou na začátku test sady.
# Suite Teardown  Po_cele_test_sade          Spustí se jednou na konci test sady.
# Test Setup      Pred_kazdym_test_casem     Spustí se jednou na začátku každého test casu.
# Test Teardown   Po_kazdem_test_casu        Spustí se jednou na konci každého test casu.       Proběhne i v případě, že testcase nedojde až do konce (failne třeba v půlce).
## Suite Setup, Suite Teardown, Test Setup i Test Teardown mají 1 povinnej argument (přesně 1 - musí to být nějaké klíč. slovo - library keyword nebo user-defined keyword)
### Setupy a Teardowny se dají nastavit i u jednotlivých testcasů (a nejenom v sekci Settings pro celou test. sadu).
### Dají se tak anulovat nebo změnit Setupy a Teardowny nastavený v sekci Settings (ty platí defaultně pro všechny testcasy ve filu).

*** Variables ***

*** Test Cases ***
1. case
    [Documentation]     Login spatny email
    [Tags]               funkční
    Login           chyba                       ${USER1_PASSWORD}                       ${ERROR_TEXT_FillCorrectEmail}
    # je nutné zavřít prihlašovací form - jakej přihlašovací form? Jak ho zavřít? A proč?
    Click           ${SEL_HeaderLogo}

2. case
    [Documentation]    Login spatne heslo
    [Tags]               funkční
    Login           ${USER1_NAME}               bad                                     ${ERROR_TEXT_IncorrectEmailOrPwd}
    # je nutné zavřít prihlašovací form - jakej přihlašovací form? Jak ho zavřít? A proč?
    Click           ${SEL_HeaderLogo}

3. case
    [Documentation]    Login vse OK
    [Tags]              funkční
    Login           ${USER1_NAME}               ${USER1_PASSWORD}                    ${USER1_SHORT}
    Logout

4. case
    [Documentation]    Test Objednavky
    [Tags]              nefunkční
    ${kusu} =	        Set Variable	         5
    Login               ${USER1_NAME}            ${USER1_PASSWORD}                   ${USER1_SHORT}
    Pridat do kosiku    ${ZBOZI01_NAME}          ${ZBOZI01_ID}                       ${kusu}
    Click               ${SEL_CartContent}
    Take Screenshot
    Take Screenshot
    Odebrat z kosiku    ${kusu}
    Take Screenshot
    Take Screenshot
    Logout
    Take Screenshot
    Take Screenshot

*** Keywords ***
Login
    [Arguments]                 ${Email}                            ${Heslo}                                ${Text}
    Set Browser Timeout         20                                  #20s je vhodné pro rohlik.cz
#    Open Browser                ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page                    ${URL}
    Get Title                   contains                            ${TEXT_MainTitle}
    Cookie                      AcceptAll
    Click                       ${SEL_HeaderLogin}
    Type Text                   ${Sel-4}                           ${Email}
    Type Text                   ${Sel-5}                 ${Heslo}
    Click                       ${SEL_BtnSignIn}
    Get Text                    ${SEL_HeaderLoginErrorTxt}           contains                                ${Text}

Logout
    Click               ${SEL_HeaderLoginErrorTxt}
    Click               ${SEL_UserBoxLogoutBtn}

Pridat do kosiku
    [Arguments]         ${Zbozi}                    ${produkt_id}        ${Kusu}
    Type Text           ${SEL_SearchGlobal}         ${Zbozi}
    Sleep               1                           # statický timeout
    Click               ${SEL_BtnSearchGlobal}      # tlačítko Hledat
    Sleep               5                           # statický timeout
    Click               css=[${SEL_ProductID}="${produkt_id}"][${SEL_BtnAdd}]
    Sleep               1
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               css=${SEL_CssForAdding} [${SEL_ProductID}="${produkt_id}"][${SEL_BtnPlus}]           clickCount=${Pocet}
    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    ${SEL_Cart}
    Log                 ${cart_text}
    Get Text            ${SEL_Cart}                 matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot

Odebrat z kosiku
    [Arguments]                 ${Kusu}
    Take Screenshot
    ${old_mode} =       Set Strict Mode             False                       # zapamatovat původní nastavení
    Click               ${SEL_BtnMinus}             clickCount=${Kusu}
    Set Strict Mode     ${old_mode}
    Take Screenshot
    Sleep               3                                                       # statické čekání
    Take Screenshot
    Go to               ${URL}
    Take Screenshot

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END

    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko




