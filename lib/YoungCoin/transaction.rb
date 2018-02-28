module YoungCoin
    class Transaction

        attr_reader :id
        attr_reader :type
        attr_reader :data
        attr_reader :hash

        def initialize(id, type, data)
            @id = id
            @type = type
            @data = data
            @hash = calc_hash
        end

        def as_json(options={})
            {
                id: @id,
                type: @type,
                data: @data,
                hash: @hash,
            }
        end

        def to_json(*options)
            as_json(*options).to_json(*options)
        end

        def calc_hash
            sha = Digest::SHA256.new
            sha.update(@id.to_s + @type.to_s + @data)
            sha.hexdigest
        end

    end
end