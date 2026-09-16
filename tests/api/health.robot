*** Settings ***
Resource    ../../resources/api.resource

*** Test Cases ***
Production Health Endpoint Is Healthy
    [Tags]    api    smoke
    Health Check Should Pass
