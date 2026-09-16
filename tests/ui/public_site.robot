*** Settings ***
Resource          ../../resources/web.resource
Suite Setup       Open GimmeJob In Browser
Suite Teardown    Close GimmeJob Browser

*** Test Cases ***
Home Page Shows Project Purpose
    [Tags]    ui    smoke
    Get Text    h1    *=    CREATED THIS SITE

Robot Framework Learning Page Is Reachable
    [Tags]    ui    regression
    Open Robot Framework Learning Path
    Get Element Count    role=heading[name="Test automation learning path"]    ==    1
    Get Url    *=    /learn/automation
