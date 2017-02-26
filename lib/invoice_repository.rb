require 'pry'
class InvoiceRepository

  attr_reader :invoice_list, :parent

  def initialize(raw_invoice_data, parent)
    @invoice_list = raw_invoice_data.map { |line| Invoice.new(line, self) }
    @parent = parent
  end
# binding.pry

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @invoice_list
  end

  def find_by_id(id)
    @invoice_list.find { |item| item.id == id }
  end

  def find_all_by_customer_id(customer_id)
    @invoice_list.find_all do |item|
     item.customer_id == id
   end
  end

  def find_all_by_merchant_id(merchant_id_lookup)
    @invoice_list.find_all do |item|
      item.merchant_id == merchant_id_lookup
    end
  end

  def find_all_by_status(status)
    @invoice_list.find_all do |item|
      item.status == status
    end
  end

end
