require_relative "../test/test_helper"

class CustomerAnalyticsTest < Minitest::Test

  include TestSetup
  include CustomerAnalytics

  def setup
    @sa = SalesAnalyst.new
  end

  def test_it_finds_the_top_buyers
    assert_instance_of Array, @sa.top_buyers(3)
    assert_equal 3, @sa.top_buyers(3).count
    assert_instance_of Customer, @sa.top_buyers(3).first
    assert_equal 1, @sa.top_buyers(3).first.id
    assert_equal 3, @sa.top_buyers(3).last.id
  end

  def test_it_defaults_the_top_20_buyers
    assert_instance_of Array, @sa.top_buyers
    assert_equal 6, @sa.top_buyers.count
    assert_instance_of Customer, @sa.top_buyers.first
    assert_equal 6, @sa.top_buyers.last.id
  end

  def test_it_returns_the_top_merchant
    assert_instance_of Merchant, @sa.top_merchant_for_customer(customer_id)
    assert_equal 12334178, @sa.top_merchant_for_customer(customer_id).id
    assert_equal "NatalieWoolSocks", @sa.top_merchant_for_customer(customer_id).name
  end

  def test_it_returns_one_time_buyers
    assert_instance_of Array, @sa.one_time_buyers
    assert_equal 1, @sa.one_time_buyers.count
    assert_instance_of Customer, @sa.one_time_buyers.first
    assert_equal 6, @sa.one_time_buyers.first.id
  end

end
