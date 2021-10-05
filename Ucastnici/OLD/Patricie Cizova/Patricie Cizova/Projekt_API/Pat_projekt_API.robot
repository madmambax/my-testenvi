"""

Testovani The Testing World
Detaily studentů

"""


*** Settings ***
Library     Browser
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary

Resource        Pat_Projekt_API_Configuration.robot

Test Setup      Pred_testem
Suite Teardown  Uklid_sada

*** Variables ***


*** Test Cases ***

Get_request_list_of_students
    Create Session      Student_Details_ID      ${URL}
    Sleep               2
    ${Get_Resp}=        Get on Session          Student_Details_ID      ${API}
    Sleep               2
    Log to console      ${Get_Resp.status_code}
    Log to console      ${Get_Resp.content}
    Should Be Equal As Strings	${Get_Resp.status_code}     200


Get_request_ID_OK
    Create Session      Student_Details_ID      ${URL}
    ${Get_Resp}=        Get on Session          Student_Details_ID      ${API}/273083
    Log to console      ${Get_Resp.status_code}
    Log to console      ${Get_Resp.content}
    Should Be Equal As Strings	${Get_Resp.status_code}     200


Get_request_zaporne_ID
    Create Session      Student_Details_ID      ${URL}
    ${Get_Resp}=        Get on Session          Student_Details_ID      ${API}/-100001
    Log to console      ${Get_Resp.status_code}
    Log to console      ${Get_Resp.content}
    Should Be Equal As Strings	${Get_Resp.status_code}     200


Get_request_neexistujici_ID
    Create Session      Student_Details_ID      ${URL}
    ${Get_Resp}=        Get on Session          Student_Details_ID      ${API}/100002
    Log to console      ${Get_Resp.status_code}
    Log to console      ${Get_Resp.content}
    Should Be Equal As Strings	${Get_Resp.status_code}     200


Get_request_string_ID_NOK
    Create Session      Student_Details_ID      ${URL}
    ${Get_Resp}=        Run Keyword And Expect Error    HTTPError: 400 Client Error:*    Get on Session          Student_Details_ID      ${api}/chyba
    Log to console      ${Get_Resp}


Get_data_from_request
    Create Session      Student_Details_ID      ${URL}
    ${Get_Resp}=        Get on Session          Student_Details_ID      ${API}/327564
    ${json_response}=   set variable            ${Get_Resp.json()}  # tohle převede json na dictionary
    Log to console      ${json_response}  # tady se můžeš podívat jak vypadá v logu

    ${first_name_data}=  Set Variable   ${json_response}[data][first_name]

    Log to console      ${first_name_data}
    Should Be Equal     ${first_name_data}               Gillian


Add_new_student
    New student     Mike    Louise      Forsyth         17/01/1993


Updated_student
    Updated student     273092      Louise_Second


Delete_student
    Delete student     8

****** Keywords ***

New student
    [Arguments]         ${first_name}       ${middle_name}      ${last_name}        ${date_of_birth}
    Create Session      New_Student      ${URL}
    &{body}=            Create Dictionary   first_name=${first_name}        middle_name=${middle_name}      last_name=${last_name}      date_of_birth=${date_of_birth}
    ${Post_Resp}=       Post on Session          New_Student      ${API}    data=${body}
    Log to console      ${Post_Resp.status_code}
    Log to console      ${Post_Resp.content}
    Should Be Equal As Strings	${Post_Resp.status_code}     201


Updated student
    [Arguments]         ${id}           ${middle_name}
    Create Session      Updated_Student         ${URL}
    &{body}=            Create Dictionary       id=${id}   middle_name=${middle_name}
    ${Put_Resp}=        Put on Session           Updated_Student      ${API}/${id}    data=${body}
    Log to console      ${Put_Resp.status_code}
    Log to console      ${Put_Resp.content}
    Should Be Equal As Strings	${Put_Resp.status_code}     200


Delete student
    [Arguments]         ${id}
    Create Session      Delete_Student         ${URL}
    &{body}=            Create Dictionary       id=${id}
    ${Del_Resp}=        Delete on Session           Delete_Student      ${API}/${id}    data=${body}
    Log to console      ${Del_Resp.status_code}
    Log to console      ${Del_Resp.content}
    Should Be Equal As Strings	${Del_Resp.status_code}     200

Pred_testem
    New Page                ${URL}
    Set Browser Timeout     20

Uklid_sada
    Close Page          ${URL}

