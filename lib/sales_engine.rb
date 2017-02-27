require 'pry'
require 'csv'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'

class SalesEngine
  attr_reader :merchant_raw_data, :item_raw_data, :invoice_raw_data,
  :invoice_item_raw_data, :transaction_raw_data, :customer_raw_data, :items,
  :merchants, :invoices, :invoice_items,:transactions, :customers

  def initialize(paths)
    @merchant_raw_data = CSV.open(paths[:merchants], headers: true)
    @item_raw_data = CSV.open(paths[:items], headers: true)
    @invoice_raw_data = CSV.open(paths[:invoices], headers: true)
    @transaction_raw_data = CSV.open(paths[:transactions], headers: true)
    @invoice_item_raw_data = CSV.open(paths[:invoice_items], headers: true)
    @customer_raw_data = CSV.open(paths[:customers], headers: true)
  end

  def self.from_csv(paths)
    SalesEngine.new(paths)
  end

  def merchants
    @merchants ||= MerchantRepository.new(merchant_raw_data, self)
  end

  def items
    @items ||= ItemRepository.new(item_raw_data, self)
  end

  def invoices
    @invoices ||= InvoiceRepository.new(invoice_raw_data, self)
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepository.new(invoice_item_raw_data, self)
  end

  def transactions
    @transactions ||= TransactionRepository.new(transaction_raw_data, self)
  end

  def customers
    @customers ||= CustomerRepository.new(customer_raw_data, self)
  end

end
