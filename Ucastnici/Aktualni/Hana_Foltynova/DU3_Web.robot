*** Settings ***
Library     OperatingSystem
Library	    Collections
Library	    Browser
Library	    String

*** Variables ***
${URL} =  https://www.rohlik.cz/ 
@{randomPassw}=    Create List    nesmyslneheslo    nesmyslnehesločísldvje    srhdgnkjmhgjgegrnsfmldhygnkfm    shdgfjghfjghjhg    fghfjghjghkgjkhive   wčžeřýržátýízáoiuo
@{randomMail}=    Create List    nesmyslny@mail.cz    nesmyslny@mail.cz    nesmyslny@mail.cz    nesmyslny@mail.cz    nesmyslny@mail.cz   nesmyslny@mail.cz
