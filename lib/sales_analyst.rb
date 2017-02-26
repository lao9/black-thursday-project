require 'pry'
require_relative '../lib/stats_calculator'

class SalesAnalyst
  include StatsCalculator
  def initialize(se)
    @mr = se.merchants
    @ivr = se.invoices
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
    standard_deviation(item_merchant_array, merchant_mean)
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

    item_array.count.zero? ? 0 : (numerator / item_array.count).round(2)

  end

  def average_price_sum
    @mr.merchant_list.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
  end

  def average_average_price_per_merchant
    next_hash = merchant_grouper
    next_hash.delete(0)
    (average_price_sum / next_hash.values.flatten.count).round(2)
  end


  def golden_items
    items = @mr.parent.items.item_list
    item_price_list = items.map {|item| item.unit_price}
    item_price_sum = item_price_list.reduce(0) { |sum, price| sum + price }

    item_mean = item_price_sum / item_price_list.count
    std = standard_deviation(item_price_list, item_mean)
    threshold = item_mean + (std * 2)

    golden_items = item_price_list.map.with_index do |price, index|
      items[index] if price >= threshold
    end

    golden_items.compact
  end

  def invoices_per_merchant_list(id_array)


    invoices_grouper = id_array.group_by {|merchant_id| @mr.find_by_id(merchant_id).invoices.count}

    invoice_total = invoices_grouper.map do |key, value|
      Array.new(value.count, key)
    end

    invoice_total.flatten
  end

  def average_invoices_per_merchant

    id_array = @mr.merchant_list.map {|merchant| merchant.id}

    invoice_total = invoices_per_merchant_list(id_array)

    invoice_sum = invoice_total.reduce(0) do |sum, num|
        sum + num
    end

    (invoice_sum.to_f / id_array.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation

    id_array = @mr.merchant_list.map {|merchant| merchant.id}
    invoice_total = invoices_per_merchant_list(id_array)

    mean = average_invoices_per_merchant

    standard_deviation(invoice_total, mean)


  end

  def top_merchants_by_invoice_count

    id_array = @mr.merchant_list.map {|merchant| merchant.id}
    invoice_total = invoices_per_merchant_list(id_array)

    mean = average_invoices_per_merchant
    std = average_invoices_per_merchant_standard_deviation

    top_merchant_list = invoice_total.map.with_index do |invoice_num, index|
      @mr.merchant_list[index] if invoice_num >= (mean + (std*2))
    end

    top_merchant_list.compact
  end

  def bottom_merchants_by_invoice_count
    id_array = @mr.merchant_list.map {|merchant| merchant.id}
    invoice_total = invoices_per_merchant_list(id_array)

    mean = average_invoices_per_merchant
    std = average_invoices_per_merchant_standard_deviation

    top_merchant_list = invoice_total.map.with_index do |invoice_num, index|
      @mr.merchant_list[index] if invoice_num <= (mean - (std*2))
    end

    top_merchant_list.compact
  end

  def top_days_by_invoice_count

    created_at_list = @ivr.invoice_list.map {|invoice| day_of_the_week[invoice.created_at.wday]}

    day_counter = created_at_list.reduce(Hash.new(0)) do |output, day|
      output[day] += 1
      output
    end

    set = day_counter.values

    day_sum = set.reduce(0) do |sum, num|
      sum + num
    end

    mean = day_sum / 7.0

    std = standard_deviation(set, mean)

    threshold = mean + std

    top_day_list = day_counter.map do |key, value|
      key if value >= threshold
    end

    top_day_list.compact

  end

  def invoice_status(key)
    status_list = @ivr.invoice_list.map {|invoice| invoice.status }

    status_counter = status_list.reduce(Hash.new(0)) do |output, status|
      output[status.to_sym] += 1
      output
    end


    ((status_counter[key].to_f / status_counter.values.reduce(:+)) * 100).round(2)

  end



end
