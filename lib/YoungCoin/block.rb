require "digest"

module YoungCoin
    class Block

        attr_reader :index
        attr_reader :timestamp
        attr_reader :data
        attr_reader :previous_hash
        attr_reader :hash
        attr_reader :transactions

        def initialize(index, data, previous_hash)
            @index = index
            @timestamp = Time.now
            @data = data
            @previous_hash = previous_hash
            @hash = calc_hash
            @transactions = []
        end
   
        def as_json(options={})
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

        def calc_hash
            sha = Digest::SHA256.new
            sha.update(@index.to_s + @timestamp.to_s + @data + @previous_hash + @transactions.to_s)
            sha.hexdigest
        end

        def add_transaction(transaction)
            @transactions << transaction
        end

        def self.genesis()
            Block.new(0, "Genesis", "0")
        end

        def self.next(previous, data="data...")
            Block.new(previous.index + 1, data, previous.hash)
        end
    end
end