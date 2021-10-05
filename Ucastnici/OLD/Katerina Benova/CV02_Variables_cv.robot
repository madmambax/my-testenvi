#
# Příklad na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Ukázka práce s promennými
Library           OperatingSystem
Library	          Collections



*** Variables ***
@{listBrs}   Chrome  Edge  Firefox


*** Test Cases ***
Logy
    Log Many            @{listBrs}
    Log to console      ${\n}${listBrs}[0]


Test obsah seznamu
   # @{listBrs} =      Create List    Chrome  Edge  Firefox
    Should Contain      ${listBrs}[0]       Chrome
    List Should Contain Value   ${listBrs}  Edge
