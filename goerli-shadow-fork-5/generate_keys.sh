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
prep_group 1 "$VALIDATORS_MNEMONIC_0" 0 3 "goerli-shadow-fork-5-teku-geth" 1000

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 3 3 "goerli-shadow-fork-5-lighthouse-geth" 1000

echo "prysm keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 6 3 "goerli-shadow-fork-5-prysm-geth" 1000

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 9 3 "goerli-shadow-fork-5-lodestar-geth" 1000

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 12 3 "goerli-shadow-fork-5-nimbus-geth" 1000

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 15 2 "goerli-shadow-fork-5-teku-nethermind" 1000

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 17 2 "goerli-shadow-fork-5-lighthouse-nethermind" 1000

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 19 2 "goerli-shadow-fork-5-lodestar-nethermind" 1000

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 21 2 "goerli-shadow-fork-5-nimbus-nethermind" 1000

echo "prysm keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 23 2 "goerli-shadow-fork-5-prysm-nethermind" 1000

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 50 2 "goerli-shadow-fork-5-lighthouse-besu" 500

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 52 2 "goerli-shadow-fork-5-nimbus-besu" 500

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 54 2 "goerli-shadow-fork-5-teku-besu" 500

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 56 2 "goerli-shadow-fork-5-lodestar-besu" 500

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 58 2 "goerli-shadow-fork-5-prysm-besu" 500

echo "lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 30 1 "goerli-shadow-fork-5-lighthouse-erigon" 1000

echo "nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 31 1 "goerli-shadow-fork-5-nimbus-erigon" 1000

echo "teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 32 1 "goerli-shadow-fork-5-teku-erigon" 1000

echo "lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 33 1 "goerli-shadow-fork-5-lodestar-erigon" 1000

echo "prysm keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 34 1 "goerli-shadow-fork-5-prysm-erigon" 1000