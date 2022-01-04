*** Settings ***
Library     OperatingSystem
Library	    Collections
Library	    Browser
Resource    Data/TestData.robot
Resource    Config/TestConfig.robot

*** Variables ***




*** Test Cases ***
Ukázka práce s \${URL}
    Log to console  ${\n}Testujeme ${URL}!!
