require 'pp'
require 'json'
require_relative '../lib/YoungCoin/blockchain'

chain = YoungCoin::BlockChain.new()

b1 = chain.generate_next_block('d1')
chain.add_block(b1)
pp chain