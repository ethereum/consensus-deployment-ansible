#!/bin/sh

# Manually update the client required, the script will move the keys into the format required by the client
# shellcheck disable=SC2039
ARRAY=( "host_101:prysm"
        "host_102:teku"
        "host_103:nimbus"
        "host_104:lighthouse"
        "host_105:prysm"
        "host_106:teku"
        "host_107:nimbus"
        "host_108:lighthouse"
        "host_109:prysm"
        "host_110:"teku")

INPUT_DATA_DIR="validator_prep"
OUTPUT_DATA_DIR="selected_validator_keys"

# Delete any existing output dir and ensure the final key store dir is present
rm -rf "$OUTPUT_DATA_DIR" && mkdir -p "$OUTPUT_DATA_DIR"

for host in "${ARRAY[@]}" ; do
    HOST="${host%%:*}"
    VALUE="${host##*:}"
    printf "\nScript will select keys for %s on %s.\n" "$VALUE" "$HOST"
    printf "Ensuring folder %s is present in %s. \n" "$HOST" "$OUTPUT_DATA_DIR"
    mkdir -p "$OUTPUT_DATA_DIR"/"$HOST"

    # Move all the keys according to the client
    if [ "$VALUE" = "lighthouse" ]; then
      printf "Selecting %s keys.\n" "$VALUE"
      cp -r "$INPUT_DATA_DIR"/"$HOST"/keys "$OUTPUT_DATA_DIR"/"$HOST"/validators
      cp -r "$INPUT_DATA_DIR"/"$HOST"/secrets "$OUTPUT_DATA_DIR"/"$HOST"/secrets
    elif [ "$VALUE" = "teku" ]; then
      printf "Selecting %s keys.\n" "$VALUE"
      cp -r "$INPUT_DATA_DIR"/"$HOST"/teku-keys "$OUTPUT_DATA_DIR"/"$HOST"/keys
      cp -r "$INPUT_DATA_DIR"/"$HOST"/teku-secrets "$OUTPUT_DATA_DIR"/"$HOST"/secrets
    elif [ "$VALUE" = "prysm" ]; then
      printf "Selecting %s keys.\n" "$VALUE"
      mkdir -p "$OUTPUT_DATA_DIR"/"$HOST"/wallet/direct/accounts
      echo "prysm" > "$OUTPUT_DATA_DIR"/"$HOST"/wallet_pass.txt
      cp "$INPUT_DATA_DIR"/"$HOST"/prysm/direct/accounts/all-accounts.keystore.json "$OUTPUT_DATA_DIR"/"$HOST"/wallet/direct/accounts/all-accounts.keystore.json
      cp "$INPUT_DATA_DIR"/"$HOST"/prysm/keymanageropts.json "$OUTPUT_DATA_DIR"/"$HOST"/wallet/direct/keymanageropts.json
    elif [ "$VALUE" = "nimbus" ]; then
      printf "Selecting %s keys.\n" "$VALUE"
      cp -r "$INPUT_DATA_DIR"/"$HOST"/nimbus-keys "$OUTPUT_DATA_DIR"/"$HOST"/keys
      cp -r "$INPUT_DATA_DIR"/"$HOST"/secrets "$OUTPUT_DATA_DIR"/"$HOST"/secrets
    elif [ "$VALUE" = "lodestar" ]; then
      printf "Selecting %s keys.\n" "$VALUE"
      cp -r "$INPUT_DATA_DIR"/"$HOST"/keys "$OUTPUT_DATA_DIR"/"$HOST"/keystores
      cp -r "$INPUT_DATA_DIR"/"$HOST"/lodestar-secrets "$OUTPUT_DATA_DIR"/"$HOST"/secrets
    fi


done
printf "\nAll selected keys are stored in ./selected_validator_keys \n"

#printf "%s runs %s\n" "${ARRAY[1]%%:*}" "${ARRAY[1]##*:}"