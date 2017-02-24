require 'pry'

class SalesAnalyst

  def initialize(se)
    @mr = se.merchants
    @ir = se.items
  end

  def average_items_per_merchant
    # sum of items
    # divided by merchants
    # cadisart has 2 items
    # Lola Marleys has 1 item
    # 3 items divided 2 = 1.5

    # array of merchant ids

    id_array = @mr.merchant_list.map {|merchant| merchant.id}
    # [12334105, 12334112, 12334257, 12334113, 12334115, 12334176]

    next_hash = id_array.group_by do |merchant_id|
      @mr.find_by_id(merchant_id).items.count
    end



    # {12334105 => 0, 12334112 => 2, 12334257 => 0, 12334115 => 1}
    #
    # {0 => [], 1 => [12334115], 2 => [12334112]}
    #
    # # remove 0 key from hash
    next_hash.delete(0)

    # hey = {1 => [12334115], 2 => [12334112]}

    # enumerable?

    total = next_hash.keys.reduce(0) do |sum, quantity|
      sum + (quantity * next_hash[quantity].count)
    end



    divisor = next_hash.values.flatten.count.to_f

    total / divisor
    # hey.values = [[12334115], [12334112]].flatten
    #
    # count of flattened arrays = 2
    #
    # 3 / 2 = 1.5


  end

end
