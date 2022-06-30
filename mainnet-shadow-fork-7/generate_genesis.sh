#!/bin/bash

set -e

DATA_DIR=custom_config_data
CONFIG_FILEPATH=$DATA_DIR/config.yaml

CL_ETH1_BLOCK="${CL_ETH1_BLOCK:-0x0000000000000000000000000000000000000000000000000000000000000000}"

read_config_value() {
  key=$1 # MIN_GENESIS_TIME
  line=$(grep $key $CONFIG_FILEPATH)
  stringarray=($line)
  echo ${stringarray[1]}
}

MIN_GENESIS_TIME=$(read_config_value MIN_GENESIS_TIME)

# Clean up previous out files
rm -rf custom_config_data/tranches custom_config_data/genesis.ssz

cat << EOF
Generating CL state
MIN_GENESIS_TIME = $MIN_GENESIS_TIME
CL_ETH1_BLOCK    = $CL_ETH1_BLOCK
EOF

# Note the genesis time persisted in genesis.ssz = MIN_GENESIS_TIME + GENESIS_DELAY
docker run --rm --entrypoint=eth2-testnet-genesis \
-u $UID -v $PWD/$DATA_DIR:/data \
skylenet/ethereum-genesis-generator phase0 \
--eth1-block "${CL_ETH1_BLOCK}" \
--timestamp "${MIN_GENESIS_TIME}" \
--config /data/config.yaml \
--mnemonics /data/mnemonics.yaml \
--tranches-dir /data/tranches \
--state-output /data/genesis.ssz