#!/bin/bash

validators_per_host=1000 # Number of validators in each host

if [ -z "$VALIDATORS_MNEMONIC_1" ]; then
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
prep_group 1 "$VALIDATORS_MNEMONIC_0" 0 25 "kiln-teku-geth"

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_1" 0 25 "kiln-lighthouse-geth"

echo "prysm keys"
prep_group 1 "$VALIDATORS_MNEMONIC_2" 0 20 "kiln-prysm-geth"

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_3" 0 2 "kiln-teku-nethermind"

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_3" 2 2 "kiln-teku-besu"

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_3" 4 2 "kiln-lighthouse-nethermind"

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_3" 6 2 "kiln-lighthouse-besu"

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_3" 8 2 "kiln-lodestar-geth"

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_3" 10 2 "kiln-lodestar-nethermind"

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_3" 12 2 "kiln-nimbus-geth"

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_3" 14 2 "kiln-nimbus-nethermind"

echo "prysm keys"
prep_group 1 "$VALIDATORS_MNEMONIC_3" 16 2 "kiln-prysm-nethermind"