# eth2 minimal ansible

This repository is a minimal set of playbooks and inventories required to set up an eth2 node or an eth2 testnet.

# Usage
- Fork this repository for your required devnet (Ideally it is a throwaway devnet)
- Modify the `testnets/<name>/inventory/dynamic.py` file with the correct tags and client distribution
- Generate the keys from the mnemonic by running the `generate_keys.sh` file (after exporting the mnemonic)  
- If needed, modify the `testnets/<name>/custom_config_data/` folder with the `genesis.ssz` and `config.yaml`
- Modify the `testnets/<name>/inventory/group_vars/eth2client_<client_name>.yml` if required
- Check the inventory with `ansible-inventory -i testnets/<name>/inventory/dynamic.py --list`
- Run the playbook to run all beacon nodes and validators with ` ansible-playbook -i testnets/<name>/inventory/dynamic.py playbooks/setup_beacon_and_validators_full.yml`
