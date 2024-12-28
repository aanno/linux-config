#!/bin/bash -x

but_to_ign() {
  pushd configs

    if [[ ( ! -f "${IGNITION_CONFIG}.bu" ) || ( "${IGNITION_CONFIG}.but -nt ${IGNITION_CONFIG}.bu" ) ]]; then
      envsubst <${IGNITION_CONFIG}.but >${IGNITION_CONFIG}.bu
      if [ $? -ne 0 ]; then
        rm ${IGNITION_CONFIG}.bu
        echo "but to butane: warnings or errors"
        exit -1
      fi
    fi

    if [[ ( ! -f "${IGNITION_CONFIG}.ign" ) || ( "${IGNITION_CONFIG}.bu -nt ${IGNITION_CONFIG}.ign" ) ]]; then
      butane --pretty --strict --files-dir butane-embedded ${IGNITION_CONFIG}.bu >${IGNITION_CONFIG}.ign
      if [ $? -ne 0 ]; then
        rm ${IGNITION_CONFIG}.ign
        echo "butane warnings or errors"
        exit -1
      fi
    fi

  popd
}
