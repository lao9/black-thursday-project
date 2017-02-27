require 'pry'
require 'time'
require 'bigdecimal'

class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity,
  :unit_price, :created_at, :updated_at
  def initialize(invoice_item_data, parent)
    @id = invoice_item_data["id"].to_i
    @item_id = invoice_item_data["item_id"].to_i
    @invoice_id = invoice_item_data["invoice_id"].to_i
    @quantity = invoice_item_data["quantity"].to_i
    @unit_price = BigDecimal.new(invoice_item_data["unit_price"]) / 100
    @created_at = Time.parse(invoice_item_data["created_at"])
    @updated_at = Time.parse(invoice_item_data["updated_at"])
    @parent = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
