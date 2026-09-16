*** Settings ***
Library      Browser    timeout=10s
Variables    ../variables/default.py

*** Keywords ***
Open GimmeJob In Browser
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context
    New Page    ${BASE_URL}

Close GimmeJob Browser
    Close Browser

Open Robot Framework Learning Path
    Go To    ${BASE_URL}/learn/automation?track=robot-framework&topic=robot-framework
