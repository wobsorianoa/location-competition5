#!/bin/sh
# Arguments and the default values
USE_ARCH=${1:-x86_64}
SECURITY_SERVICE_NEEDED=${2:-false}
TEST_STRATEGY=${3:-functional-test} # option: functional-test, integration-test
TEST_SERVICE=${4:-v2-api}
DEPLOY_SERVICES=${5:-} # no-deployment or empty


# # x86_64 or arm64
[ "$USE_ARCH" = "arm64" ] && USE_ARM64="-arm64"

# Common Variables
USE_SHA1=main  # edgex-compose branch or SHA1
TAF_COMMON_IMAGE=nexus3.edgexfoundry.org:10003/edgex-taf-common${USE_ARM64}:latest
COMPOSE_IMAGE=nexus3.edgexfoundry.org:10003/edgex-devops/edgex-compose${USE_ARM64}:latest

if [ "$SECURITY_SERVICE_NEEDED" = true ]; then
        USE_SECURITY=-security-
else
        USE_SECURITY=-
fi

if [ "$DEPLOY_SERVICES" != "no-deployment" ]; then
  # Get compose file from edgex-compose
  sh get-compose-file.sh ${USE_ARCH} ${USE_SECURITY} ${USE_SHA1} ${TEST_STRATEGY}

  # Create backup report directory
  mkdir -p ${WORK_DIR}/TAF/testArtifacts/reports/cp-edgex
  if [ "$TEST_STRATEGY" = "integration-test" ] && [ "$TEST_SERVICE" = "mqtt" ]; then
    RUN_TAG=mqtt-bus
  else
 	  RUN_TAG=deploy-base-service
  fi

  # Install base service
  docker run --rm --network host -v ${WORK_DIR}:${WORK_DIR}:z -w ${WORK_DIR} \
          -e COMPOSE_IMAGE=${COMPOSE_IMAGE} -e SECURITY_SERVICE_NEEDED=${SECURITY_SERVICE_NEEDED} \
          -e USE_DB=${USE_DB} --security-opt label:disable \
          -v /var/run/docker.sock:/var/run/docker.sock ${TAF_COMMON_IMAGE} \
          --exclude Skipped --include ${RUN_TAG} -u deploy.robot -p default
  cp ${WORK_DIR}/TAF/testArtifacts/reports/edgex/log.html ${WORK_DIR}/TAF/testArtifacts/reports/cp-edgex/deploy-base.html
fi

case ${TEST_STRATEGY} in
  functional-test)
    # Run functional test
    case ${TEST_SERVICE} in
      device-virtual)
        docker run --rm --network host --name taf-common -v ${WORK_DIR}:${WORK_DIR}:z -w ${WORK_DIR} \
              --security-opt label:disable -e COMPOSE_IMAGE=${COMPOSE_IMAGE} -e ARCH=${ARCH} \
              -e SECURITY_SERVICE_NEEDED=${SECURITY_SERVICE_NEEDED} \
              -v /var/run/docker.sock:/var/run/docker.sock ${TAF_COMMON_IMAGE} \
              --exclude Skipped -u functionalTest/device-service -p device-virtual
        cp ${WORK_DIR}/TAF/testArtifacts/reports/edgex/log.html ${WORK_DIR}/TAF/testArtifacts/reports/cp-edgex/virtual.html
      ;;
      device-modbus)
        docker run --rm --network host --name taf-common -v ${WORK_DIR}:${WORK_DIR}:z -w ${WORK_DIR} \
              --security-opt label:disable -e COMPOSE_IMAGE=${COMPOSE_IMAGE} -e ARCH=${ARCH} \
              -e SECURITY_SERVICE_NEEDED=${SECURITY_SERVICE_NEEDED} \
              -v /var/run/docker.sock:/var/run/docker.sock ${TAF_COMMON_IMAGE} \
              --exclude Skipped -u functionalTest/device-service -p device-modbus
        cp ${WORK_DIR}/TAF/testArtifacts/reports/edgex/log.html ${WORK_DIR}/TAF/testArtifacts/reports/cp-edgex/modbus.html
      ;;
      v2-api)
        docker run --rm --network host -v ${WORK_DIR}:${WORK_DIR}:z -w ${WORK_DIR} \
                --security-opt label:disable -e COMPOSE_IMAGE=${COMPOSE_IMAGE} -e ARCH=${ARCH} \
                -e SECURITY_SERVICE_NEEDED=${SECURITY_SERVICE_NEEDED} \
                --env-file ${WORK_DIR}/TAF/utils/scripts/docker/common-taf.env \
                -v /var/run/docker.sock:/var/run/docker.sock ${TAF_COMMON_IMAGE} \
                --exclude Skipped --include v2-api -u functionalTest/V2-API -p default
        cp ${WORK_DIR}/TAF/testArtifacts/reports/edgex/log.html ${WORK_DIR}/TAF/testArtifacts/reports/cp-edgex/v2-api-test.html
      ;;
      *)
        docker run --rm --network host -v ${WORK_DIR}:${WORK_DIR}:z -w ${WORK_DIR} \
                --security-opt label:disable -e COMPOSE_IMAGE=${COMPOSE_IMAGE} -e ARCH=${ARCH} \
                -e SECURITY_SERVICE_NEEDED=${SECURITY_SERVICE_NEEDED} \
                --env-file ${WORK_DIR}/TAF/utils/scripts/docker/common-taf.env \
                -v /var/run/docker.sock:/var/run/docker.sock ${TAF_COMMON_IMAGE} \
                --exclude Skipped --include v2-api -u functionalTest/V2-API/${TEST_SERVICE} -p default
        cp ${WORK_DIR}/TAF/testArtifacts/reports/edgex/log.html ${WORK_DIR}/TAF/testArtifacts/reports/cp-edgex/${TEST_SERVICE}-test.html
      ;;
    esac
  ;;
  integration-test)
    # Run integration test
    ## Only support deploying edgex services through docker-compose file.

    docker run --rm --network host -v ${WORK_DIR}:${WORK_DIR}:z -w ${WORK_DIR} \
            --security-opt label:disable -e COMPOSE_IMAGE=${COMPOSE_IMAGE} -e ARCH=${ARCH} \
            -e SECURITY_SERVICE_NEEDED=${SECURITY_SERVICE_NEEDED} \
            --env-file ${WORK_DIR}/TAF/utils/scripts/docker/common-taf.env \
            -v /tmp/edgex/secrets:/tmp/edgex/secrets:z \
            -v /var/run/docker.sock:/var/run/docker.sock ${TAF_COMMON_IMAGE} \
            --exclude Skipped --include MessageQueue=${TEST_SERVICE} -u integrationTest -p device-virtual
    cp ${WORK_DIR}/TAF/testArtifacts/reports/edgex/log.html ${WORK_DIR}/TAF/testArtifacts/reports/cp-edgex/integration-test.html
  ;;
  *)
    exit 0
  ;;
esac

if [ "$DEPLOY_SERVICES" != "no-deployment" ]; then
  # Shutdown
  docker run --rm --network host -v ${WORK_DIR}:${WORK_DIR}:z -w ${WORK_DIR} \
          -e COMPOSE_IMAGE=${COMPOSE_IMAGE} --security-opt label:disable \
          -v /var/run/docker.sock:/var/run/docker.sock ${TAF_COMMON_IMAGE} \
          --exclude Skipped --include shutdown-edgex -u shutdown.robot -p default
  cp ${WORK_DIR}/TAF/testArtifacts/reports/edgex/log.html ${WORK_DIR}/TAF/testArtifacts/reports/cp-edgex/shutdown.html
fi
