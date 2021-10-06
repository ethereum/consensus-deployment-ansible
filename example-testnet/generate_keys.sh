validators_per_host=100 # Number of validators in each host
number_of_regions=1 # Number of aws regions the testnet spans
instances_per_region=10 # Number of instances in one region


if [ -z "$VALIDATORS_MNEMONIC_TRANCHE_0" ]; then
  echo "missing mnemonic 0"
  exit 1
fi


function prep_group {
  let group_base=$1
  validators_source_mnemonic="$2"
  let offset=$3

  echo "$group_base"
  for (( i = 0; i < instances_per_region; i++ )); do
    let node_index=group_base+i
    let offset_i=offset+i
    let validators_source_min=offset_i*validators_per_host
    let validators_source_max=validators_source_min+validators_per_host

    echo "writing keystores for host $node_index: $validators_source_min - $validators_source_max"
    eth2-val-tools keystores \
    --prysm-pass="prysm" \
    --out-loc="validator_prep/host_$node_index" \
    --source-max="$validators_source_max" \
    --source-min="$validators_source_min" \
    --source-mnemonic="$validators_source_mnemonic"
  done
}

for (( j = 0; j < number_of_regions; j++ )); do
  echo "running for region $j"
  prep_group $(( (j+1)*100 + 1)) "$VALIDATORS_MNEMONIC_TRANCHE_0" $(( j*instances_per_region ))
done
