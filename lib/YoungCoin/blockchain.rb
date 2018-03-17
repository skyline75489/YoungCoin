require 'pp'
require_relative 'block'

module YoungCoin
  class BlockChain
    attr_accessor :blocks

    def initialize()
      @blocks = [Block.genesis]
      @unspent_tx_outs = []
    end

    def get_latest_block()
      @blocks.last
    end

    def generate_next_block(data)
      previous_block = get_latest_block
      next_index = previous_block.index + 1
      next_timestamp = Time.now.to_i

      block = find_block(next_index, previous_block.hash, next_timestamp, data, difficulty)
      add_block(block)
    end

    def find_block(index, previous_hash, timestamp, data, difficulty)
      nonce = 0
      pp 'Current difficulty: ' + difficulty.to_s
      loop do
        hash = Block.calc_hash(index, previous_hash, timestamp, data, difficulty, nonce)
        return Block.new(index, previous_hash, timestamp, data, hash, difficulty, nonce)
      end
    end

    def add_block(new_block)
      @blocks << new_block
    end

    def difficulty
      1
    end
  end
end
