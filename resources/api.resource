*** Settings ***
Library      RequestsLibrary
Library      ../libraries/ProjectLibrary.py
Variables    ../variables/default.py

*** Keywords ***
Health Check Should Pass
    ${response}=    GET    ${BASE_URL}/api/health    expected_status=200
    Response Should Be Healthy    ${response}
