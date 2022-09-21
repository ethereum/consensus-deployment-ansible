#!/bin/bash


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
  validators_per_host=$6
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
prep_group 1 "$VALIDATORS_MNEMONIC_0" 0 3 "mainnet-shadow-fork-2-teku-geth" 1000

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 3 4 "mainnet-shadow-fork-2-lighthouse-geth" 1000

echo "prysm keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 7 13 "mainnet-shadow-fork-2-prysm-geth" 1000

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 40 1 "mainnet-shadow-fork-2-teku-nethermind" 500

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 41 1 "mainnet-shadow-fork-2-prysm-erigon" 500

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 42 1 "mainnet-shadow-fork-2-lighthouse-nethermind" 500

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 43 1 "mainnet-shadow-fork-2-lighthouse-besu" 500

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 44 1 "mainnet-shadow-fork-2-lodestar-geth" 500

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 45 1 "mainnet-shadow-fork-2-lodestar-nethermind" 500

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 46 1 "mainnet-shadow-fork-2-nimbus-geth" 500

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 47 1 "mainnet-shadow-fork-2-nimbus-nethermind" 500

echo "prysm keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 24 1 "mainnet-shadow-fork-2-prysm-nethermind" 1000