*** Settings ***
Library     OperatingSystem
Library	    Collections
Library	    Browser
Resource    Data_and_Config/TestData.robot

*** Variables ***




*** Test Cases ***
Ukázka práce s \${URL}
    Log to console  ${\n}Testujeme ${URL}!!
