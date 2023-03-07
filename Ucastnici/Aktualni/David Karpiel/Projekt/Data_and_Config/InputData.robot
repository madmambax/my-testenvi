
*** Variables ***

#Configuration

${ENVIRONMENT} =     qa
&{BASE_URL}          qa=https://www.alza.cz/
${LOGIN_URL} =       external/login?inherit=true
${BROWSER} =         chromium
${URL_TITLE} =       Alza.cz

#Search product
${SEARCH_TERM} =  notebook

#Valid "sign in" data

${LOGIN_EMAIL} =      todaxi4079@rolenot.com
${LOGIN_PASSWORD} =   Password123

#Invalid "sign in" data

${ERROR_TEXT} =      Neplatné uživatelské jméno nebo heslo

&{INVALID_LOGIN}     Email=Honza@gmail.com    Password=jhjhjhjhgk123        ExpectedErrorMessage=${ERROR_TEXT}
&{INVALID_EMAIL}     Email=Pepa@seznam.cz     Password=${LOGIN_PASSWORD}    ExpectedErrorMessage=${ERROR_TEXT}
&{INVALID_PASSWORD}  Email=${LOGIN_EMAIL}     Password=JGZJZUGHHJJKG        ExpectedErrorMessage=${ERROR_TEXT}
&{BLANK_FIELDS}      Email=                   Password=                     ExpectedErrorMessage=Zadejte e-mailovou adresu