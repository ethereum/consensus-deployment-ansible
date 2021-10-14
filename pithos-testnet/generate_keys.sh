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

echo "Lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 0 15 "pithos-lighthouse-geth"

echo "Lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 15 1 "pithos-lighthouse-nethermind"

echo "Lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 16 1 "pithos-lighthouse-besu"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 17 1 "pithos-lodestar-geth"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 18 1 "pithos-lodestar-nethermind"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 19 1 "pithos-lodestar-besu"

echo "Nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 20 1 "pithos-nimbus-geth"

echo "Nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 21 1 "pithos-nimbus-nethermind"

echo "Nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 22 1 "pithos-nimbus-besu"

echo "Teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 23 15 "pithos-teku-geth"

echo "Teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 38 1 "pithos-teku-nethermind"

echo "Teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 39 1 "pithos-teku-besu"