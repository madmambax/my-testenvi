*** Variables ***

#Error strings
${ERROR_TEXT_BadSigning}   Přihlášení neproběhlo

#Sellectors
${SEL_LoginOtherVariant}    id=other-variant
${SEL_LoginUsername}        id=username
${SEL_LoginPassword}        id=password
${SEL_LoginButton}          id=logginButton
# ${SEL_LoginVallidation}     //span[text()="${validation}"]              -- toto nejde, protože tam mám proměnnou. Vyřešit jinak.
${SEL_LoginVallidationBad}  id=modal
${SEL_Logout}               //div[text()="Odhlásit se"]
${SEL_Car}                  id=ready.cardArt.car
${SEL_RegPlate}             id=regPlate
