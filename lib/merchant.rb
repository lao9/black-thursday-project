require 'pry'

class Merchant
attr_reader :name, :id

  def initialize(merchant_data, parent)
    @name = merchant_data["name"]
    @id = merchant_data["id"].to_i
    @parent = parent
  end

  def items
    @parent.parent.items.item_list.find_all do |item|
      item.merchant_id == @id
    end
  end

end
