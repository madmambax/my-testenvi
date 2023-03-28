*** Settings ***
Library    json_validate_schema.py

*** Keywords ***
Validate Schema
    [Arguments]    ${input_Json}  ${reference_Schema_Path}
    Log To Console    Validating the JSON Schema!
    Validate Json Schema    ${input_Json}  ${reference_Schema_Path}