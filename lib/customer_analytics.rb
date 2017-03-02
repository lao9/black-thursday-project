
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

    # hey = valid_invoices.map.with_index do |invoice, index|
    #   if customer_list[index].id == customer_id
    #     mr.find_by_id(mr.parent.items.find_by_id(valid_invoices.first.item_id).merchant_id)
    #   end
    # end
    #
    # heyo = hey.compact
    meh = merchant_array.each.with_index.reduce(Hash.new(0)) do |sum, (merchant, index)|
      sum[merchant] = merchant_quantity_revenue[index]
      sum
    end

    

    max_merchant = meh.max_by do |key, value|
      value
    end

    max_merchant[0]

  end

end
