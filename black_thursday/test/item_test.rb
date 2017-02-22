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

  end

end
