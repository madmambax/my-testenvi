*** Settings ***
Library  OperatingSystem


*** Test Cases ***

Prvý test pozitívny
    ${output} =         Run                 help
    Log To Console      ${\n}${output}
    Should Contain      ${output}           For more information on a specific command, type HELP command-name

Druhý test negatívny
    ${output} =         Run                 help
    Log To Console      ${\n}${output}
    Should Contain      ${output}           For more informatioooon on a specific command, type HELP command-name

Druhý test pozitívny
    Create file                 C:\Users\JHruba\PycharmProjects\jak_automatizovat_testy\Ucastnici\Aktualni\Jana_Hruba\\TestovaciText.txt
    File should be empty        C:\Users\JHruba\PycharmProjects\jak_automatizovat_testy\Ucastnici\Aktualni\Jana_Hruba\\TestovaciText.txt



