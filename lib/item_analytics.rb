module ItemAnalytics

  include StatsCalculator

  def golden_items
    item_price_list = il.map {|item| item.unit_price}
    mean = calculate_average(item_price_list)
    std = standard_deviation(item_price_list)
    threshold = mean + (std * 2)
    scan_for_golden_items(item_price_list, threshold)
  end

  def scan_for_golden_items(item_price_list, threshold)
    golden_items = item_price_list.map.with_index do |price, index|
      il[index] if price >= threshold
    end
    golden_items.compact
  end

end
