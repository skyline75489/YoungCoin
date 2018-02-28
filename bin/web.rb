require "json"

require "sinatra"
require "sinatra/json"

require_relative "../lib/YoungCoin"

b0 = YoungCoin::Block.genesis()
t0 = YoungCoin::Transaction.new(0, "reward", "0")
b0.add_transaction(t0)

get '/' do
    content_type :json
    b0.to_json
end
