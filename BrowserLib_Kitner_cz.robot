
*** Settings ***
Library  Browser
Library  DebugLibrary


*** Variables ***
${url}      https://kitner.cz

### Selektory

# Slektory MENU
${SEL_menu_nabidka}                 id=menu-item-838
${SEL_menu_jak_testovat}            id=menu-item-75
${SEL_menu_jsst}                    id=menu-item-4346

# Selektory na hlavni strance
${SEL_hlavni_testovani_21_stol}     css=.button-1

###

*** Test Cases ***

Jede stranka kurzu Jak se stát testerem
   New Browser    chromium    headless=false
   New Page       ${url}

   Get Title      contains    Radek Kitner

   #kliknout na menu
   Hover           ${SEL_menu_nabidka}
   Sleep           1
   Click           ${SEL_menu_jsst}

   Get Title      contains    Jak se stát testerem






