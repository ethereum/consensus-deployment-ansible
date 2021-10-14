# Amphora testnet ansible files + Config

This repository is a minimal set of playbooks and inventories required to set up the amphora testnet consisting of execution and 
consensus nodes. 

## Instructions
- General folder structure: All testnet relevant configs are under `amphora-testnet`. Generic config variables are set under
`amphora-testnet/inventory/group_vars/all.yaml`. Client specific variables are set under e.g `amphora-testnet/inventory/group_vars/eth2client_xxxxxx.yaml`.
The client specific variables also contains the commands used to start the docker image with. 
- All the config files, `genesis.ssz` and other variables needed for the testnet are placed under `amphora-testnet/custom_config_data`.
- Some information at a glance:  
    1. ENR for consensus clients: `enr:-Iq4QKuNB_wHmWon7hv5HntHiSsyE1a6cUTK1aT7xDSU_hNTLW3R4mowUboCsqYoh1kN9v3ZoSu_WuvW9Aw0tQ0Dxv6GAXxQ7Nv5gmlkgnY0gmlwhLKAlv6Jc2VjcDI1NmsxoQK6S-Cii_KmfFdUJL2TANL3ksaKUnNXvTCv1tLwXs0QgIN1ZHCCIyk`  
    2. enode for execution clients: `enode://e56b164de03d22eb85b79b03cdd9edd428c2e3b5f2ff435cf284e3dfb81699058fa602a39cbcd0315c72be904ff0c6ec66750ffa1912fe33e615e45d73c9a980@137.184.195.98:30303`
