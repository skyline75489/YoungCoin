require 'json'

require 'sinatra'
require 'sinatra/json'

require_relative '../lib/YoungCoin'

b0 = YoungCoin::Block.genesis
t0 = YoungCoin::Transaction.new(0, 'reward')
t0.data[:inputs] << YoungCoin::TransactionIn.new(0, t0.id, 10_000, '111')
t0.data[:outputs] << YoungCoin::TransactionOut.new(10_000, '222')
b0.add_transaction(t0)

get '/' do
  content_type :json
  b0.to_json
end
