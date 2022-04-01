#!/bin/bash

validators_per_host=1000 # Number of validators in each host

if [ -z "$VALIDATORS_MNEMONIC_0" ]; then
  echo "missing mnemonic 0"
  exit 1
fi


function prep_group {
  let group_base=$1
  validators_source_mnemonic="$2"
  let offset=$3
  let keys_to_create=$4
  naming_prefix="$5"
  echo "Group base: $group_base"
  for (( i = 0; i < keys_to_create; i++ )); do
    let node_index=group_base+i
    let offset_i=offset+i
    let validators_source_min=offset_i*validators_per_host
    let validators_source_max=validators_source_min+validators_per_host

    echo "writing keystores for host $naming_prefix-$node_index: $validators_source_min - $validators_source_max"
    eth2-val-tools keystores \
    --insecure \
    --prysm-pass="prysm" \
    --out-loc="validator_prep/$naming_prefix-$node_index" \
    --source-max="$validators_source_max" \
    --source-min="$validators_source_min" \
    --source-mnemonic="$validators_source_mnemonic"
  done
}

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 0 5 "goerli-shadow-fork-3-teku-geth"

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 5 8 "goerli-shadow-fork-3-lighthouse-geth"

echo "prysm keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 13 27 "goerli-shadow-fork-3-prysm-geth"

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 40 1 "goerli-shadow-fork-3-teku-nethermind"

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 41 1 "goerli-shadow-fork-3-teku-besu"

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 42 1 "goerli-shadow-fork-3-lighthouse-nethermind"

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 43 1 "goerli-shadow-fork-3-lighthouse-besu"

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 44 1 "goerli-shadow-fork-3-lodestar-geth"

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 45 1 "goerli-shadow-fork-3-lodestar-nethermind"

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 46 1 "goerli-shadow-fork-3-nimbus-geth"

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 47 1 "goerli-shadow-fork-3-nimbus-nethermind"

echo "prysm keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 48 2 "goerli-shadow-fork-3-prysm-nethermind"