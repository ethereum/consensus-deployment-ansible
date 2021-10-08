validators_per_host=100 # Number of validators in each host

export VALIDATORS_MNEMONIC_0="flock beyond move size arena limit shoe observe ship drop bacon phone satisfy lend evolve anchor sheriff when impulse physical certain future trophy series"

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
prep_group 1 "$VALIDATORS_MNEMONIC_0" 0 3 "amphora-lighthouse-geth"

echo "Lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 3 3 "amphora-lighthouse-nethermind"

echo "Lighthouse keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 6 3 "amphora-lighthouse-besu"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 9 1 "amphora-lodestar-geth"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 10 1 "amphora-lodestar-nethermind"

echo "Lodestar keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 11 1 "amphora-lodestar-besu"

echo "Nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 12 1 "amphora-nimbus-geth"

echo "Nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 13 1 "amphora-nimbus-nethermind"

echo "Nimbus keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 14 1 "amphora-nimbus-besu"

echo "Teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 15 3 "amphora-teku-geth"

echo "Teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 18 3 "amphora-teku-nethermind"

echo "Teku keys"
prep_group 1 "$VALIDATORS_MNEMONIC_0" 21 3 "amphora-teku-besu"