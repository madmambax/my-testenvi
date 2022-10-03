*** Comments ***

*** Settings ***
Library     OperatingSystem
Library    Collections
Library    Process
Library    Browser

*** Test Cases ***
1. Prvni_testy
    [Documentation]    Prvni pokusy s knihovnou 'OperatingSystem'
    [Tags]              funkční

    ${Result}   Run                 help
    Log To Console    ${\n}Result:${Result}

    ${Res}  Run And Return Rc And Output    help
    Log To Console    ${\n}Res:${Res}

#    ${Res3}  Run Process     help   # Je potřeba knihovna 'Process'.   ## Nefunguje. Proč? Kouknout do Log File.
#    Log To Console    ${\n}Res3:${Res3}

2. Spojovani-retezcu
    [Documentation]    Zkouska klic. slova 'Catenate'
    [Tags]    Neunkční

    ${SpojovaniStringu}=    Catenate    SEPARATOR=++    Hello   Darkness    My  Old     Friend
    Log To Console    ${\n}${SpojovaniStringu}

    ${Prvni}=    Set Variable    prvni
    ${Druhe}=    Set Variable    druhe
    ${Spojeni1}=    Set Variable    ${Prvni}   {Druhe}  # Dvě anebo více mezer mezi argumenty a výsledek se zapisuje do hranatých závorek a položky jsou od sebe odděleny čárkou
    Log To Console   ${\n} ${Spojeni1}

    ${Spojeni2}=    Set Variable    ${Prvni}{Druhe}     # Žádná nebo jedna mezera mezi argumenty a výsledek se zapisuje bez jakýchkoli závorek a bez oddělení čárkou.
    Log To Console   ${\n} ${Spojeni2}


3. Vytahování dat z proměnné typu 'slovník'
    [Documentation]    Jak vytáhnout klíč/hodnotu/položku ze slovníku?
    [Tags]              Funkční
    &{Dictionary}=          Create Dictionary   Key1=Value1     Key2=Value2     Key3=${EMPTY}   Key4=${TRUE}    Key5=${FALSE}
    Log Many      &{Dictionary}  # Klíč. slovo 'Log To Console' je nepoužitelné pro vypsání proměnmné typu 'slovník'.
    # Klíč. slovo 'Log Many' loguje pouze do Log File (a to ještě za určitých podmínek/při určitých úrovních logování) - nedokáže logovat do Console.

    Log To Console    ${\n}${Dictionary}[Key1]
    Log To Console    ${Dictionary}[Key2]
    Should Be Equal   ${Dictionary}[Key2]   Value2      #1 Assert I.

    Log To Console    ${Dictionary.Key1}
    Log To Console    ${Dictionary.Key2}
    Should Be Equal   ${Dictionary.Key2}   Value2      #2 Assert II.

    Dictionary Should Contain Item       ${Dictionary}  Key1  Value1     #3 Assert III.
    Dictionary Should Contain Key        ${Dictionary}  Key1             #4 Assert IV.
    Dictionary Should Contain Value      ${Dictionary}  Value1            #5 Assert V.

4. Run Keyword And Expect Error

5. Library_Browser_Basics
    [Documentation]    Klíč. slova 'New Browser', 'New Page', 'Take Screenshot'
    [Tags]              Funkční
    New Browser    browser=firefox  headless=false
    # New Context    screen={'width': 1035, 'height': 2245}      # Chybu tu žádnou nehází, ale nevidím, jak to funguje.
    # Měnil jsem šířku i výšku, ale nebyla vidět žádná změna při spuštěným testu ani ve screenshotu.
    New Page    https://kitner.cz/
#    Sleep   3      # Jenom zkouška.

    Take Screenshot
#    Take Screenshot  robotframework-browser-traces-{index}  fullPage=True  fileType=jpeg    quality=100
    # První argument dává název screenshotu. {index} by mělo znamenat, že se nepřepisujou fileName s tím jak přibývají nový screenshoty, ale zvyšuje se jenom jejich pořadový číslo (na konci fileName).
    # Druhý argument je defaultně =False.
    # Třetí argument je defaultně =png.
    # Argument 'quality' je použitelenj jenom u fileType=jpeg, tzn. že u defaultního fileType ('png') tento argument nelze použít.
    # Screenshoty se mi ukládaj do složky 'PycharmProjects/jak_automatizovat_testy/browser/screenshot'
    # A je tam vždy max. 1 screenshot - novej screenshot přepíše starej. Jde to nějak změnit? (Týká se i automaticky pořízených screenshotů při failu - viz níže.)
    # RBF dělá screenshoty automaticky, když dojde k failu a tyhle screenshoty se ale ukládají jinam - do složky 'browser' do domovského adresáře. Tohle asi nedělá přímo RBF, ale knihovna 'Browser'. Ozkoušet to!

6. Příkazy 'help' a 'dir'
    ${help}             Run    'help'               # Nefunguje. Píše toto> /bin/sh: 1: help: not found
    ${dir_--help}       Run    dir --help           # Funguje.
    ${help_help_dir}    Run    'help help dir'      # Nefunguje. Píše toto> /bin/sh: 1: /bin/sh: 1: help help dir: not found
    ${help_dir}         Run    'help dir'           # Nefunguje. Píše toto> /bin/sh: 1: help dir: not found
    ${help_nesmysl}     Run    help_nesmysl         # Nefunguje. Píše toto> /bin/sh: 1: help_nesmysl: not found
    Log To Console      ${\n}'help':${\n}${help}
    Log To Console      ${\n}'dir --help':${\n}${dir_--help}
    Log To Console      ${\n}'help help dir':${\n}${help_help_dir}
    Log To Console      ${\n}'help dir':${\n}${help_dir}
    Log To Console      ${\n}'help nesmysl':${\n}${help_nesmysl}