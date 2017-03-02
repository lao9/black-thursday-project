require 'time'

class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at
  def initialize(customer_data, parent)
    @id = customer_data["id"].to_i
    @first_name = customer_data["first_name"]
    @last_name = customer_data["last_name"]
    @created_at = Time.parse(customer_data["created_at"])
    @updated_at = Time.parse(customer_data["updated_at"])
    @parent = parent
  end

  def merchants
    invoices = @parent.parent.invoices.find_all_by_customer_id(@id)
    invoice_merchant_ids = invoices.map {|item| item.merchant_id}.uniq
    invoice_merchant_ids.map do |id|
      @parent.parent.merchants.find_by_id(id)
    end
  end

  def fully_paid_invoices
    invoices = @parent.parent.invoices.find_all_by_customer_id(@id)
    invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end
  end

end
