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
    Log to console  Jakou má hodnot proměná \${x}: ${x}!


Ukázka práce s čísely
    Log to console  10

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

    #Příklad: ?


Ukázka práce s proměnnu typu Environment
    Log to console  Username %{USERNAME}
    Log to console  OS %{OS}
    Log to console  Path = %{PATH}
    Log to console  Computer name %{COMPUTERNAME}
    Log to console  Number of processors %{NUMBER_OF_PROCESSORS}
    #hodí se na paramerizaci testů z OS

    #Příklad: Výpis síťových karet podle OS (ipconfig vs ifconfig)



*** Keywords ***
