import os

# Service for testing
SERVICE_NAME = "device-virtual"
PREFIX = "Virtual"

SECURITY_SERVICE_NEEDED = os.getenv("SECURITY_SERVICE_NEEDED")
if SECURITY_SERVICE_NEEDED == 'true':
    SERVICE_PORT = "8443/device-virtual"
else:
    SERVICE_PORT = 59900

SUPPORTED_DATA_TYPES = [
    #     Boolean
    {"dataType": "BOOL", "commandName": "Virtual_GenerateDeviceValue_Boolean_RW", "readingName": "Virtual_DeviceValue_Boolean_RW", "readWrite": "RW"},
    {"dataType": "BOOL", "commandName": "Virtual_GenerateDeviceValue_Boolean_R", "readingName": "Virtual_DeviceValue_Boolean_R", "readWrite": "R"},
    {"dataType": "BOOL", "commandName": "Virtual_GenerateDeviceValue_Boolean_W", "readingName": "Virtual_DeviceValue_Boolean_W", "readWrite": "W"},
    #     String
    {"dataType": "STRING", "commandName": "Virtual_GenerateDeviceValue_String_RW", "readingName": "Virtual_DeviceValue_String_RW", "readWrite": "RW"},
    {"dataType": "STRING", "commandName": "Virtual_GenerateDeviceValue_String_R", "readingName": "Virtual_DeviceValue_String_R", "readWrite": "R"},
    {"dataType": "STRING", "commandName": "Virtual_GenerateDeviceValue_String_W", "readingName": "Virtual_DeviceValue_String_W", "readWrite": "W"},
    #     Float
    {"dataType": "FLOAT32", "commandName": "Virtual_GenerateDeviceValue_FLOAT32_RW", "readingName": "Virtual_DeviceValue_FLOAT32_RW", "readWrite": "RW"},
    {"dataType": "FLOAT32", "commandName": "Virtual_GenerateDeviceValue_FLOAT32_R", "readingName": "Virtual_DeviceValue_FLOAT32_R", "readWrite": "R"},
    {"dataType": "FLOAT32", "commandName": "Virtual_GenerateDeviceValue_FLOAT32_W", "readingName": "Virtual_DeviceValue_FLOAT32_W", "readWrite": "W"},
    {"dataType": "FLOAT64", "commandName": "Virtual_GenerateDeviceValue_FLOAT64_RW", "readingName": "Virtual_DeviceValue_FLOAT64_RW", "readWrite": "RW"},
    {"dataType": "FLOAT64", "commandName": "Virtual_GenerateDeviceValue_FLOAT64_R", "readingName": "Virtual_DeviceValue_FLOAT64_R", "readWrite": "R"},
    {"dataType": "FLOAT64", "commandName": "Virtual_GenerateDeviceValue_FLOAT64_W", "readingName": "Virtual_DeviceValue_FLOAT64_W", "readWrite": "W"},
    #     Integer
    {"dataType": "INT8", "commandName": "Virtual_GenerateDeviceValue_INT8_RW", "readingName": "Virtual_DeviceValue_INT8_RW", "readWrite": "RW"},
    {"dataType": "INT8", "commandName": "Virtual_GenerateDeviceValue_INT8_R", "readingName": "Virtual_DeviceValue_INT8_R", "readWrite": "R"},
    {"dataType": "INT8", "commandName": "Virtual_GenerateDeviceValue_INT8_W", "readingName": "Virtual_DeviceValue_INT8_W", "readWrite": "W"},
    {"dataType": "INT16", "commandName": "Virtual_GenerateDeviceValue_INT16_RW", "readingName": "Virtual_DeviceValue_INT16_RW", "readWrite": "RW"},
    {"dataType": "INT16", "commandName": "Virtual_GenerateDeviceValue_INT16_R", "readingName": "Virtual_DeviceValue_INT16_R", "readWrite": "R"},
    {"dataType": "INT16", "commandName": "Virtual_GenerateDeviceValue_INT16_W", "readingName": "Virtual_DeviceValue_INT16_W", "readWrite": "W"},
    {"dataType": "INT32", "commandName": "Virtual_GenerateDeviceValue_INT32_RW", "readingName": "Virtual_DeviceValue_INT32_RW", "readWrite": "RW"},
    {"dataType": "INT32", "commandName": "Virtual_GenerateDeviceValue_INT32_R", "readingName": "Virtual_DeviceValue_INT32_R", "readWrite": "R"},
    {"dataType": "INT32", "commandName": "Virtual_GenerateDeviceValue_INT32_W", "readingName": "Virtual_DeviceValue_INT32_W", "readWrite": "W"},
    {"dataType": "INT64", "commandName": "Virtual_GenerateDeviceValue_INT64_RW", "readingName": "Virtual_DeviceValue_INT64_RW", "readWrite": "RW"},
    {"dataType": "INT64", "commandName": "Virtual_GenerateDeviceValue_INT64_R", "readingName": "Virtual_DeviceValue_INT64_R", "readWrite": "R"},
    {"dataType": "INT64", "commandName": "Virtual_GenerateDeviceValue_INT64_W", "readingName": "Virtual_DeviceValue_INT64_W", "readWrite": "W"},
    #     Unsigned Integer
    {"dataType": "UINT8", "commandName": "Virtual_GenerateDeviceValue_UINT8_RW", "readingName": "Virtual_DeviceValue_UINT8_RW", "readWrite": "RW"},
    {"dataType": "UINT8", "commandName": "Virtual_GenerateDeviceValue_UINT8_R", "readingName": "Virtual_DeviceValue_UINT8_R", "readWrite": "R"},
    {"dataType": "UINT8", "commandName": "Virtual_GenerateDeviceValue_UINT8_W", "readingName": "Virtual_DeviceValue_UINT8_W", "readWrite": "W"},
    {"dataType": "UINT16", "commandName": "Virtual_GenerateDeviceValue_UINT16_RW", "readingName": "Virtual_DeviceValue_UINT16_RW", "readWrite": "RW"},
    {"dataType": "UINT16", "commandName": "Virtual_GenerateDeviceValue_UINT16_R", "readingName": "Virtual_DeviceValue_UINT16_R", "readWrite": "R"},
    {"dataType": "UINT16", "commandName": "Virtual_GenerateDeviceValue_UINT16_W", "readingName": "Virtual_DeviceValue_UINT16_W", "readWrite": "W"},
    {"dataType": "UINT32", "commandName": "Virtual_GenerateDeviceValue_UINT32_RW", "readingName": "Virtual_DeviceValue_UINT32_RW", "readWrite": "RW"},
    {"dataType": "UINT32", "commandName": "Virtual_GenerateDeviceValue_UINT32_R", "readingName": "Virtual_DeviceValue_UINT32_R", "readWrite": "R"},
    {"dataType": "UINT32", "commandName": "Virtual_GenerateDeviceValue_UINT32_W", "readingName": "Virtual_DeviceValue_UINT32_W", "readWrite": "W"},
    {"dataType": "UINT64", "commandName": "Virtual_GenerateDeviceValue_UINT64_RW", "readingName": "Virtual_DeviceValue_UINT64_RW", "readWrite": "RW"},
    {"dataType": "UINT64", "commandName": "Virtual_GenerateDeviceValue_UINT64_R", "readingName": "Virtual_DeviceValue_UINT64_R", "readWrite": "R"},
    {"dataType": "UINT64", "commandName": "Virtual_GenerateDeviceValue_UINT64_W", "readingName": "Virtual_DeviceValue_UINT64_W", "readWrite": "W"},
]
