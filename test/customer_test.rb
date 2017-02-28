require_relative '../test/test_helper'

class CustomerTest < Minitest::Test

  def setup
    @c = Customer.new({
      "id"          => "1",
      "first_name"  => "Joey",
      "last_name"   => "Ondiricka",
      "created_at"  => "1980-11-23 09:11:30 UTC",
      "updated_at"  => "1980-11-23 09:11:30 UTC",
      }, "parent")
  end

  def test_it_exists
    assert_instance_of Customer, @c
  end

  def test_it_returns_id
    assert_equal 1, @c.id
  end

  def test_it_returns_a_first_name
    assert_equal "Joey", @c.first_name
  end

  def test_it_returns_a_last_name
    assert_equal "Ondiricka", @c.last_name
  end

  def test_it_returns_a_created_at_time_instance
    assert_equal Time.new(1980, 11, 23, 9, 11, 30, 0000).utc, @c.created_at
    assert_instance_of Time, @c.created_at
  end

  def test_it_returns_an_updated_at_time_instance
    assert_equal Time.new(1980, 11, 23, 9, 11, 30, 0000).utc, @c.updated_at
    assert_instance_of Time, @c.updated_at
  end
end
