*** Settings ***
Library     Browser
Resource    resourcesUI.robot

*** Variables ***

*** Test Cases ***
Login Invalid Credentials
    Open Browser To Login Page
    Open Particular School
    Insert invalid Credentials

Login Valid Credentials
    Open Browser To Login Page
    Open Particular School
    Insert valid credentials
