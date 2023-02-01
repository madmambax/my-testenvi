#
# Příklad na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Ukázka práce s promennými
Library           OperatingSystem
Library	          Collections



*** Variables ***
#1. způsob zápisu
${GREET}     Hello
${NAME}      Daniel

#2. způsob zápisu
${GREET2} =  Hello

#vytvoření seznamu v sekci Variables
@{list} =	jablko  hruška  banán  citron  pomeranč

#vytvoření slovníku v sekci Variables
&{dictionary} = 	login=franta	heslo=tajne

*** Test Cases ***
Ukázka práce s konstatny
    Log to console  -
    Log to console  Hello
    Log to console  Hello, world!!


Ukázka práce s proměnnu typu Scalar
    Log to console  ${GREET}
    Log to console  ${GREET2}
    Log to console  ${GREET}, ${NAME}!!


Ukázka práce nastavení proměnné
    ${x} =          Set Variable                                        10
    Log to console  ${\n}Jakou má hodnot proměnná \${x}: ${x}
    ${text} =       Set Variable                                        Tady bude nejaky text
    Log to console  ${\n}Jakou má hodnutu proměnná \${text}: ${text}


Ukázka práce s čísely
    ${x} =          Set Variable    10
    ${y} =          Set Variable    3
    ${v} =          Evaluate    ${x}*${y}
    Log to console  Vysledek: ${v}
    Log             Vysledek: ${v}


Ukázka práce s proměnnu typu List
    @{list1} =      Create List    first    second    third
    Log to console  ${list1}[1]
    Log to Console  ${list}[2]

    ${list2} =      Evaluate    ['a', 'b', 'c']

    ${list3} =      Evaluate    [['a', 'b', 'c'], {'key': ['x', 'y']}]
    Log Many        @{list3}[0]         # Logs 'a', 'b' and 'c'.
    Log Many        @{list3}[1][key]    # Logs 'x' and 'y'.
    # hodí se např. na ukládání údajů z webu (uložení seznamu prvků)


Ukázka práce s proměnnu typu Dictionary
    &{Dict} =	    Create Dictionary	key=value	foo=bar
    Log Many        &{Dict}         #zalogování celeho slovníku (Dictionary)
    Log Many        ${Dict.key}     #zalogování kokrétní hodnoty ze slovníku (Dictionary)
    # hodí se na předávání parametrů klíčovým slovům a configuraci
    Log Many        &{dictionary}
    Log to Console  ${dictionary}[login]    #1. způsob zápisu
    Log To Console  ${dictionary.login}     #2. způsob zápisu
    #Příklad: TestLogin a KS Login - JSON se ukládá do dictionary

    &{dict} =  Create Dictionary  jablko=10  pomeranc=20.542424
    Log to Console  ${dict}[pomeranc]    #1. způsob zápisu
    Log to Console  ${dict.pomeranc}     #2. způsob zápisu


Ukázka práce s proměnnu typu Environment
    Log to console  Username %{USERNAME}
    Log to console  OS %{OS}
    Log to console  Path = %{PATH}
    Log to console  Computer name %{COMPUTERNAME}
    Log to console  Number of processors %{NUMBER_OF_PROCESSORS}
    #hodí se na parametrizaci testů z OS


#Příklad: Načtení souborů z adresáře a uložení do seznamu (List)
Test načtení souborů z adresáře
    @{files} =	                List Files In Directory     /Test       *.log
    Log Many                    @{files}

    #Vyhodnocení testu
    List Should Contain Value   ${files}                    procesy.log


#Příklad:   Výpis síťových karet podle OS (ipconfig vs ifconfig)
#           nastavené proměnné
#           výstup do konzole
#           výstup do logu
#           využití promné prostředí
#           porovnání proměnných
Test sítě nezávislý na OS
    Log to console      OS = '%{OS}'
    # porovnání řetězců musí být v apostrofech '%{OS}'
    ${ifconfig_cmd} =	Set Variable If     '%{OS}' == 'Windows_NT'     ipconfig	    ifconfig

    # spustí přikaz podle typu OS
    ${output} =         Run                 ${ifconfig_cmd}
    #zapíše výstup příkazu do logu
    Log                 ${output}

    #Vyhodnocení testu
    Should Contain      ${output}           Ethernet

Datove konverze
    ${cele_cislo} =        Set Variable    10
    ${desetine_cislo} =    Set Variable    3.1415
    ${retezec} =           Set Variable    Ahoj
    Should Be Equal As Integers	    10	    ${cele_cislo}
#ERROR    Should Be Equal As Integers	3.1415	${desetine_cislo}
    Should Be Equal As Numbers 	    3.1415	${desetine_cislo}
#ERROR    Should Be Equal As Integers	Ahoj	${retezec}
    Should Be Equal As Strings      Ahoj        ${retezec}

    ${retezec} =           Set Variable    3.1415
    ${cislo} =             Convert To Number       ${retezec}
    Should Be Equal As Numbers 	    3.1415	    ${cislo}

#  Podobně se dá konvertovat na Integer nebo řetězec
#         Convert To Integer
#         Convert To String

