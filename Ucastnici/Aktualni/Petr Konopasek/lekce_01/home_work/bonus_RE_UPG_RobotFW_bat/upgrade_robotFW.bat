ECHO 01 - Upgrade RobotFW"
ECHO 02 - Upgrade Robot Framework - browser"
ECHO 03 - Log_clean_node_RoFW-browser
ECHO 04 - rfbrowser init
ECHO -------------------------

ECHO ***Upgrade Robot Framework***

pip install robotframework --upgrade > 01-Log_upgrade_RoFW.txt

Upgrade Robot Framework .....Completed


ECHO  *** Upgrade Robot Framework - browser ***

pip install --upgrade robotframework-browser > 02-Log_upgrade_RoFW-browser.txt

ECHO Upgrade Robot Framework Browser.....Completed


ECHO  *** rfbrowser clean-node ***

rfbrowser clean-node > 03-Log_clean_node_RoFW-browser.txt

ECHO rfbrowser clean-node.....Completed


ECHO  *** rfbrowser init ***

rfbrowser init > 04-Log_init_RoFW-browser.txt

ECHO rfbrowser init.....Completed

ECHO -----------
ECHO    Finish
ECHO -----------

