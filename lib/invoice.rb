require 'pry'
require 'time'
require 'bigdecimal'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  def initialize(invoice_data, parent)
    @id = invoice_data["id"].to_i
    @customer_id = invoice_data["customer_id"].to_i
    @merchant_id = invoice_data["merchant_id"].to_i
    @status = invoice_data["status"].to_sym
    @created_at = Time.parse(invoice_data["created_at"])
    @updated_at = Time.parse(invoice_data["updated_at"])
    @parent = parent
  end

  def merchant
    @parent.parent.merchants.merchant_list.find do |merchant|
      @merchant_id == merchant.id
    end
  end

  def items
    invoice_items = @parent.parent.invoice_items.find_all_by_invoice_id(@id)
    invoice_item_ids = invoice_items.map {|item| item.item_id}
    invoice_item_ids.map do |id|
      @parent.parent.items.find_by_id(id)
    end
  end

  def transactions
    @parent.parent.transactions.find_all_by_invoice_id(@id)
  end

  def customer
    @parent.parent.customers.find_by_id(@customer_id)
  end

  def is_paid_in_full?
    transactions = @parent.parent.transactions.find_all_by_invoice_id(@id)
    results = transactions.map {|transaction| transaction.result}
    !(results.empty? || results.include?("failed"))
  end

  def total
    if is_paid_in_full?
      invoice_items = @parent.parent.invoice_items.find_all_by_invoice_id(@id)
      invoice_items.reduce(0) do |sum, item|
        sum + (item.quantity * item.unit_price)
      end
    else
      BigDecimal(0)
    end
  end

end
