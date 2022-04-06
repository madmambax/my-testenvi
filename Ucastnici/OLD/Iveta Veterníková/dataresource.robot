*** Variables ***
${email}        radek.tester@seznam.cz
${password}     tajneheslotajneheslo
${password2}    spatneheslospatneheslo
${inicial}      JT   

# url a browsery
${url_rohlik}   https://www.rohlik.cz/
${browser1}     chromium

# click
${headerlogin}             xpath=//*[@id="headerLogin"]
${headerlogin/div}         xpath=//*[@id="headerUser"]/div  
                            
${idemail}                 id=email
${idpassword}              id=password 
${sign}                    data-test=btnSignIn  

# type text
${inputemail}              input#email     
${inputpassword}           input#password    

# get text
${icon}                    data-test=header-user-icon        
