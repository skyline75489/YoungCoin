require 'pp'
require 'json'
require_relative '../lib/YoungCoin'

chain = YoungCoin::BlockChain.new()

b1 = chain.generate_next_block('d1')
b2 = chain.generate_next_block('d2')

pp chain