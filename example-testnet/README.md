# Example testnet

This directory contains the configs required to run an example testnet. 

# Assumption
- This setup expects that you already have deposits made and config data generated
- This setup is ideally aimed at public testnets and helps quickly provision validators

# Setup
- Ensure this repo is cloned locally and that the submodules have been pulled
- Ensure ansible has been installed
- Ensure SSH access to all servers

# Usage
- Modify the `example-testnet/inventory/dynamic.py` file with the correct tags and client distribution, if a dynamic inventory
is not needed, then replace it with a static `inventory.ini` file (same for all the commands below)
- Generate the keys from the mnemonic by running the `generate_keys.sh` file (after exporting the mnemonic)
- Modify the client distribution in `select_keys_for_clients.sh` and run the script to get keys in the needed format
- If needed, modify the `example-testnet/custom_config_data/` folder with the `genesis.ssz` and `config.yaml`
- Modify the `example-testnet/inventory/group_vars/eth2client_<client_name>.yml` if required
- Check the inventory with `ansible-inventory -i example-testnet/inventory/dynamic.py --list`
- Run the playbook to run all beacon nodes and validators with ` ansible-playbook -i example-testnet/inventory/dynamic.py playbooks/setup_beacon_and_validators_full.yml`

# Updating example nodes with new configs/images
Note!!: Assumptions made for the updating process:  
    - Please do not change the volume maps, container names or key locations unless you know what you are doing
    - Please do not change the `client_type`(lighthouse/teku/etc), the playbook `update-beacon-and-validator.yml` doesn't
touch the keys: it will lead to format errors!

- Ensure your credentials needed for generating `dynamic.py` are present. Alternatively use a static `inventory.ini`
- Make the required changes in the `inventory/group_vars` folder, the flags and image names are organized as `eth2client_<client-name>` 
- There are flags separately listed for beacon node and validator, make changes as needed. All clients work as separate
beacon node/validator except for nimbus (runs both in one container). 
- Run `ansible-inventory -i example-testnet/inventory/dynamic.py --list` to confirm the inventory is loaded as expected,
check if the change shows up in the inventory variables
- Run `ansible-playbook -i example-testnet/inventory/dynamic.py consensus-deployment-ansible/playbooks/update_beacon_and_validator.yml`. 
This will stop existing beacon and validator containers and re-start them with the new config or versions. No key or beacon db is changed.
- If you wish to change the client distribution or want to fully wipe and re-deploy the entire node, then please run 
`ansible-playbook -i example-testnet/inventory/dynamic.py consensus-deployment-ansible/playbooks/setup_beacon_and_validators_full.yml`
- Manually check the grafana dashboards or ssh into the instance and confirm changes. 

# Geth bootnode:
- ./go-ethereum/build/bin/geth --datadir=./hacknet/v2 init genesis.json
- ./go-ethereum/build/bin/geth --datadir=./hacknet/v2 --ethash.dagdir=./hacknet/v2/ethash --catalyst --mine --miner.threads=1 --miner.etherbase=0xfb969eb20eca70c2800103bbb0d3757bc60f918a --http --http.corsdomain='*' --http.addr="0.0.0.0" --nat extip:165.22.10.80 --networkid=1337101 console
- ./go-ethereum/build/bin/geth --datadir=./hacknet/v2 --ethash.dagdir=./hacknet/v2/ethash --catalyst  --http --http.corsdomain='*' --http.addr="0.0.0.0" --nat extip:165.22.10.80 --networkid=1337101 --http.api "engine,eth" console
- curl --location --request POST 'localhost:8545/' \
   --header 'Content-Type: application/json' \
   --data-raw '{
   "jsonrpc":"2.0",
   "method":"eth_getBlockByNumber",
   "params":[
   "latest",
   false
   ],
   "id":1
   }'