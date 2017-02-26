require_relative '../test/test_setup'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class MerchantRepositoryTest < Minitest::Test

  include TestSetup

  def setup
    se = sales_engine_setup
    @mr = se.merchants
  end

  def test_all
    assert_instance_of Array, @mr.all
    assert_equal 8, @mr.all.count
    assert_instance_of Merchant, @mr.all.first
  end

  def test_find_by_id
    assert_instance_of Merchant, @mr.find_by_id(12334105)
    assert_equal 12334105, @mr.find_by_id(12334105).id
    assert_equal 'Shopin1901', @mr.find_by_id(12334105).name
    assert_nil @mr.find_by_id(000000)
  end

  def test_find_by_name
    assert_instance_of Merchant, @mr.find_by_name('Shopin1901')
    assert_equal 12334105, @mr.find_by_name('Shopin1901').id
    assert_equal 'Shopin1901', @mr.find_by_name('Shopin1901').name
    assert_nil @mr.find_by_name('fakename')
    assert_equal 'Shopin1901', @mr.find_by_name('SHOPIN1901').name
  end

  def test_find_all_by_name
    assert_equal [], @mr.find_all_by_name('poohead')
    assert_equal 3, @mr.find_all_by_name('shop').count
    assert_equal 3, @mr.find_all_by_name('SHOP').count
  end

end
