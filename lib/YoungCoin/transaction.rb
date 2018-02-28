require 'json'
require 'jose'

module YoungCoin
  class TransactionIn
    attr_reader :index
    attr_reader :transaction
    attr_reader :amount
    attr_reader :address
    attr_reader :signature

    def initialize(index, transaction, amount, address)
      @index = index
      @transaction = transaction
      @amount = amount
      @address = address
      @signature = calc_signature
    end

    def as_json(_options = {})
      {
        index: @index,
        amount: @amount,
        address: @address,
        signature: @signature
      }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end

    def calc_signature
      sha = Digest::SHA256.new
      sha.update(@index.to_s + @transaction.to_s + @address)
      hash = sha.hexdigest
      jwk = JOSE::JWK.from_oct('0xDEADBEEF')
      jwk.sign(hash, 'alg' => 'HS256').compact
    end
  end

  class TransactionOut
    attr_reader :amount
    attr_reader :address

    def initialize(amount, address)
      @amount = amount
      @address = address
    end

    def as_json(_options = {})
      {
        amount: @amount,
        address: @address
      }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end
  end

  class Transaction
    attr_reader :id
    attr_reader :type
    attr_reader :data
    attr_reader :hash

    def initialize(id, type)
      @id = id
      @type = type
      @data = {
        inputs: [],
        outputs: []
      }
      @hash = calc_hash
    end

    def as_json(_options = {})
      {
        id: @id,
        type: @type,
        data: @data,
        hash: @hash
      }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end

    def calc_hash
      sha = Digest::SHA256.new
      sha.update(@id.to_s + @type.to_s + @data.to_json)
      sha.hexdigest
    end
  end
end
