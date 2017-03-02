
module CustomerAnalytics

  def top_buyers(num=20)

    total_spent = valid_invoices.map { |item| item.quantity * item.unit_price }

    top_buyers = total_spent.each.with_index.reduce(Hash.new(0)) do |sum, (money, index)|
      sum[customer_list[index]] += money
      sum
    end

    top_buyer_list = []

    num = top_buyers.keys.count if top_buyers.keys.count < num

    num.times do
      max_spender = top_buyers.max_by do |key, value|
        value
      end
      top_buyer_list << max_spender[0]
      top_buyers.delete(max_spender[0])
    end

    top_buyer_list

  end

  def top_merchant_for_customer(customer_id)

    invoices = mr.parent.invoices.find_all_by_customer_id(customer_id)

    valid_invoices_v2 = invoices.find_all { |invoice| invoice.is_paid_in_full? }

    merchant_array = valid_invoices_v2.map do |invoice|
      mr.find_by_id(invoice.merchant_id)
    end

     merchant_quantity_revenue = valid_invoices_v2.map do |invoice|
      mr.parent.invoice_items.find_all_by_invoice_id(invoice.id).reduce(0) do |sum, item|
        sum + item.quantity
      end
    end

    meh = merchant_array.each.with_index.reduce(Hash.new(0)) do |sum, (merchant, index)|
      sum[merchant] = merchant_quantity_revenue[index]
      sum
    end

    max_merchant = meh.max_by do |key, value|
      value
    end

    max_merchant[0]

  end

  def one_time_buyers
    invoices = mr.parent.invoices.invoice_list

    valid_invoices = invoices.find_all { |invoice| invoice.is_paid_in_full? }

    customer_grouper = valid_invoices.group_by do |invoice|
      invoice.customer_id
    end

    one_timers = customer_grouper.values.find_all do |value|
      value.count == 1
    end

    one_timers.flatten.map do |invoice|
      invoice.customer
    end

  end

  def one_time_buyers_items

    invoices = mr.parent.invoices.invoice_list

    valid_invoices = invoices.find_all { |invoice| invoice.is_paid_in_full? }

    customer_grouper = valid_invoices.group_by do |invoice|
      invoice.customer_id
    end

    one_timers = customer_grouper.values.find_all do |value|
      value.count == 1
    end

    one_timers = one_timers.flatten

    invoice_items_list = one_timers.map do |invoice|
      mr.parent.invoice_items.find_all_by_invoice_id(invoice.id)
    end

    item_list_v2 = invoice_items_list.flatten.each.with_index.reduce(Hash.new(0)) do |sum, (item, index)|
      sum[mr.parent.items.find_by_id(item.item_id)] += item.quantity
      sum
    end

    maximum_item = item_list_v2.values.max

    max_item = item_list_v2.find_all do |key, value|
      value == maximum_item
    end

  end

  def items_bought_in_year(customer_id, year)

    invoices = ivr.find_all_by_customer_id(customer_id).find_all do |invoice|
      invoice.created_at.year == year
    end

    items = invoices.map do |invoice|
      invoice.items
    end

    items.flatten

  end

  def highest_volume_items(customer_id)

    invoice_items = ivr.find_all_by_customer_id(customer_id).map do |invoice|
      mr.parent.invoice_items.find_all_by_invoice_id(invoice.id)
    end

    invoice_items = invoice_items.flatten

    quantities = invoice_items.map do |invoice_item|
      invoice_item.quantity
    end

    max_quant = quantities.max

    max_invoice_items = invoice_items.find_all do |invoice_item|
      invoice_item.quantity == max_quant
    end

    max_items = max_invoice_items.map do |invoice_item|
      mr.parent.items.find_by_id(invoice_item.item_id)
    end


  end

  def customers_with_unpaid_invoices

    unpaid_invoices = ivr.invoice_list.find_all do |invoice|
      invoice.is_paid_in_full? == false
    end

    customer_list = unpaid_invoices.map do |invoice|
      invoice.customer
    end

    customer_list.uniq

  end

  def best_invoice_by_revenue
    
    invoice_items = ivr.parent.invoice_items.invoice_item_list

    revenue_items = invoice_items.map do |invoice_item|
      # if ivr.find_by_id(invoice_item.invoice_id).is_paid_in_full?
        (invoice_item.quantity * invoice_item.unit_price)
      # end
    end

    #revenue_items = revenue_items.compact

    revenue_hash = revenue_items.each.with_index.reduce(Hash.new(0)) do |sum, (revenue, index)|
      sum[ivr.find_by_id(invoice_items[index].invoice_id)] += revenue
      sum
    end


    loop do
      output = revenue_hash.max_by do |invoice_item, revenue|
        revenue
      end

      if output[0].is_paid_in_full? == false
        revenue_hash.delete(output[0])
      else
        break
      end
    end

    output = revenue_hash.max_by do |invoice_item, revenue|
      revenue
    end

    output[0]
    #
    # invoice_items = ivr.parent.invoice_items.invoice_item_list
    #
    # revenue_items = invoice_items.map do |invoice_item|
    #   if ivr.find_by_id(invoice_item.invoice_id).is_paid_in_full?
    #     (invoice_item.quantity * invoice_item.unit_price)
    #   end
    # end
    #
    # revenue_hash = revenue_items.compact.each.with_index.reduce(Hash.new(0)) do |sum, (money, index)|
    #   sum[invoice_items[index]] += money
    #   sum
    # end
    #
    # #binding.pry
    #
    # revenue_max = revenue_hash.values.max
    #
    # hey = revenue_hash.key(revenue_max)
    #
    # ivr.find_by_id(hey.invoice_id)
    #
    # #
    # #
    # # hey = ivr.parent.invoice_items.invoice_item_list.find do |invoice_item|
    # #   (invoice_item.quantity * invoice_item.unit_price) == revenue_max
    # # end
    # #
    # #
    # #


  end

  def best_invoice_by_quantity

    invoice_items = ivr.parent.invoice_items.invoice_item_list

    quantity_items = invoice_items.map do |invoice_item|
      # if ivr.find_by_id(invoice_item.invoice_id).is_paid_in_full?
        invoice_item.quantity
      # end
    end

    quantity_items = quantity_items.compact

    quantity_hash = quantity_items.each.with_index.reduce(Hash.new(0)) do |sum, (quantity, index)|
      sum[ivr.find_by_id(invoice_items[index].invoice_id)] += quantity
      sum
    end


    loop do
      output = quantity_hash.max_by do |invoice_item, quantity|
        quantity
      end

      if output[0].is_paid_in_full? == false
        quantity_hash.delete(output[0])
      else
        break
      end
    end

    output = quantity_hash.max_by do |invoice_item, quantity|
      quantity
    end

    output[0]

  end

end
