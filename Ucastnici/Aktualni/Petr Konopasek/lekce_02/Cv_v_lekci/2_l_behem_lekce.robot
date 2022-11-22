*** Variables ***
${GREET1}     Středa
${GREET2}     Čtvrtek
${GREET3}     Pátek

*** Test Cases ***
Ukázka práce s konstatny
    Log to console  ${\n}${GREET1}, ${GREET2}
    Log to console  ${GREET3}
    Log to console  ${GREET1}

Seznamy
    @{zbozi} =   Create List  okurak  paprika  rajce  mrkev  # Okurak me pobavil :)
    Log To Console      ${zbozi}[3]
    Log Many  @{zbozi}


Slovniky
    &{ceny} =  Create Dictionary  oregano=49  feta=99  olivy=88
    Log To Console    ${\n}Cena fety = ${ceny.feta} Czk
    Log To Console    ${\n}Cena oregano = ${ceny}[oregano] Czk
    Log To Console    ${\n}Cena olivy = ${ceny}[olivy] Czk
    Log Many          ${\n}&{ceny}

promenna sys

      Log to console   ${\n}%{USERNAME}
      Log to console   %{os}
      Log Variables

