*** Settings ***
Library  RequestsLibrary
Library  OperatingSystem
Library  TAF/testCaseModules/keywords/common/value_checker.py

*** Variables ***
${deviceServiceUrl}  ${URI_SCHEME}://${BASE_URL}:${SERVICE_PORT}
${dsDeviceUri}   /api/v1/device
${dsCallBack}    /api/v1/callback


*** Keywords ***
Invoke Get command by device id "${deviceId}" and command name "${commandName}"
    Create Session  Device Service  url=${deviceServiceUrl}  disable_warnings=true
    ${headers}=  Create Dictionary  Authorization=Bearer ${jwt_token}
    ${resp}=  GET On Session  Device Service    ${dsDeviceUri}/${deviceId}/${commandName}  headers=${headers}
    ...       expected_status=any
    run keyword if  ${resp.status_code}!=200  set test variable  ${error_response}   ${resp.content}
    run keyword if  ${resp.status_code}!=200  log   "Invoke Get command failed"
    ${responseBody}=  run keyword if  ${resp.status_code}==200   evaluate  json.loads('''${resp.content}''')  json
    run keyword if  ${resp.status_code}==200  set test variable   ${get_reading_value}  ${responseBody}[readings][0][value]
    set test variable  ${response}  ${resp.status_code}

Invoke Get command by device name "${deviceName}" and command name "${commandName}"
    Create Session  Device Service  url=${deviceServiceUrl}  disable_warnings=true
    ${headers}=  Create Dictionary  Authorization=Bearer ${jwt_token}
    ${resp}=  GET On Session  Device Service    ${dsDeviceUri}/name/${deviceName}/${commandName}  headers=${headers}
    ...       expected_status=any
    run keyword if  ${resp.status_code}!=200  log   ${resp.content}
    run keyword if  ${resp.status_code}!=200  log   "Invoke Get command failed"
    ${responseBody}=  run keyword if  ${resp.status_code}==200   evaluate  json.loads('''${resp.content}''')  json
    run keyword if  ${resp.status_code}==200  set test variable   ${get_reading_value}  ${responseBody}[readings][0][value]
    set test variable  ${response}  ${resp.status_code}

Invoke Get command name "${commandName}" for all devices
    Create Session  Device Service  url=${deviceServiceUrl}  disable_warnings=true
    ${headers}=  Create Dictionary  Authorization=Bearer ${jwt_token}
    ${resp}=  GET On Session  Device Service    ${dsDeviceUri}/all/${commandName}  headers=${headers}
    ...       expected_status=any
    run keyword if  ${resp.status_code}!=200  log   "Invoke Get command failed"
    ${deviceCommandBody}=  run keyword if  ${resp.status_code}==200  evaluate  json.loads('''${resp.content}''')  json
    return from keyword if  ${resp.status_code}==200    ${deviceCommandBody}
    set test variable  ${response}  ${resp.status_code}

Invoke Put command by device id "${deviceId}" and command name "${commandName}" with request body "${Resource}":"${value}"
    Create Session  Device Service  url=${deviceServiceUrl}  disable_warnings=true
    ${data}=    Create Dictionary   ${Resource}=${value}
    ${headers}=  Create Dictionary  Content-Type=application/json  Authorization=Bearer ${jwt_token}
    ${resp}=  PUT On Session  Device Service    ${dsDeviceUri}/${deviceId}/${commandName}  json=${data}   headers=${headers}
    ...       expected_status=any
    run keyword if  ${resp.status_code}!=200  log   ${resp.content}
    run keyword if  ${resp.status_code}!=200  log   "Invoke Put command failed"
    set test variable  ${response}  ${resp.status_code}

Invoke Put command by device name "${deviceName}" and command name "${commandName}" with request body "${Resource}":"${value}"
    Create Session  Device Service  url=${deviceServiceUrl}  disable_warnings=true
    ${data}=    Create Dictionary   ${Resource}=${value}
    ${headers}=  Create Dictionary  Content-Type=application/json  Authorization=Bearer ${jwt_token}
    ${resp}=  PUT On Session  Device Service  ${dsDeviceUri}/name/${deviceName}/${commandName}  json=${data}  headers=${headers}
    ...       expected_status=any
    run keyword if  ${resp.status_code}!=200  log   ${resp.content}
    run keyword if  ${resp.status_code}!=200  log   "Invoke Put command failed"
    set test variable  ${response}  ${resp.status_code}

Invoke Post callback for the device "${callback_id}" with action type "${action_type}"
    Create Session  Device Service  url=${deviceServiceUrl}  disable_warnings=true
    ${data}=    Create Dictionary   id=${callback_id}   type=${action_type}
    ${headers}=  Create Dictionary  Content-Type=application/json  Authorization=Bearer ${jwt_token}
    ${resp}=  POST On Session  Device Service    ${dsCallBack}  json=${data}   headers=${headers}
    ...       expected_status=any
    run keyword if  ${resp.status_code}!=200  log   ${resp.content}
    run keyword if  ${resp.status_code}!=200  log   "Invoke Post Callback command failed"
    set test variable  ${response}  ${resp.status_code}

Invoke Delete callback for the device "${deviceId}" with action type "${action_type}"
    Create Session  Device Service  url=${deviceServiceUrl}  disable_warnings=true
    ${data}=    Create Dictionary   id=${deviceId}   type=${action_type}
    ${headers}=  Create Dictionary  Content-Type=application/json  Authorization=Bearer ${jwt_token}
    ${resp}=  DELETE On Session  Device Service    ${dsCallBack}  json=${data}   headers=${headers}
    ...       expected_status=any
    run keyword if  ${resp.status_code}!=200  log   ${resp.content}
    run keyword if  ${resp.status_code}!=200  log   "Invoke Delete Callback command failed"
    set test variable  ${response}  ${resp.status_code}

Device resource should be updated to "${value}"
    ${commandName}=  get variable value  ${readingName}
    Invoke Get command by device id "${device_id}" and command name "${commandName}"
    should be equal  ${value}   ${deviceResourceValue}

Value should be "${dataType}"
    ${status}=  check value range   ${get_reading_value}  ${dataType}
    should be true  ${status}

DS should receive a Device Post callback
    Create Session  Device Service  url=${deviceServiceUrl}  disable_warnings=true
    ${headers}=  Create Dictionary  Authorization=Bearer ${jwt_token}
    ${resp}=  GET On Session  Device Service    ${deviceServiceUrl}/${dsCallBack}  headers=${headers}
    ...       expected_status=any
    log  ${resp.content}
    set test variable  ${response}  ${resp.status_code}

Reading value should be "${random_value}"
    should be equal  ${get_reading_value}  ${random_value}

