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
${LOG_FILE_PATH}  ${WORK_DIR}/TAF/testArtifacts/logs/core-metadata-device-post-positive.log
${api_version}    v2

*** Test Cases ***
DevicePOST001 - Create device with same device service
    Given Create Multiple Profiles/Services And Generate Multiple Devices Sample
    And Set To Dictionary  ${Device}[1][device]  serviceName=Device-Service-${index}-1
    And Set To Dictionary  ${Device}[2][device]  serviceName=Device-Service-${index}-1
    When Create Device With ${Device}
    Then Should Return Status Code "207"
    And Item Index All Should Contain Status Code "201" And id
    And Should Return Content-Type "application/json"
    And Response Time Should Be Less Than "${default_response_time_threshold}"ms
    [Teardown]  Delete Multiple Devices Sample, Profiles Sample And Services Sample

DevicePOST002 - Create device with different device service
    [Tags]  SmokeTest
    Given Create Multiple Profiles/Services And Generate Multiple Devices Sample
    When Create Device With ${Device}
    Then Should Return Status Code "207"
    And Item Index All Should Contain Status Code "201" And id
    And Should Return Content-Type "application/json"
    And Response Time Should Be Less Than "${default_response_time_threshold}"ms
    [Teardown]  Delete Multiple Devices Sample, Profiles Sample And Services Sample

DevicePOST003 - Create device with uuid
    # Request body contains uuid
    ${random_uuid}=  Evaluate  str(uuid.uuid4())
    Given Create Multiple Profiles/Services And Generate Multiple Devices Sample
    And Set To Dictionary  ${Device}[1]  requestId=${random_uuid}
    When Create Device With ${Device}
    Then Should Return Status Code "207"
    And Item Index All Should Contain Status Code "201" And id
    And Should Be Equal  ${content}[1][requestId]  ${random_uuid}
    And Should Return Content-Type "application/json"
    And Response Time Should Be Less Than "${default_response_time_threshold}"ms
    [Teardown]  Delete Multiple Devices Sample, Profiles Sample And Services Sample
