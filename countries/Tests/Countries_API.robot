*** Settings ***
Library            SeleniumLibrary
Library            OperatingSystem
Library            Collections
Library            String
Library            RequestsLibrary
Library            JSONLibrary

Resource           ../Pages/Countries.robot

Suite Setup        SuiteSetup API
Suite Teardown     SuiteTeardown API
Test Setup         TestCaseSetup

Documentation       GraphQL public countries API

*** Variables ***

*** Test Cases ***
Validate The Countries API - success reponse
    [Tags]    Countries
    log     Verify the api success response
    Verify The Countries API - success reponse

Validate The Countries List
    [Tags]    Countries
    log     Verifying the total number of countries resturned
    Verify The Countries List

Validate The Single Country Info
    [Tags]    Country
    log     Verifying the country information
    Verify The Single Country Info

Validate Countries API - failed response
    [Tags]    Country
    log     Verifying the countries api failed response
    Verify Countries API - failed response

*** Keywords ***
SuiteSetup API
    SuiteSetup
SuiteTeardown API
    SuiteTeardown
    