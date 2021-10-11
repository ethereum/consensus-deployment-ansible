#!/usr/bin/env python3

import json

import boto3
from botocore.config import Config
import os

regions = [
    'eu-central-1',
]

filters = [
    {'Name': 'tag:Environment', 'Values': ['testnet']},
    {'Name': 'tag:Project', 'Values': ['example']},
    {'Name': 'tag:Team', 'Values': ['eth2']},
    {'Name': 'instance-state-name', 'Values': ['running']},
]

boto3_session = boto3.session.Session(profile_name='sso')

def fetch_client_type(eth2client_type):
    if eth2_node_index == 104:
        I['explorer']['hosts'].append(node)
        I['forkmon']['hosts'].append(node)
    if eth2_node_index == 110:
        I['bootnode']['hosts'].append(node)
    if eth2_node_index % 4 == 0:
        eth2client_type = 'lighthouse'
    elif local_index % 4 == 1:
        eth2client_type = 'prysm'
    elif local_index % 4 == 2:
        eth2client_type = 'teku'
    else:
        eth2client_type = 'nimbus'
    return eth2client_type

I = {
    '_meta': {
        'hostvars': {}
    },
    'all': {
        'hosts': [

        ],
        'children': [
            'ungrouped',
            'metrics',
            'eth2stats_server',
            'bootnode',
            'forkmon'
            'eth2client',
            'beacon',
            'validator',
        ]
    },
    'metrics': {
        'hosts': [],
        'vars': {}
    },
    'eth2stats_server': {
        'hosts': []
    },
    'explorer': {
        'hosts': []
    },
    'forkmon': {
        'hosts': []
    },
    'bootnode': {
        'hosts': []
    },
    'beacon': {
        'hosts': [],
    },
    'validator': {
        'hosts': [],
    },
    'eth2client': {
        'hosts': [],
        'children': [
            'eth2client_lighthouse',
            'eth2client_nimbus',
            'eth2client_prysm',
            'eth2client_teku'
        ]
    },
    'eth2client_lighthouse': {
        'hosts': [],
    },
    'eth2client_nimbus': {
        'hosts': [],
    },
    'eth2client_prysm': {
        'hosts': [],
    },
    'eth2client_teku': {
        'hosts': [],
    },
    'ungrouped': {
        'children': [
        ]
    }
}

eth2_clients = [
    'lighthouse',
    'nimbus',
    'prysm',
    'teku'
]

for reg in regions:
    for cl in eth2_clients:
        I[f'eth2client_{cl}_{reg.replace("-", "_")}'] = {'hosts': []}
    I[f'eth2client_all_{reg.replace("-", "_")}'] = {'hosts': []}



def get_instances():
    for r in regions:
        ec2 = boto3_session.resource('ec2', region_name=r)
        instances = ec2.instances.filter(Filters=filters)
        for i in instances:
            yield i

for i in get_instances():
    name = i.id
    role = 'unknown'
    node_size = None
    for tag in i.tags:
        if tag['Key'] == 'Name':
            name = tag['Value']
        if tag['Key'] == 'Role':
            role = tag['Value']
        if tag['Key'] == 'NodeSize':
            node_size = tag['Value']


    # TODO: filter nodes by tag, so we can have more than just beacon nodes in this dynamic inventory.
    if role == 'eth2_bootnode':
        I['bootnode']['hosts'].append(name)
    else:
        I['beacon']['hosts'].append(name)
        I['validator']['hosts'].append(name)

    I['all']['hosts'].append(name)
    region = str(i.placement['AvailabilityZone'])
    region = region[:region.rindex('-') + 2]  # strip of the a, b, whatever zone suffix from the region

    parts = name.split('-')
    node_id = int(parts[-1])

    I['_meta']['hostvars'][name] = {
        'ansible_host': i.public_ip_address,  # ip that we use for ansible work.
        'public_ip_address': i.public_ip_address,  # ip that we use for p2p / configs / etc., generally the same
        'region': region,
        # store the node_id, used later for building eth2stats display names etc.
        'eth2_node_index': node_id,
        'node_size': node_size,
        'display_emoji': "example" + str(node_id),
    }

beacons = I['beacon']['hosts']

for node in beacons:
    eth2_node_index = I['_meta']['hostvars'][node]['eth2_node_index']
    group_index = (eth2_node_index // 100)
    local_index = (eth2_node_index % 100)

    eth2client_type = fetch_client_type(eth2_node_index)

    I['eth2client_' + eth2client_type]['hosts'].append(node)

bootnodes = I['bootnode']['hosts']
for node in bootnodes:
    # Node names are formatted like 'eth2-inventory-example-402'
    # hundreds = match region index (starting at 1)
    # rest is node index within region.
    parts = node.split('-')
    node_id = int(parts[-1])
    # make sure we correctly identify the node region
    assert node_id // 100 == regions.index(region) + 1
    # store the node_id, used later for building eth2stats display names etc.
    I['_meta']['hostvars'][node]['bootnode_index'] = node_id
    I['_meta']['hostvars'][node]['bootnode_p2p_priv_key'] = os.getenv(f"BOOTNODE_PRIV")


def get_node_public_ips(groupname):
    for n in I[groupname]['hosts']:
        yield n, I['_meta']['hostvars'][n]['public_ip_address']

def get_client_ips(client):
    return get_node_public_ips('eth2client_' + client)

def get_client_metrics_targets(client):
    for node, ip in get_client_ips(client):
        yield f'{ip}:8100'
        yield f'{ip}:8080'

print(json.dumps(I, indent=4))