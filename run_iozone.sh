#!/bin/bash

# Output logs
source $TEST_CONFIG

rm -f results.xls

set -e

for RUN_N in $(seq $SHORT_REPS); do

    BASE_LOG_FILE=${TEST_LOG_DIR}/base_iozone_${RUN_N}.log
    KEYSTONE_LOG_FILE=${TEST_LOG_DIR}/keystone_iozone_${RUN_N}.log

    if [[ $RUN_BASELINE == 1 ]]; then
        ./iozone > ${BASE_LOG_FILE} 2> ${BASE_LOG_FILE}.err
        mv results.xls ${BASE_LOG_FILE}.xls
    fi

    if [[ $RUN_KEYSTONE == 1 ]]; then
        ${TEST_RUNNER} iozone ${EYRIE_FULL_SUPPORT} --utm-size ${DEFAULT_USZ} --freemem-size ${LARGE_FSZ} > ${KEYSTONE_LOG_FILE} 2> ${KEYSTONE_LOG_FILE}.err
        mv results.xls ${KEYSTONE_LOG_FILE}.xls
    fi
done
