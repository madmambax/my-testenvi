*** Comments ***
Dokumentace ke klíč. slovu Log>
https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Log
Dokumentace ke klíč. slovu Set Log Level>
https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Set%20Log%20Level

*** Test Cases ***
Pokusy s logovanim
    Log    Defaultni (INFO) level.
    Log    ERROR <b>level loguje</b> pouze chyby (nejdůležitější věci).                            error       html=yes
    # Argument 'html' se projevuje v zalogovaný zprávě v log file (v consoli neé).
    Log    Level WARN by <b>měl logovat chyby</b> a varovani/upozorneni.                                    warn        html=true
    Log    <b>Na zprávy zalogované</b> v HTML levelu je možné použít hmtl tagy.                     HTML
    # Zalogovaná zpráva se loguje v level INFO - proč?
    # Ten argument 'HTML' znamená, že se zalogovaná zpráva v log file může zobrazit jako html, ale i tak to bude pořád  log level INFO.
    Log    ${\n}DEBUG level je vhodný/určený pro debugování.                                          DEBUG       console=True
    Log    TRACE je nejpodrobnější úroveň logování.                                                   TRACE       console=yes
    #1 Všechny hodnoty argumentu 'level' klíč. slova 'Log' (tj. error, warn, html, info, debug, trace) jsou case insensitive.
    #2 level=error se dá zkrátit na>
    #2 error    (to platí i pro ostatní log levely)
    #3 Log levely 'error' a 'warn' vypisují zalogované zprávy automaticky i do console.
    #3 U ostatních log levels to tak není - u nich je potřeba to zadat jako další argument klíč. slova 'Log' (console=True)



