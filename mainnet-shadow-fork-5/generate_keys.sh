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
prep_group 1 "$VALIDATORS_MNEMONIC_0" 0 2 "mainnet-shadow-fork-5-teku-geth" 1000

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 2 2 "mainnet-shadow-fork-5-lighthouse-geth" 1000

echo "prysm keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 4 2 "mainnet-shadow-fork-5-prysm-geth" 1000

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 6 2 "mainnet-shadow-fork-5-lodestar-geth" 1000

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 8 2 "mainnet-shadow-fork-5-nimbus-geth" 1000

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 10 2 "mainnet-shadow-fork-5-teku-nethermind" 1000

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 12 2 "mainnet-shadow-fork-5-lighthouse-nethermind" 1000

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 14 2 "mainnet-shadow-fork-5-lodestar-nethermind" 1000

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 16 2 "mainnet-shadow-fork-5-nimbus-nethermind" 1000

echo "prysm keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 18 2 "mainnet-shadow-fork-5-prysm-nethermind" 1000

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 20 2 "mainnet-shadow-fork-5-lighthouse-besu" 1000

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 22 2 "mainnet-shadow-fork-5-nimbus-besu" 1000

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 24 2 "mainnet-shadow-fork-5-teku-besu" 1000

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 26 2 "mainnet-shadow-fork-5-lodestar-besu" 1000

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 28 2 "mainnet-shadow-fork-5-prysm-besu" 1000

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 30 2 "mainnet-shadow-fork-5-lighthouse-erigon" 1000

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 32 2 "mainnet-shadow-fork-5-nimbus-erigon" 1000

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 34 2 "mainnet-shadow-fork-5-teku-erigon" 1000

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 36 2 "mainnet-shadow-fork-5-lodestar-erigon" 1000

echo "prysm keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 38 2 "mainnet-shadow-fork-5-prysm-erigon" 1000