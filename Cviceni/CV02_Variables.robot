#
# Příklad na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Ukázka práce s promennými



*** Variables ***
#1. způsob zápisu
${GREET}     Hello
${NAME}      Daniel

#2. způsob zápisu
${GREET2} =  Hello


*** Test Cases ***
Test Konstatny
    Log to console  -
    Log to console  Hello
    Log to console  Hello, world!!


Test proměné typu Scalar
    Log to console  ${GREET}
    Log to console  ${GREET2}
    Log to console  ${GREET}, ${NAME}!!


Test nastavení proměné
    ${x} =          Set Variable    10
    Log to console  Jakou má hodnot proměná \${x}: ${x}!


Test čísel
    Log to console  10

Test promné typu List
    @{list1} =      Create List    first    second    third
    Log to console  ${list1}[1]

    ${list2} =      Evaluate    ['a', 'b', 'c']

    ${list3} =      Evaluate    [['a', 'b', 'c'], {'key': ['x', 'y']}]
    Log Many        @{list3}[0]         # Logs 'a', 'b' and 'c'.
    Log Many        @{list3}[1][key]    # Logs 'x' and 'y'.


Test promné typu Dictionary
    &{Dict} =	    Create Dictionary	key=value	foo=bar
    Log Many        &{Dict}         #zalogování celeho slovníku (Dictionary)
    Log Many        ${Dict.key}     #zalogování kokrétní hodnoty ze slovníku (Dictionary)


Test promné typu Environment
    Log to console  Username %{USERNAME}
    Log to console  OS %{OS}
    Log to console  Path = %{PATH}
    Log to console  Computer name %{COMPUTERNAME}
    Log to console  Number of processors %{NUMBER_OF_PROCESSORS}
