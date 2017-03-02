require 'pry'
require 'bigdecimal'

class ItemRepository
  attr_reader :item_list, :parent
  def initialize(raw_item_data, parent)
    @item_list = raw_item_data.map { |line| Item.new(line, self) }
    @parent = parent
  end

  def inspect
   "#<#{self.class} #{all.size} rows>"
  end

  def all
      @item_list
  end

  def find_by_id(id)
    @item_list.find { |item| item.id == id }
  end

  def find_by_name(name)
    @item_list.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(description_snippet)
    @item_list.find_all do |item|
      item.description.downcase.include?(description_snippet.downcase)
    end
  end

  def find_all_by_price(price)
    @item_list.find_all do |item|
     item.unit_price == price
   end
  end

  def find_all_by_price_in_range(range)
    @item_list.find_all do |item|
      (range).member?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id_lookup)
    @item_list.find_all do |item|
      item.merchant_id == merchant_id_lookup
    end
  end

end
