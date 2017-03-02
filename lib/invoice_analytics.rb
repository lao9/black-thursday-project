module InvoiceAnalytics

  include StatsCalculator

  def merchant_id_list
    create_merchant_id_list
  end

  def item_quantity_per_merchant
    group_ids_by_quantity
  end

  def items_per_merchant_list
    map_by_quantity(item_quantity_per_merchant)
  end

  def invoice_total
    invoices_per_merchant_list(merchant_id_list)
  end

  def invoices_per_merchant_list(id_list)
    invoices_grouper = id_list.group_by do |merchant_id|
      mr.find_by_id(merchant_id).invoices.count
    end
    map_by_quantity(invoices_grouper)
  end

  def invoice_mean
    calculate_average(invoice_total)
  end

  def average_invoices_per_merchant
    invoice_mean
  end

  def invoice_std
    standard_deviation(invoice_total)
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_std
  end

  def top_merchants_by_invoice_count
    threshold = invoice_mean + (invoice_std * 2)
    top_merchant_list = invoice_total.map.with_index do |invoice_num, index|
      mr.merchant_list[index] if invoice_num >= threshold
    end
    top_merchant_list.compact
  end

  def bottom_merchants_by_invoice_count
    threshold = invoice_mean - (invoice_std * 2)
    btm_merchant_list = invoice_total.map.with_index do |invoice_num, index|
      mr.merchant_list[index] if invoice_num <= threshold
    end
    btm_merchant_list.compact
  end

  def top_days_by_invoice_count
    created_at_list = ivr.invoice_list.map do |invoice|
      day_of_the_week[invoice.created_at.wday]
    end
    day_counter = unique_element_counter(created_at_list)
    set = day_counter.values
    mean = calculate_average(set, 7)
    std = standard_deviation(set, mean)
    threshold = mean + std
    compare_list_to_stdev_threshold(day_counter, threshold)
  end

  def invoice_status(key)
    status_list = ivr.invoice_list.map {|invoice| invoice.status }
    status_counter = unique_element_counter(status_list, true)
    numer = status_counter[key].to_f
    denom = status_counter.values.reduce(:+)
    ((numer / denom) * 100).round(2)
  end

end
