require '.lib/item'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'pry'

class ItemTest < Minitest::Test

  def setup
    @i = Item.new({
      :id => 123456789
      :merchant_id => 987654321
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.new(2017, 02, 22, 10, 0, 0, "-07:00"),
      :updated_at  => Time.new(2017, 02, 22, 10, 0, 0, "-07:00"),
      })
  end

  def test_it_exists
    assert_instance_of Item, @i
  end

  def test_it_returns_id
    assert_equal 123456789, @i.id
  end

  def test_it_returns_a_name
    assert_equal "Pencil", @i.name
  end

  def test_it_returns_a_description
    assert_equal "You can use it to write things", @i.description
  end

  def test_it_returns_a_unit_price_in_big_decimal
    assert_equal BigDecimal.new(10.99,4), @i.unit_price
    assert_instance_of BigDecimal, @i.unit_price
    assert_equal 10.99, @i.unit_price.to_f
  end

  def test_it_returns_a_created_at_time_instance
      assert_equal Time.new(2017, 02, 22, 10, 0, 0, "-07:00"), @i.created_at
      assert_instance_of Time, @i.created_at
  end

  def test_it_returns_an_updated_at_time_instance
    assert_equal Time.new(2017, 02, 22, 10, 0, 0, "-07:00"), @i.updated_at
    assert_instance_of Time, @i.updated_at
  end

  def test_it_returns_a_merchant_id
    assert_equal 987654321, @i.merchant_id
  end

  def test_it_returns_the_price_of_an_item_in_dollars_as_float
    assert_equal 10.99, @i.unit_price_to_dollars
    assert_instance_of Float, @i.unit_price_to_dollars  
  end

end
