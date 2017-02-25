require 'pry'
require 'time'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  def initialize(invoice_data, parent)
    @id = invoice_data["id"].to_i
    @customer_id = invoice_data["customer_id"].to_i
    @merchant_id = invoice_data["merchant_id"].to_i
    @status = invoice_data["status"]
    @created_at = Time.parse(invoice_data["created_at"])
    @updated_at = Time.parse(invoice_data["updated_at"])
    @parent = parent
  end

  def merchant
    @parent.parent.merchants.merchant_list.find do |merchant|
      @merchant_id == merchant.id
    end
  end

end
