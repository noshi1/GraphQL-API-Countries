*** Settings ***
Library            Collections
Library            RequestsLibrary
Library            DateTime
Library            String

Documentation      GraphQL API Calls for the application stored in this file

*** Variables ***

*** Keywords ***
Post Response
    [Documentation]     Returns the response of the post Request
    [Arguments]         ${url}
    
    ${headers}=    Create Dictionary    Content-Type=application/json

    ${body}=       Create dictionary   query= query {countries {name}country(code:"US") {name, native, capital, emoji, currency, languages {code, name}states{name, code}}}
    Create Session     mysession    ${url}    ${headers}    timeout=100    verify=true

    ${response}=    POST On Session    mysession   ${url}    json=${body}       expected_status=200
    Log    RESPONSE: ${response}      console=true
    Log    JSON:${response.json()}    console=true

    Delete All Sessions
    [Return]      ${response.json()}

TestCaseSetup
    [Documentation]    common initialization for UI and API test cases
    ${TESTCASE_EPOCH_STARTTIME}=    Get Time    epoch   
    #Set Global Variable    ${TESTCASE_EPOCH_STARTTIME}
    
TestCaseTeardown
    [Documentation]    placeholder common teardown for UI and API test cases
    Log    TestCaseTeardown
    
SuiteSetup
    [Documentation]    common initialization for UI and API test suites
    Log    Open DB connection
    
SuiteTeardown
    [Documentation]    common teardown for UI and API test suites
    Log    Close DB connection