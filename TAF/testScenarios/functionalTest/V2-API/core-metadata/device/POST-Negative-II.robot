*** Settings ***
Library      uuid
Resource     TAF/testCaseModules/keywords/common/commonKeywords.robot
Resource     TAF/testCaseModules/keywords/core-metadata/coreMetadataAPI.robot
Suite Setup  Run Keywords  Setup Suite
...                        AND  Run Keyword if  $SECURITY_SERVICE_NEEDED == 'true'  Get Token
Suite Teardown  Run Keyword if  $SECURITY_SERVICE_NEEDED == 'true'  Remove Token
Force Tags      v2-api

*** Variables ***
${SUITE}          Core Metadata Device POST Test Cases
${LOG_FILE_PATH}  ${WORK_DIR}/TAF/testArtifacts/logs/core-metadata-device-post-negative-ll.log
${api_version}    v2

*** Test Cases ***
ErrDevicePOST010 - Create device with non-existent device service name
    Given Create Multiple Profiles/Services And Generate Multiple Devices Sample
    And Set To Dictionary  ${Device}[1][device]  serviceName=Non-existent
    When Create Device With ${Device}
    Then Should Return Status Code "207"
    And Item Index 0,2,3 Should Contain Status Code "201" And id
    And Item Index 1 Should Contain Status Code "404"
    And Should Return Content-Type "application/json"
    And Response Time Should Be Less Than "${default_response_time_threshold}"ms
    [Teardown]  Run Keywords  Delete Multiple Devices By Names
    ...                       Test-Device  Test-Device-Disabled  Test-Device-AutoEvents
    ...                  AND  Delete multiple device services by names
    ...                       Device-Service-${index}-1  Device-Service-${index}-2  Device-Service-${index}-3
    ...                  AND  Delete multiple device profiles by names
    ...                       Test-Profile-1  Test-Profile-2  Test-Profile-3

ErrDevicePOST011 - Create device with non-existent device profile name
    Given Create Multiple Profiles/Services And Generate Multiple Devices Sample
    And Set To Dictionary  ${Device}[2][device]  profileName=Non-existent
    When Create Device With ${Device}
    Then Should Return Status Code "207"
    And Item Index 0,1,3 Should Contain Status Code "201" And id
    And Item Index 2 Should Contain Status Code "404"
    And Should Return Content-Type "application/json"
    And Response Time Should Be Less Than "${default_response_time_threshold}"ms
    [Teardown]  Run Keywords  Delete Multiple Devices By Names
    ...                       Test-Device  Test-Device-Locked  Test-Device-AutoEvents
    ...                  AND  Delete multiple device services by names
    ...                       Device-Service-${index}-1  Device-Service-${index}-2  Device-Service-${index}-3
    ...                  AND  Delete multiple device profiles by names
    ...                       Test-Profile-1  Test-Profile-2  Test-Profile-3
