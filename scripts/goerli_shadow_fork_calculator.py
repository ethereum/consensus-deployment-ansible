#!/bin/python3
from web3.auto import Web3
from web3.middleware import geth_poa_middleware
import time
from datetime import datetime

w3 = Web3(Web3.HTTPProvider("https://rpc.goerli.mudit.blog"))
w3.middleware_onion.inject(geth_poa_middleware, layer=0)

current_difficulty = w3.eth.get_block('latest')['totalDifficulty']
current_time = time.time()

ttd_time_input = str(input('Enter date(yyyy-mm-dd hh:mm): '))
ttd_time = time.mktime(datetime.strptime(ttd_time_input, "%Y-%m-%d %H:%M").timetuple())
blocks_till_ttd = (ttd_time - current_time)/15


ttd_difficulty = current_difficulty + (blocks_till_ttd * 1.375 )

print("TTD on %s will be: ", ttd_time_input, ttd_difficulty)