*** Settings ***
Library      ../../libraries/ProjectLibrary.py
Variables    ../../variables/default.py

*** Test Cases ***
Build URL Handles Slash Boundaries
    [Tags]    core    smoke
    ${url}=    Build URL    ${BASE_URL}/    /api/health
    Should Be Equal    ${url}    ${BASE_URL}/api/health

Default Base URL Uses HTTPS
    [Tags]    core
    Should Start With    ${BASE_URL}    https://
