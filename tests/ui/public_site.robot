*** Settings ***
Resource          ../../resources/web.resource
Suite Setup       Open GimmeJob In Browser
Suite Teardown    Close GimmeJob Browser

*** Test Cases ***
Home Page Shows Project Purpose
    [Tags]    ui    smoke
    Get Text    h1    ==    Why I created this site

Robot Framework Learning Page Is Reachable
    [Tags]    ui    regression
    Open Robot Framework Learning Path
    Get Text    h1    ==    Test automation learning path
    Get Url    *=    /learn/automation
