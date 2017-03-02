require 'pry'

class MerchantRepository
  attr_reader :merchant_list, :parent
  def initialize(raw_merchant_data, parent)
    @merchant_list = raw_merchant_data.map { |line| Merchant.new(line, self) }
    @parent = parent
  end

  def inspect
   "#<#{self.class} #{all.size} rows>"
  end

  def all
    @merchant_list
  end

  def find_by_id(id)
    @merchant_list.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchant_list.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name_snippet)
    @merchant_list.find_all do |merchant|
      merchant.name.downcase.include?(name_snippet.downcase)
    end
  end

end
