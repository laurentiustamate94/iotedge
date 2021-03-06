#!/bin/bash

set -ex
. ./containers.sh
. ./toolchain.sh

main() {
    local target_triple=$1
    local dockerfile=Dockerfile.debian9.${target_triple}

    if [[ ! -f $dockerfile ]]
    then
        echo "Expected $dockerfile in current directory."
        return 1
    fi

    # extract Linaro toolchain
    extract_arm64_toolchain

    # Once toolchain is downloaded and extracted, build docker image with toolchain
    build_arm64_toolchain_container $dockerfile $CONTAINER_REGISTRY debian_9.5-1

    # cleanup
    cleanup_arm64_toolchain
}

main "${@}"
