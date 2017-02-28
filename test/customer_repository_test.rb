require_relative '../test/test_helper'

class CustomerRepositoryTest < Minitest::Test

  include TestSetup

  def setup
    se = sales_engine_setup
    @cr = se.customers
  end

  def test_all
    assert_instance_of Array, @cr.all
    assert_equal 100, @cr.all.count
    assert_instance_of Customer, @cr.all.first
  end

  def test_find_by_id
    assert_instance_of Customer, @cr.find_by_id(12)
    assert_equal 12, @cr.find_by_id(12).id
    assert_equal 'Ilene', @cr.find_by_id(12).first_name
    assert_equal 'Pfannerstill', @cr.find_by_id(12).last_name
    assert_nil @cr.find_by_id(000000)
  end

  def test_find_all_by_first_name
    assert_instance_of Array, @cr.find_all_by_first_name('DAPHNEE')
    assert_equal 1, @cr.find_all_by_first_name('DAPHNEE').count
    assert_equal 92, @cr.find_all_by_first_name('DAPHNEE').first.id
    assert_equal 8, @cr.find_all_by_first_name('an').count
    assert_equal 8, @cr.find_all_by_first_name('AN').count
    assert_equal [], @cr.find_all_by_first_name('fakename')
  end

  def test_find_all_by_last_name
    assert_instance_of Array, @cr.find_all_by_last_name('dickens')
    assert_equal 2, @cr.find_all_by_last_name('dickens').count
    assert_equal 46, @cr.find_all_by_last_name('dickens').first.id
    assert_equal 67, @cr.find_all_by_last_name('dickens').last.id
    assert_equal 3, @cr.find_all_by_last_name('pfannerstill').count
    assert_equal [], @cr.find_all_by_last_name('fakename')
  end

end
