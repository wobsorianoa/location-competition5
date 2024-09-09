LOG_LEVEL = "INFO"

# Deploy type: docker, manual
DEPLOY_TYPE = "docker"
SERVICE_STARTUP_RECHECK_TIMES = 10
SERVICE_STARTUP_WAIT_TIME = 5

# EdgeX host
BASE_URL = "localhost"

# Device service for testing
DEVICE_SERVICE_NAME = "device-modbus"
DEVICE_SERVICE_PORT = 49991

# Service port
CORE_DATA_PORT = 48080
CORE_METADATA_PORT = 48081
CORE_COMMAND_PORT = 48082
SUPPORT_LOGGING_PORT = 48061
SUPPORT_NOTIFICATION_PORT = 48060
SUPPORT_SCHEDULER_PORT = 48085
SUPPORT_RULESENGINE_PORT = 48075
EXPORT_CLIENT_PORT = 48071
EXPORT_DISTRO_PORT = 48070


SUPPORTED_DATA_TYPES = [
    #     Boolean
    {"dataType": "BOOL", "commandName": "GenerateDeviceValue_Boolean_RW", "readingName": "DeviceValue_Boolean_RW", "readWrite": "RW"},
    {"dataType": "BOOL", "commandName": "GenerateDeviceValue_Boolean_R", "readingName": "DeviceValue_Boolean_R", "readWrite": "R"},
    {"dataType": "BOOL", "commandName": "GenerateDeviceValue_Boolean_W", "readingName": "DeviceValue_Boolean_W", "readWrite": "W"},
    #     Float
    {"dataType": "FLOAT32", "commandName": "GenerateDeviceValue_Float32_RW", "readingName": "DeviceValue_Float32_RW", "readWrite": "RW"},
    {"dataType": "FLOAT32", "commandName": "GenerateDeviceValue_Float32_R", "readingName": "DeviceValue_Float32_R", "readWrite": "R"},
    {"dataType": "FLOAT32", "commandName": "GenerateDeviceValue_Float32_W", "readingName": "DeviceValue_Float32_W", "readWrite": "W"},
    {"dataType": "FLOAT64", "commandName": "GenerateDeviceValue_Float64_RW", "readingName": "DeviceValue_Float64_RW", "readWrite": "RW"},
    {"dataType": "FLOAT64", "commandName": "GenerateDeviceValue_Float64_R", "readingName": "DeviceValue_Float64_R", "readWrite": "R"},
    {"dataType": "FLOAT64", "commandName": "GenerateDeviceValue_Float64_W", "readingName": "DeviceValue_Float64_W", "readWrite": "W"},
    #     Integer
    {"dataType": "INT16", "commandName": "GenerateDeviceValue_INT16_RW", "readingName": "DeviceValue_INT16_RW", "readWrite": "RW"},
    {"dataType": "INT16", "commandName": "GenerateDeviceValue_INT16_R", "readingName": "DeviceValue_INT16_R", "readWrite": "R"},
    {"dataType": "INT16", "commandName": "GenerateDeviceValue_INT16_W", "readingName": "DeviceValue_INT16_W", "readWrite": "W"},
    {"dataType": "INT32", "commandName": "GenerateDeviceValue_INT32_RW", "readingName": "DeviceValue_INT32_RW", "readWrite": "RW"},
    {"dataType": "INT32", "commandName": "GenerateDeviceValue_INT32_R", "readingName": "DeviceValue_INT32_R", "readWrite": "R"},
    {"dataType": "INT32", "commandName": "GenerateDeviceValue_INT32_W", "readingName": "DeviceValue_INT32_W", "readWrite": "W"},
    {"dataType": "INT64", "commandName": "GenerateDeviceValue_INT64_RW", "readingName": "DeviceValue_INT64_RW", "readWrite": "RW"},
    {"dataType": "INT64", "commandName": "GenerateDeviceValue_INT64_R", "readingName": "DeviceValue_INT64_R", "readWrite": "R"},
    {"dataType": "INT64", "commandName": "GenerateDeviceValue_INT64_W", "readingName": "DeviceValue_INT64_W", "readWrite": "W"},
    #     Unsigned Integer
    {"dataType": "UINT16", "commandName": "GenerateDeviceValue_UINT16_RW", "readingName": "DeviceValue_UINT16_RW", "readWrite": "RW"},
    {"dataType": "UINT16", "commandName": "GenerateDeviceValue_UINT16_R", "readingName": "DeviceValue_UINT16_R", "readWrite": "R"},
    {"dataType": "UINT16", "commandName": "GenerateDeviceValue_UINT16_W", "readingName": "DeviceValue_UINT16_W", "readWrite": "W"},
    {"dataType": "UINT32", "commandName": "GenerateDeviceValue_UINT32_RW", "readingName": "DeviceValue_UINT32_RW", "readWrite": "RW"},
    {"dataType": "UINT32", "commandName": "GenerateDeviceValue_UINT32_R", "readingName": "DeviceValue_UINT32_R", "readWrite": "R"},
    {"dataType": "UINT32", "commandName": "GenerateDeviceValue_UINT32_W", "readingName": "DeviceValue_UINT32_W", "readWrite": "W"},
    {"dataType": "UINT64", "commandName": "GenerateDeviceValue_UINT64_RW", "readingName": "DeviceValue_UINT64_RW", "readWrite": "RW"},
    {"dataType": "UINT64", "commandName": "GenerateDeviceValue_UINT64_R", "readingName": "DeviceValue_UINT64_R", "readWrite": "R"},
    {"dataType": "UINT64", "commandName": "GenerateDeviceValue_UINT64_W", "readingName": "DeviceValue_UINT64_W", "readWrite": "W"},
]
