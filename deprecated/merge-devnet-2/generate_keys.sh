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
prep_group 1 "$VALIDATORS_MNEMONIC_0" 0 21 "merge-devnet-2-lighthouse-geth"

echo "Lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 21 1 "merge-devnet-2-lighthouse-nethermind"

echo "Lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 22 1 "merge-devnet-2-lodestar-geth"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 23 1 "merge-devnet-2-lodestar-nethermind"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 24 1 "merge-devnet-2-nimbus-geth"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 25 1 "merge-devnet-2-nimbus-nethermind"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 26 1 "merge-devnet-2-prysm-geth"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 27 1 "merge-devnet-2-prysm-nethermind"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 28 1 "merge-devnet-2-teku-geth"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 29 1 "merge-devnet-2-teku-nethermind"