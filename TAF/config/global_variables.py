import os

LOG_LEVEL = "INFO"

# Base endpoint in the Consul path for all services
CONSUL_CONFIG_BASE_ENDPOINT = "/v1/kv/edgex/v3"

# API Version
API_VERSION = "v2"

# Deploy type: docker, manual
DEPLOY_TYPE = "docker"
SERVICE_STARTUP_RECHECK_TIMES = 10
SERVICE_STARTUP_WAIT_TIME = 3

# EdgeX host
BASE_URL = "localhost"

# OS environment variables
SECURITY_SERVICE_NEEDED=os.getenv("SECURITY_SERVICE_NEEDED")
DOCKER_HOST_IP=os.getenv("DOCKER_HOST_IP")
ARCH=os.getenv("ARCH")

# Token related variables
jwt_token = ''
consul_token = ''

# Service port
APP_HTTP_EXPORT_PORT = 59704
APP_MQTT_EXPORT_PORT = 59703
APP_FUNCTIOAL_TESTS_PORT = 59705
APP_EXTERNAL_MQTT_TRIGGER_PORT = 59706
REGISTRY_PORT = 8500
EX_BROKER_PORT = 1884
BROKER_PORT = 1883

if SECURITY_SERVICE_NEEDED == 'true':
    URI_SCHEME = "https"
    CORE_DATA_PORT = "8443/core-data"
    CORE_METADATA_PORT = "8443/core-metadata"
    CORE_COMMAND_PORT = "8443/core-command"
    SUPPORT_NOTIFICATIONS_PORT = "8443/support-notifications"
    SUPPORT_SCHEDULER_PORT = "8443/support-scheduler"
    RULESENGINE_PORT = "8443/rules-engine"
    SYS_MGMT_AGENT_PORT = "8443/sys-mgmt-agent"
else:
    URI_SCHEME = "http"
    CORE_DATA_PORT = 59880
    CORE_METADATA_PORT = 59881
    CORE_COMMAND_PORT = 59882
    SUPPORT_NOTIFICATIONS_PORT = 59860
    SUPPORT_SCHEDULER_PORT = 59861
    RULESENGINE_PORT = 59720
    SYS_MGMT_AGENT_PORT = 58890
