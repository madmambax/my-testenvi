*** Settings ***
Library	 RequestsLibrary
Library	 Collections
Library  String

*** Variables ***


*** Test Cases ***
seznam
    first 

*** Keywords ***

    @{list1} =      Create List    first    second    third

    Log Many       @{list}