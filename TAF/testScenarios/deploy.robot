*** Settings ***
Documentation    Deploy EdgeX
Library          TAF/testCaseModules/keywords/setup/setup_teardown.py
Library          TAF/testCaseModules/keywords/setup/edgex.py
Suite Setup      Setup Suite
Suite Teardown   Suite Teardown

*** Variables ***
${SUITE}         EdgeX deployment
${LOG_FILE_PATH}          ${WORK_DIR}/TAF/testArtifacts/logs/edgex_deployment.log

*** Keywords ***
# Setup called once before all test cases.
Setup Suite
   ${status} =  Suite Setup  ${SUITE}  ${LOG_FILE_PATH}  ${LOG_LEVEL}
   Should Be True  ${status}  Failed Suite Setup

*** Test Cases ***
Deploy EdgeX
    [Tags]  deploy-base-service
    Deploy edgex

Deploy EdgeX With MQTT Bus
    [Tags]  mqtt-bus
    Deploy edgex  MQTTMessageBus

Deploy Device Service
    [Tags]  deploy-device-service
    Deploy device service  ${SERVICE_NAME}
