require 'pry'
require_relative '../lib/stats_calculator'
require_relative '../lib/merchant_analytics'
require_relative '../lib/item_analytics'
require_relative '../lib/invoice_analytics'
require_relative '../lib/customer_analytics'

class SalesAnalyst
  include StatsCalculator
  include MerchantAnalytics
  include ItemAnalytics
  include InvoiceAnalytics
  include CustomerAnalytics

  attr_reader :mr, :il, :ivr, :iil, :se, :cr, :iir, :ivl, :ir,
  :valid_invoice_items, :customer_list, :total_spent

  def initialize(se)
    @se = se
    @mr = se.merchants
    @ir = se.items
    @il = ir.item_list
    @ivr = se.invoices
    @ivl = ivr.invoice_list
    @iir = se.invoice_items
    @iil = iir.invoice_item_list
    @cr = se.customers
    @valid_invoice_items = iil.find_all do |item|
      se.invoices.find_by_id(item.invoice_id).is_paid_in_full?
    end
    @customer_list = @valid_invoice_items.map do |item|
      ivr.find_by_id(item.invoice_id).customer
    end
    @total_spent = @valid_invoice_items.map(&:revenue)
  end

  def valid_invoice_items

  end

end
