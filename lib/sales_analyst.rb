require 'pry'
require_relative '../lib/stats_calculator'
require_relative '../lib/merchant_analytics'
require_relative '../lib/item_analytics'
require_relative '../lib/invoice_analytics'

class SalesAnalyst
  include StatsCalculator
  include MerchantAnalytics
  include ItemAnalytics
  include InvoiceAnalytics

  attr_reader :mr, :merchant_id_list, :item_quantity_per_merchant,
  :items_per_merchant_list, :items, :ivr, :invoice_total,
  :invoice_mean, :invoice_std

  def initialize(se)
    @mr = se.merchants
    @merchant_id_list = create_merchant_id_list
    @item_quantity_per_merchant = group_ids_by_quantity
    @items_per_merchant_list = map_by_quantity(item_quantity_per_merchant)
    @items = @mr.parent.items.item_list
    @ivr = se.invoices
    @invoice_total = invoices_per_merchant_list(merchant_id_list)
    @invoice_mean = calculate_average(invoice_total)
    @invoice_std = standard_deviation(invoice_total, invoice_mean)
  end

end
