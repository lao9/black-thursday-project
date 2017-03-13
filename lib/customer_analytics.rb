
module CustomerAnalytics

  def buyer_builder
    total_spent.each.with_index.reduce(Hash.new(0)) do |output, (total, index)|
      output[customer_list[index]] += total
      output
    end
  end

  def top_buyers(num=20)
    buyers = buyer_builder
    top_buyers = buyers.keys.sort_by do |customer|
      buyers[customer]
    end
    num = buyers.keys.count if buyers.keys.count < num
    top_buyers.reverse[0...num]
  end

  def quantity_summer(set)
    set.reduce(0) { |sum, item| sum + item.quantity }
  end

  def merchant_quantity_builder(set, lookup)
    set.each.with_index.reduce(Hash.new(0)) do |sum, (merchant, index)|
      sum[merchant] = lookup[index]
      sum
    end
  end

  def return_top_merchant(quantity_list)
    quantity_list.max_by{|key, value| value}[0]
  end

  def top_merchant_for_customer(customer_id)
    valid_cust_invoices = cr.find_by_id(customer_id).fully_paid_invoices
    merchants = valid_cust_invoices.map(&:merchant)
    merchant_quantity = valid_cust_invoices.map do |invoice|
      quantity_summer(invoice.invoice_items)
    end
    quantity_list = merchant_quantity_builder(merchants, merchant_quantity)
    max_merchant = return_top_merchant(quantity_list)
  end

  def valid_invoices
    ivl.find_all(&:is_paid_in_full?)
  end

  def one_timers
    customer_grouper = valid_invoices.group_by(&:customer_id)
    one_timers = customer_grouper.values.find_all do |value|
      value.count == 1
    end
    one_timers.flatten
  end

  def one_time_buyers
    one_timers.map(&:customer)
  end

  def item_list_builder(set)
    set.each.with_index.reduce(Hash.new(0)) do |sum, (item, index)|
      sum[item.item] += item.quantity
      sum
    end
  end

  def find_all_max(set, max)
    set.find_all do |key, value|
      value == max
    end
  end

  def one_time_buyers_top_items
    buyer_items = one_timers.map(&:invoice_items)
    buyer_item_list = item_list_builder(buyer_items.flatten)
    max = buyer_item_list.values.max
    max_item = find_all_max(buyer_item_list, max)
    max_item.map {|item| item[0]}
  end

  def items_bought_in_year(customer_id, year)
    invoices = ivr.find_all_by_customer_id(customer_id).find_all do |invoice|
      invoice.created_at.year == year
    end
    items = invoices.map(&:items)
    items.flatten
  end

  def customer_invoice_items(customer_id)
    ivr.find_all_by_customer_id(customer_id).map(&:invoice_items)
  end

  def find_all_that_are_max(set, max)
    set.find_all do |item|
      item.quantity == max
    end
  end

  def highest_volume_items(customer_id)
    invoice_items = customer_invoice_items(customer_id).flatten
    quantities = invoice_items.map(&:quantity)
    max_invoice_items = find_all_that_are_max(invoice_items, quantities.max)
    max_items = max_invoice_items.map(&:item)
  end

  def customers_with_unpaid_invoices
    unpaid_invoices = ivl.find_all do |invoice|
      !invoice.is_paid_in_full?
    end
    customer_list = unpaid_invoices.map(&:customer)
    customer_list.uniq
  end

  def quantity_builder(set)
    set.each.with_index.reduce(Hash.new(0)) do |output, (total, index)|
      output[ivr.find_by_id(iil[index].invoice_id)] += total
      output
    end
  end

  def max_quantity_finder(set)
    set.max_by do |invoice_item, quantity|
      quantity
    end
  end

  def best_invoice_by_revenue
    revenue_items = iil.map(&:revenue)
    revenues = quantity_builder(revenue_items)
    output = max_quantity_finder(revenues)
    until output[0].is_paid_in_full?
      revenues.delete(output[0])
      output = max_quantity_finder(revenues)
    end
    output[0]
  end

  def best_invoice_by_quantity
    quantity_items = iil.map(&:quantity)
    quantities = quantity_builder(quantity_items)
    output = max_quantity_finder(quantities)
    until output[0].is_paid_in_full?
      quantities.delete(output[0])
      output = max_quantity_finder(quantities)
    end
    output[0]
  end

end
