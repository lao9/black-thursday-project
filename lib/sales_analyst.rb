require 'pry'

class SalesAnalyst

  def initialize(se)
    @mr = se.merchants
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

  def average_items_per_merchant_standard_deviation(set=item_merchant_array, average=merchant_mean)

    std_sum = set.reduce(0) do |sum, num|
        sum + ((num - average) ** 2)
    end

    final_total = (Math.sqrt(std_sum / (set.count - 1))).round(2)
  end

  def merchant_mean
    total.to_f / (item_merchant_array.count)
  end

  def merchants_with_high_item_count

    threshold = merchant_mean + average_items_per_merchant_standard_deviation

    high_item_sellers = merchant_grouper.map do |key, value|
      value if key >= threshold
    end

    high_item_sellers.compact.flatten.map do |merchant_id|
      @mr.find_by_id(merchant_id)
    end

  end

  def average_item_price_for_merchant(merchant_id)

    item_array = @mr.find_by_id(merchant_id).items

    numerator = item_array.reduce(0) do |sum, item|
      sum + item.unit_price
    end

    item_array.count.zero? ? 0 : (numerator / item_array.count)

  end

  def average_price_sum
    @mr.merchant_list.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
  end

  def average_average_price_per_merchant
    next_hash = merchant_grouper
    next_hash.delete(0)
    average_price_sum / next_hash.values.flatten.count
  end


  def golden_items
    items = @mr.parent.items.item_list
    item_price_list = items.map {|item| item.unit_price}
    item_price_sum = item_price_list.reduce(0) { |sum, price| sum + price }

    item_mean = item_price_sum / item_price_list.count
    std = average_items_per_merchant_standard_deviation(item_price_list, item_mean)
    threshold = item_mean + (std * 2)

    golden_items = item_price_list.map.with_index do |price, index|
      items[index] if price >= threshold
    end

    golden_items.compact
  end

end
