require 'pp'
require 'json'
require_relative '../lib/YoungCoin'

b0 = YoungCoin::Block.genesis
t0 = YoungCoin::Transaction.new(0, 'reward')
t0.data[:inputs] << YoungCoin::TransactionIn.new(0, t0.id, 10_000, '111')
t0.data[:outputs] << YoungCoin::TransactionOut.new(10_000, '222')

b0.add_transaction(t0)

b1 = YoungCoin::Block.next(b0, 'T1')
b2 = YoungCoin::Block.next(b1, 'T2')
b3 = YoungCoin::Block.next(b2, 'T3')

pp b0
