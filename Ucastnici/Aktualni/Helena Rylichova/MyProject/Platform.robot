*** Settings ***
Library     Browser
Resource    resourcesUI.robot

*** Variables ***

*** Test Cases ***
Login Valid Credentials
    Open Browser To Login Page
    Open Particular School
    Insert valid credentials
    Platform - Main Page assertion