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

  attr_reader :mr, :merchant_id_list, :item_quantity_per_merchant,
  :items_per_merchant_list, :items, :ivr, :invoice_total,
  :invoice_mean, :invoice_std, :iil, :valid_invoices, :customer_list

  def initialize(se)
    @mr = se.merchants
    @merchant_id_list = create_merchant_id_list
    @item_quantity_per_merchant = group_ids_by_quantity
    @items_per_merchant_list = map_by_quantity(item_quantity_per_merchant)
    @items = @mr.parent.items.item_list
    @ivr = se.invoices
    @invoice_total = invoices_per_merchant_list(merchant_id_list)
    @invoice_mean = calculate_average(invoice_total)
    @invoice_std = standard_deviation(invoice_total)
    @iil = se.invoice_items.invoice_item_list
    @valid_invoices = iil.find_all { |item|
      se.invoices.find_by_id(item.invoice_id).is_paid_in_full? }
    @customer_list = valid_invoices.map do |item|
        mr.parent.invoices.find_by_id(item.invoice_id).customer
      end
  end

end
