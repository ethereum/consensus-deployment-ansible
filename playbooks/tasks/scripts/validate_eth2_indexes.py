#!/usr/bin/python

import sys
import json
import yaml
import time

# Expect YAML or JSON first arg with a dict of keysdata by hostname
# ```
# devnet-2-lighthouse-nethermind-1:
#   indexes: 0000..1000
#   mnemonic: giant issue aisle success illegal bike spike question tent bar rely arctic volcano long crawl hungry vocal artwork sniff fantasy very lucky have athlete
# devnet-2-lighthouse-nethermind-2:
#   indexes: 1000..2000
#   mnemonic: giant issue aisle success illegal bike spike question tent bar rely arctic volcano long crawl hungry vocal artwork sniff fantasy very lucky have athlete
# ```
host_keysdata_str = sys.argv[1]
host_keysdata = yaml.load(host_keysdata_str)

# Expects as second and third arguments the paths of config.yaml, mnemonics.yaml
# ```
# /custom_config_data
#   config.yaml
#   mnemonics.yaml
# ```
eth2_config_filepath = sys.argv[2]
mnemonics_out_filepath = sys.argv[3]


total_count = 0
count_by_mnemonic = {}

for hostname in host_keysdata:
  keysdata = host_keysdata[hostname]
  indexes = keysdata['indexes']
  mnemonic = keysdata['mnemonic']
  # 0000..1000
  from_index = int(indexes.split("..")[0])
  to_index = int(indexes.split("..")[1])
  count = to_index - from_index

  # Validate all ranges are ascending
  if to_index < from_index:
    raise Exception("{0} indexes value {1} is not ascending".format(hostname, indexes))

  # Validate all ranges are contiguous
  prev_count = count_by_mnemonic.get(mnemonic, 0)
  if prev_count != from_index:
    raise Exception("{0} range not contiguous: prev_count {1} from_index {2}".format(hostname, prev_count, from_index))

  count_by_mnemonic[mnemonic] = prev_count + count
  total_count = total_count + count


# Ensure config.yaml has correct validator count
eth2_config_file = open(eth2_config_filepath, mode='r')
eth2_config_yaml = yaml.load(eth2_config_file.read())
eth2_config_file.close()

min_validator_count = eth2_config_yaml['MIN_GENESIS_ACTIVE_VALIDATOR_COUNT']
expected_genesis_time = eth2_config_yaml['MIN_GENESIS_TIME'] + eth2_config_yaml['GENESIS_DELAY']

if total_count < min_validator_count:
  raise Exception("total_count {0} < MIN_GENESIS_ACTIVE_VALIDATOR_COUNT {1}".format(total_count, min_validator_count))

if expected_genesis_time < time.time():
  raise Exception("MIN_GENESIS_TIME + GENESIS_DELAY {0} is in the past".format(expected_genesis_time))

# Format `mnemonics.yml`
# ```yaml
# - mnemonic: "giant issue aisle success illegal bike spike question tent bar rely arctic volcano long crawl hungry vocal artwork sniff fantasy very lucky have athlete"
#   count: 11000
# ```
mnemonics = list(map(lambda kv: {'mnemonic':kv[0], 'count':kv[1]}, count_by_mnemonic.items()))
mnemonics_file = open(mnemonics_out_filepath, "w")
mnemonics_file.write(yaml.dump(mnemonics))
mnemonics_file.close()