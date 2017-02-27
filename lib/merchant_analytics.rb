module MerchantAnalytics

  include StatsCalculator

  def create_merchant_id_list
    mr.merchant_list.map {|merchant| merchant.id}
  end

  def group_ids_by_quantity
    merchant_id_list.group_by do |merchant_id|
      mr.find_by_id(merchant_id).items.count
    end
  end

  def average_items_per_merchant
    calculate_average(items_per_merchant_list)
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    standard_deviation(items_per_merchant_list, mean)
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    std = average_items_per_merchant_standard_deviation
    threshold = mean + std
    high_item_sellers = item_quantity_per_merchant.map do |key, value|
      value if key >= threshold
    end
    high_item_sellers.compact.flatten.map do |merchant_id|
      mr.find_by_id(merchant_id)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = mr.find_by_id(merchant_id).items
    numerator = merchant_items.reduce(0) do |sum, item|
      sum + item.unit_price
    end
    merchant_items.count.zero? ? 0 : (numerator / merchant_items.count).round(2)
  end

  def average_price_sum
    mr.merchant_list.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
  end

  def average_average_price_per_merchant
    avg_list = item_quantity_per_merchant
    avg_list.delete(0)
    (average_price_sum / avg_list.values.flatten.count).round(2)
  end

end
