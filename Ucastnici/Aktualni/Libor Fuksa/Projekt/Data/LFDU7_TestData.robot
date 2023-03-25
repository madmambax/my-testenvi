#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***

${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php

${hodneznaku}        VlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfg
${ico_valid}         27232433
${ico_invalid_9int}  272324332
${ico_invalid_char}  272k2433
${ico_invalid_spec_char}  272k2433


${comment1}          Opravdu nevím, co jsem mám psát. +ěšččřžžýáíé$}{

${name_s_mezerou}    Franta Pepa Jednicka

${email_kratky}      a@b.z
${email_NOK_uziv_jmeno}     @ab.z
${email_NOK_chybi-@}     frantaab.z
${email_NOK_chybi-.}     Tomas@marnycz
${email_NOK_chybi-pripona}     Tomas@marny.

${phone_+420}        +420123456789
${phone_13cislic}    1420123456789
${phone_10cislic}    9234567895
${phone_8cislic}     23456789
${phone_char}        2345g6789