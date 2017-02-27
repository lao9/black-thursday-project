require 'pry'

class CustomerRepository
  attr_reader :customer_list, :parent
  def initialize(raw_customer_data, parent)
    @customer_list = raw_customer_data.map { |line| Customer.new(line, self) }
    @parent = parent
  end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @customer_list
  end

  def find_by_id(id)
    @customer_list.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(name_snippet)
    @customer_list.find_all do |customer|
      customer.first_name.downcase.include?(name_snippet.downcase)
    end
  end

  def find_all_by_last_name(name_snippet)
    @customer_list.find_all do |customer|
      customer.last_name.downcase.include?(name_snippet.downcase)
    end
  end

end
