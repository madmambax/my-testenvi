#
# Příklad na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Ukázka práce s promennými
Library           OperatingSystem



*** Variables ***
#1. způsob zápisu
${GREET}     Hello
${NAME}      Daniel

#2. způsob zápisu
${GREET2} =  Hello



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
    ${x} =          Set Variable    10
    Log to console  ${\n}Jakou má hodnot proměnná \${x}: ${x}
    ${text} =       Set Variable    Tady bude nejaky text
    Log to console  ${\n}Jakou má hodnutu proměnná \${text}: ${text}


Ukázka práce s čísely
    ${x} =          Set Variable    10
    ${y} =          Set Variable    3
    ${v} =          Evaluate    ${x}*${y}
    Log to console  Vysledek: ${v}


Ukázka práce s proměnnu typu List
    @{list1} =      Create List    first    second    third
    Log to console  ${list1}[1]

    ${list2} =      Evaluate    ['a', 'b', 'c']

    ${list3} =      Evaluate    [['a', 'b', 'c'], {'key': ['x', 'y']}]
    Log Many        @{list3}[0]         # Logs 'a', 'b' and 'c'.
    Log Many        @{list3}[1][key]    # Logs 'x' and 'y'.
    # hodí se na ???

    #Příklad: ?




Ukázka práce s proměnnu typu Dictionary
    &{Dict} =	    Create Dictionary	key=value	foo=bar
    Log Many        &{Dict}         #zalogování celeho slovníku (Dictionary)
    Log Many        ${Dict.key}     #zalogování kokrétní hodnoty ze slovníku (Dictionary)
    # hodí se na ředávání parametrů klíčovým slovům
    # configuraci

    #Příklad: TestLogin a KS Login - JSON se ukládo do dictionary


Ukázka práce s proměnnu typu Environment
    Log to console  Username %{USERNAME}
    Log to console  OS %{OS}
    Log to console  Path = %{PATH}
    Log to console  Computer name %{COMPUTERNAME}
    Log to console  Number of processors %{NUMBER_OF_PROCESSORS}
    #hodí se na parametrizaci testů z OS

    #Příklad: Výpis síťových karet podle OS (ipconfig vs ifconfig)

Test sítě nezávislý na OS
    Log to console  OS = '%{OS}'
    # porovnání řetězců musí být v apostrofech '%{OS}'
    ${ifconfig_cmd} =	Set Variable If  '%{OS}' == 'Windows_NT'  ipconfig	ifconfig

    # spustí přikaz podle typu OS
    ${output} =     Run     ${ifconfig_cmd}
    #zapíše výstup příkazu do logu
    Log             ${output}

*** Keywords ***
