# Pithos testnet

The Pithos testnet follows the Amphora testnet, and switches from minimal to mainnet configuration.

Files:
- Consensus:
  - [config: `config.yaml`](./config.yaml)
  - deposit contract extras:
    - [`deposit_contract.txt`](./deposit_contract.txt)
    - [`deploy_block.txt`](./deploy_block.txt)
  - [genesis state `genesis.ssz`](./genesis.ssz)
  - ENR list:
    - [YAML](./boot_enr.yaml)
    - [txt](./bootstrap_nodes.txt)
- Execution:
  - [Geth chain config `genesis.json`](./genesis.json)
  - [Besu chain config `besu_genesis.json`](./besu_genesis.json) (same as geth, but with explicit ethash entry)
  - [Nethermind chain config `nethermind_genesis.json`](./nethermind_genesis.json) (open-ethereum format)
  - Enodes list: see nethermind config end (to be updated)

```
genesis_time: 1634213100
genesis_state_root: 0x3847aab3cf3e9e47abe30e521092394b7c73eb43ed838536ae525e35632ef017
genesis_latest_block_header:
  slot: 0
  proposer_index: 0
  parent_root: 0x0000000000000000000000000000000000000000000000000000000000000000
  state_root: 0x0000000000000000000000000000000000000000000000000000000000000000
  body_root: 0xccb62460692be0ec813b56be97f68a82cf57abc102e27bf49ebf4190ff22eedd
genesis_block_root_no_state_root: 0xeade62f0457b2fdf48e7d3fc4b60736688286be7c7a3ac4c9a16a5e0600bd9e4
genesis_block_root_updated_state_root: 0x2bdf04a3a727c1dda4ad3eece037ea8e15c6492ecf7a0c47b2caeee2d608165a
genesis_validators_root: 0x5aad7d8f618399903822c82d4d213357b5f26ae265494d705e3d02964a07bf0f
genesis_validators_count: 40100
genesis_active_validators_count: 40100
genesis_total_active_stake_gwei: 1283200000000000
genesis_total_balance_gwei: 1283200000000000
eth1_data:
  deposit_root: 0xd70a234731285c6804c2a4f56711ddb8c82c99740f207854891028af34e27e5e
  deposit_count: 0
  block_hash: 0x0000000000000000000000000000000000000000000000000000000000000000
deposit index: 0
genesis_fork_version: 0x10000069
genesis_fork_digest: 0x8c38172b
pre_genesis_fork_digest: 0xb6ad238e
```

