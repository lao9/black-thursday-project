require 'pry'
require 'bigdecimal'
require 'time'

class InvoiceItemRepository
  attr_reader :invoice_item_list, :parent
  def initialize(raw_invoice_item_data, parent)
    @invoice_item_list = raw_invoice_item_data.map do |line|
      InvoiceItem.new(line, self)
    end
    @parent = parent
  end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @invoice_item_list
  end

  def find_by_id(id)
    @invoice_item_list.find { |invoice| invoice.id == id }
  end

  def find_all_by_item_id(item_id)
    @invoice_item_list.find_all do |invoice|
      invoice.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_item_list.find_all do |invoice|
      invoice.invoice_id == invoice_id
    end
  end

end
