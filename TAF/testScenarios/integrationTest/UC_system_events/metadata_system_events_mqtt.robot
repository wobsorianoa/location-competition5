*** Settings ***
Resource         TAF/testCaseModules/keywords/core-metadata/coreMetadataAPI.robot
Resource     TAF/testCaseModules/keywords/common/commonKeywords.robot
Resource  TAF/testCaseModules/keywords/device-sdk/deviceServiceAPI.robot
Resource  TAF/testCaseModules/keywords/core-command/coreCommandAPI.robot
Force Tags     backward-skip  MessageQueue=MQTT

*** Variables ***
${SUITE}          Core-Metadata System Events Test - MQTT bus
${LOG_FILE_PATH}  ${WORK_DIR}/TAF/testArtifacts/logs/metadata_system_events_mqtt.log

*** Test Cases ***
SystemEvents001-Add Device and Receive Correct System Events
    Given Set Test Variable  ${add_device_topic}  edgex/system-events/core-metadata/device/add/device-virtual/Virtual-Sample-Profile
    And Set Test Variable  ${device_name}  add-system-event
    And Run MQTT Subscriber Progress And Output  ${add_device_topic}  Payload
    When Create Device For device-virtual With Name ${device_name}
    Then Single System Event Should Match With Source core-metadata, Type device and Action add
    [Teardown]  Run Keywords  Delete device by name ${device_name}
                ...      AND  Terminate All Processes  kill=True

SystemEvents002-Add Multiple Devices and Receive Correct System Events
    Given Set Test Variable  ${add_devices_topic}  edgex/system-events/core-metadata/device/add/device-virtual/Virtual-Sample-Profile
    And Run MQTT Subscriber Progress And Output  ${add_devices_topic}  Payload  3
    When Create 3 Devices For device-virtual
    Then Multiple 3 System Events Should Match With Source core-metadata, Type device and Action add
    [Teardown]  Run Keywords  Delete multiple devices by names  @{device_list}
                ...      AND  Terminate All Processes  kill=True

SystemEvents003-Update Device and Receive Correct System Events
    Given Set Test Variable  ${update_device_topic}  edgex/system-events/core-metadata/device/update/device-virtual/Virtual-Sample-Profile
    And Set Test Variable  ${device_name}  update-system-event
    And Run MQTT Subscriber Progress And Output  ${update_device_topic}  Payload
    And Create Device For device-virtual With Name ${device_name}
    When Update Device ${device_name} With operatingState=DOWN
    Then Single System Event Should Match With Source core-metadata, Type device and Action update
    [Teardown]  Run Keywords  Delete device by name ${device_name}
                ...      AND  Terminate All Processes  kill=True

SystemEvents004-Update Multiple Devices and Receive Correct System Events
    Given Set Test Variable  ${update_devices_topic}  edgex/system-events/core-metadata/device/update/device-virtual/Virtual-Sample-Profile
    And Run MQTT Subscriber Progress And Output  ${update_devices_topic}  Payload  3
    And Create 3 Devices For device-virtual
    When Update Multiple Devices
    Then Multiple 3 System Events Should Match With Source core-metadata, Type device and Action update
    [Teardown]   Run Keywords  Delete multiple devices by names  @{device_list}
                ...      AND  Terminate All Processes  kill=True

SystemEvents005-Delete Device and Receive Correct System Events
    Given Set Test Variable  ${delete_device_topic}  edgex/system-events/core-metadata/device/delete/device-virtual/Virtual-Sample-Profile
    And Set Test Variable  ${device_name}  delete-system-event
    And Run MQTT Subscriber Progress And Output  ${delete_device_topic}  Payload
    And Create Device For device-virtual With Name ${device_name}
    When Delete device by name ${device_name}
    Then Single System Event Should Match With Source core-metadata, Type device and Action delete
    [Teardown]   Terminate All Processes  kill=True

*** Keywords ***
Update Multiple Devices
    Update Device Command-Device-0 With operatingState=DOWN
    Update Device Command-Device-1 With adminState=LOCKED
    Update Device Command-Device-2 With label=test-system-event

Single System Event Should Match With Source ${source}, Type ${type} and Action ${action}
    ${received_content}  grep file  ${WORK_DIR}/TAF/testArtifacts/logs/${subscriber_file}  Payload
    Should Not Be Empty  ${received_content}
    ${payload}  Decode Base64 String  ${received_content}
    Should Be Equal As Strings  ${payload}[type]  ${type}
    Should Be Equal As Strings  ${payload}[action]  ${action}
    Should be Equal As Strings  ${payload}[source]  ${source}

Multiple ${numbers} System Events Should Match With Source ${source}, Type ${type} and Action ${action}
    ${received_content}  grep file  ${WORK_DIR}/TAF/testArtifacts/logs/${subscriber_file}  Payload
    Should Not Be Empty  ${received_content}
    ${messages}  Split String  ${received_content}  \n
    ${range}=  Get Length  ${messages}
    Should Be Equal As Strings  ${range}  ${numbers}  # Check the number of received system events
    FOR  ${system_events}  IN  @{messages}
       ${payload}  Decode Base64 String  ${system_events}
       Should Be Equal As Strings  ${payload}[type]  ${type}
       Should Be Equal As Strings  ${payload}[action]  ${action}
       Should be Equal As Strings  ${payload}[source]  ${source}
    END
