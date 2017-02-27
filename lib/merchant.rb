require 'pry'

class Merchant
attr_reader :name, :id

  def initialize(merchant_data, parent)
    @name = merchant_data["name"]
    @id = merchant_data["id"].to_i
    @parent = parent
  end

  def items
    @parent.parent.items.item_list.find_all do |item|
      item.merchant_id == @id
    end
  end

  def invoices
    @parent.parent.invoices.invoice_list.find_all do |invoice|
      invoice.merchant_id == @id
    end
  end

  def customers
    invoices = @parent.parent.invoices.find_all_by_merchant_id(@id)
    invoice_customer_ids = invoices.map {|item| item.customer_id}.uniq
    invoice_customer_ids.map do |id|
      @parent.parent.customers.find_by_id(id)
    end
  end

end
