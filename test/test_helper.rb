require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'bigdecimal'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require_relative '../lib/invoice'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_repository'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'

module TestSetup

  def sales_engine_setup
    SalesEngine.from_csv({
      :items => "./test_fixtures/items_test_fixture.csv",
      :merchants => "./test_fixtures/merchants_test_fixture.csv",
      :invoices => "./test_fixtures/invoices_test_fixture.csv",
      :invoice_items => "./test_fixtures/invoice_items_test_fixture.csv",
      :transactions => "./test_fixtures/transactions_test_fixture.csv",
      :customers => "./test_fixtures/customers_test_fixture.csv"
      })
  end

end
