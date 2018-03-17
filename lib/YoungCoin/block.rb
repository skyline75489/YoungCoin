require 'digest'

module YoungCoin
  class Block
    attr_reader :index
    attr_reader :timestamp
    attr_reader :data
    attr_reader :previous_hash
    attr_reader :hash
    attr_reader :difficulty
    attr_reader :nonce

    attr_reader :transactions

    def initialize(index, previous_hash, timestamp, data, hash, difficulty, nonce)
      @index = index
      @timestamp = timestamp
      @data = data
      @previous_hash = previous_hash
      @hash = hash
      @difficulty = difficulty
      @hash = hash
      @transactions = []
    end

    def as_json(_options = {})
      {
        index: @index,
        timestamp: @timestamp,
        hash: @hash,
        data: @data,
        previous_hash: @previous_hash,
        transactions: @transactions
      }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end

    def self.calc_hash(index, previous_hash, timestamp, data, difficulty, nonce)
      Digest::SHA256.hexdigest(index.to_s + timestamp.to_s + data + previous_hash + nonce.to_s)
    end

    def self.genesis
      Block.new(0, '0', 1465154706, 'Genesis', '9f981542f2c7b9320727d8b795c0c50d0e33cdf533e43d4596ddd1c6718bb6c4', 0, 0)
    end

    def add_transaction(transaction)
      @transactions << transaction
    end
  end
end
