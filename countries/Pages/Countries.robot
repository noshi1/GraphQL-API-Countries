*** Settings ***
Library            OperatingSystem
Library            SeleniumLibrary
Library            Collections
Library            RequestsLibrary
Library            String

Resource           ../Resources/Common_API_Keywords.robot

*** Variables ***
${COUNTRIES_API_URL}        https://countries.trevorblades.com/
@{COUNTRY_LIST}             Andorra  United Arab Emirates  Afghanistan  Antigua and Barbuda  Anguilla

*** Keywords ***
Verify The Countries API - success reponse
    Log    Send the post request with the valid query
    ${response}=        Post Response    ${COUNTRIES_API_URL}

    Log    Validate the successful response
    Status Should Be        expected_status=200
    Should Not Be Empty           ${response['data']}

Verify The Countries List
    Log    Send the post request with the valid query
    ${response}=        Post Response    ${COUNTRIES_API_URL}
    log     verify the total countries
    ${total_countries}=     Get Length      ${response['data']['countries']}
    ${total_count}=     Convert To String   ${total_countries}
    Should Be Equal       ${total_count}    250
    log     verify countries sub list
    ${count}=   Get Length      ${COUNTRY_LIST}
    FOR    ${country}   IN RANGE    ${count}
            Should Be Equal As Strings      ${COUNTRY_LIST[${country}]}     ${response['data']['countries'][${country}]['name']}
    END

Verify The Single Country Info
    Log    Send the post request with the valid query
    ${response}=        Post Response    ${COUNTRIES_API_URL}
    log     verifying country general info
    Should Be Equal As Strings    ${response['data']['country']['name']}                        United States
    Should Be Equal As Strings    ${response['data']['country']['capital']}                     Washington D.C.
    Should Be Equal As Strings    ${response['data']['country']['native']}                      United States
    Should Be Equal As Strings    ${response['data']['country']['emoji']}                       🇺🇸
    Should Be Equal As Strings    ${response['data']['country']['currency']}                    USD,USN,USS
    Should Be Equal As Strings    ${response['data']['country']['languages'][0]['code']}        en
    Should Be Equal As Strings    ${response['data']['country']['languages'][0]['name']}        English
    ${total_count}=       Get Length       ${response['data']['country']['states']}
    log     ${total_count}
    ${total_states}=      convert to string     ${total_count}
    Should Be Equal     ${total_states}     57

Verify Countries API - failed response
    [Documentation]     Returns the response of the post Request

    Log    Send the post request with the invalid query
    ${headers}=    Create Dictionary    Content-Type=application/json

     ${body}=       Create dictionary   query= query {countrie}
     Create Session     mysession    ${COUNTRIES_API_URL}    ${headers}    timeout=100    verify=true

    ${response}=    POST On Session    mysession   ${COUNTRIES_API_URL}    json=${body}     expected_status=400
    Status Should Be        expected_status=400
    Delete All Sessions