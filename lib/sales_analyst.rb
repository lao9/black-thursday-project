require 'pry'

class SalesAnalyst

  def initialize(se)
    @mr = se.merchants
    @ir = se.items
  end

  def merchant_grouper
    id_array = @mr.merchant_list.map {|merchant| merchant.id}

    id_array.group_by do |merchant_id|
      @mr.find_by_id(merchant_id).items.count
    end

  end

  def item_merchant_array
    total = merchant_grouper.map do |key, value|
      Array.new(value.count, key)
    end
    total.flatten
  end

  def total
    item_merchant_array.reduce(0) do |sum, num|
        sum + num
    end
  end

  def average_items_per_merchant
    next_hash = merchant_grouper
    next_hash.delete(0)
    divisor = next_hash.values.flatten.count.to_f
    (total / divisor).round(2)
  end

  def average_items_per_merchant_standard_deviation

    mean = total.to_f / (item_merchant_array.count)

    std_sum = item_merchant_array.reduce(0) do |sum, num|
        sum + ((num - mean) ** 2)
    end

    final_total = (Math.sqrt(std_sum / (item_merchant_array.count - 1))).round(2)
  end

end
