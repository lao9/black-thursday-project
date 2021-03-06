require_relative '../test/test_helper'

class MerchantTest < Minitest::Test

  def setup
    @m = Merchant.new({
      "id" => '5',
      "name" => 'Turing School'
      }, "parent")
  end

  def test_it_exists
    assert_instance_of Merchant, @m
  end

  def test_it_has_a_name
    assert_equal "Turing School", @m.name
  end

  def test_it_has_an_id
    assert_equal 5, @m.id
  end


end
