module TestSetup

  def sales_engine_setup
    SalesEngine.from_csv({
      :items => "./test_fixtures/items_test_fixture.csv",
      :merchants => "./test_fixtures/merchants_test_fixture.csv",
      :invoices => "./test_fixtures/invoices_test_fixture.csv",
      :invoice_items => "./test_fixtures/invoice_items_test_fixture.csv"
      # :transactions => "./test_fixtures/transactions_test_fixture.csv",
      # :customers => "./test_fixtures/customers_test_fixtures.cvs"
      })
  end
end
