# Pithos testnet ansible files + Config

This repository is a minimal set of playbooks and inventories required to set up the pithos testnet consisting of execution and 
consensus nodes. 

## General information
- General folder structure: All testnet relevant configs are under `pithos-testnet`. Generic config variables are set under
`pithos-testnet/inventory/group_vars/all.yaml`. Client specific variables are set under e.g `pithos-testnet/inventory/group_vars/eth2client_xxxxxx.yaml`.
The client specific variables also contains the commands used to start the docker image with. 
- All the config files, `genesis.ssz` and other variables needed for the testnet are placed under `pithos-testnet/custom_config_data`.
- Some information at a glance:  
    1. ENR for consensus clients: `enr:-Iq4QKuNB_wHmWon7hv5HntHiSsyE1a6cUTK1aT7xDSU_hNTLW3R4mowUboCsqYoh1kN9v3ZoSu_WuvW9Aw0tQ0Dxv6GAXxQ7Nv5gmlkgnY0gmlwhLKAlv6Jc2VjcDI1NmsxoQK6S-Cii_KmfFdUJL2TANL3ksaKUnNXvTCv1tLwXs0QgIN1ZHCCIyk`  
    2. enode for execution clients: `enode://e56b164de03d22eb85b79b03cdd9edd428c2e3b5f2ff435cf284e3dfb81699058fa602a39cbcd0315c72be904ff0c6ec66750ffa1912fe33e615e45d73c9a980@137.184.195.98:30303`
  
## Instructions to join testnet  
1. Clone this repository  
2. Ensure `docker` and `docker-compose` is installed: `docker-compose --version` and `docker --version`
3. Change directories with `cd consensus-deployment-ansible/scripts/quick-run/`  
4. Create the required directories for persistent data with `mkdir -p execution_data beacon_data`  
5. Find your IP address(public IP) and add it to the `pithos.vars` file file located in `consensus-deployment-ansible/scripts/quick-run/`, this is just to ensure easy peering  
5.1 `curl ifconfig.me` or visit https://whatismyipaddress.com  
5.2 Replace IP in config file with your own IP address: https://i.imgur.com/xnNqN6h.png  
6. Run your chosen execution engine, e.g: `docker-compose --env-file pithos.vars -f docker-compose.geth.yml up -d`  
7. Run your chosen consensus engine, e.g: `docker-compose --env-file pithos.vars -f docker-compose.lighthouse.yml up -d`  
8. Check your logs to confirm that they are up and syncing, e.g `docker logs lighthouse_beacon -f --tail=20`  
9. To stop the clients, run `docker-compose -f <insert file name you used earlier here> down`

## Alternative Instructions to join testnet
 - [How to setup a validator for Ethereum staking on Pithos testnet in 10 minutes or less by CoinCashew](https://www.coincashew.com/coins/overview-eth/guide-or-how-to-setup-a-validator-for-ethereum-staking-on-pithos-testnet-in-10-minutes-or-less)
