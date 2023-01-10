*** Settings ***
Resource  keywords.robot


*** Test Cases ***

Registrace na kurz fyzicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  200
Registrace na kurz pravnicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false  200
Registrace na kurz háčky a čárky
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  200

Registrace na kurz zahranicni cislo
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  30901820  fyz  Udolni 21, Brno  1  komentar  false  500
Registrace na kurz zahranicni cislo s predvolbou
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  +3830901820  fyz  Udolni 21, Brno  1  komentar  false  500
Registrace na kurz nulovy pocet
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  30901820  fyz  Udolni 21, Brno  0  komentar  false  500
Registrace na kury spatne cislo kurzu
    Registrace na kurz  0  Jan787878  Novak  jan.novak@abc.cz  30901820  fyz  Udolni 21, Brno  0  komentar  false  500
Registrace na kurz dlouhe jmeno
    Registrace na kurz  2  Janjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjan787878janjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjan787878janjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjan787878janjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjanjan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  200

