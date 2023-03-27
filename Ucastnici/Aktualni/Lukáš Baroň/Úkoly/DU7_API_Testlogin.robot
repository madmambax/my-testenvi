*** Settings ***
Library	 RequestsLibrary
Library  String
Resource  ./Projekt/Data_Testlogin.robot

*** Test Cases ***

    #Iteruje přes kombinace jména a hesla

#    ${list_name}  Create List  admin  novak  novaknova1novaknova2novaknova3novaknova4novaknova5  ADMIN
#    ${list_psw}  Create List  tajnenovak  tajneadmin  tajnenovaktajnenovaktajnenovaktajnenovaktajnenovak  TAJNENOVAK
#    FOR    ${element_name}    IN    @{list_name}
#        FOR    ${element_psw}    IN    @{list_psw}
#            API Comunication  ${element_name}  ${element_psw}  Chrome 101.0.4951.67  200
#        END
#    END

Test 01
    API Comunication  name=novak                            password=tajnenovak                                  useragent=Chrome 101.0.4951.67  error_resp=200  status_resp=2
Test 02
    API Comunication  name=admin                            password=tajneadmin                                  useragent=Chrome 101.0.4951.67  error_resp=200  status_resp=2
Test 03
    API Comunication  name=novak                            password=TAJNENOVAK                                  useragent=Chrome 101.0.4951.67  error_resp=200  status_resp=4
Test 04
    API Comunication  name=NOVAK                            password=tajnenovak                                  useragent=Chrome 101.0.4951.67  error_resp=200  status_resp=2
Test 05
    API Comunication  name=admin                            password=tajneadmin                                  useragent=Firefox 111.0.1       error_resp=200  status_resp=2
Test 06
    API Comunication  name=${EMPTY}                         password=tajnenovak                                  useragent=Chrome 101.0.4951.67  error_resp=200  status_resp=4
Test 07
    API Comunication  name=novak                            password=${EMPTY}                                    useragent=Chrome 101.0.4951.67  error_resp=200  status_resp=4
Test 08
    API Comunication  name=novaknova1novaknova2novaknova3   password=tajnenovak                                  useragent=Chrome 101.0.4951.67  error_resp=200  status_resp=4
Test 09
    API Comunication  name=novak                            password=tajnenovaktajnenovaktajnenovak              useragent=Chrome 101.0.4951.67  error_resp=200  status_resp=4
Test 10
    API Comunication  name=${EMPTY}                         password=${EMPTY}                                    useragent=Chrome 101.0.4951.67  error_resp=200  status_resp=4


*** Keywords ***
API Comunication
    [Arguments]  ${name}  ${password}  ${useragent}  ${error_resp}  ${status_resp}

    ${json}=     catenate  {"username":"${name}","password":"${password}","useragent":"${useragent}"}
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Status Should Be     ${error_resp}
    Should Start With    ${resp.json()}[response]    ${status_resp}

