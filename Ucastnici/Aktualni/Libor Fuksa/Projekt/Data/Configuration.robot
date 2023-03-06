#*** Variables ***
# Tento soubor obsahuje URL, nastaveni prohlizece, timeouty, cookies
#

*** Variables ***
${URL}                  https://www.rohlik.cz
${URL_CART}             https://www.rohlik.cz/objednavka/prehled-kosiku
${BROWSER}              Chromium

${COOKIES}              NO
# COOKIES == NO - odmítnout // YES - povolit všechny //


${TIME_BETWEEN_CHECKS}  200ms
${TIMEOUT_BROWSER}       20s
# Pro dynamické čekání, jestli se mi to povede nastavit :)

#--------------------------------------------
# PRO TESTY
${POCET}                3
# Kolik ks se bude pridavat do kosiku

#----------------------
#${PORT}                 80
#${URL_cart}             https://www.rohlik.cz/objednavka/prehled-kosiku#cartReviewMainTitle
#
#${TIME_BETWEEN_CLICKS}  100ms
#${TIME_BETWEEN_CHECKS}  200ms
#
#
#${TIMEOUT_BROWSER}      18 s
#${TC_TIMEOUT_ROBOT_KW}  2 minutes