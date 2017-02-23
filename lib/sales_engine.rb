require 'pry'
require 'csv'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/item'
require './lib/item_repository'

class SalesEngine

  def self.from_csv(path_hash)
    @mr_hash = Hash.new
    @ir_hash = Hash.new

    merchants = CSV.foreach(path_hash[:merchants], headers: true) do |line|
      m = Merchant.new({:id => line["id"],
        :name => line["name"],
        :created_at => line["created_at"],
        :updated_at => line["updated_at"]
        })
      @mr_hash[line["id"]] = m

    end

    items = CSV.foreach(path_hash[:items], headers: true) do |line|
      i = Item.new({:id => line["id"],
        :merchant_id => line["merchant_id"],
        :name => line["name"],
        :description => line["description"],
        :unit_price => line["unit_price"],
        :created_at => line["created_at"],
        :updated_at => line["updated_at"]
        })
      @ir_hash[line["id"]] = i
    end
    self
  end

  def self.merchants
    MerchantRepository.new(@mr_hash)
  end

  def self.items
    ItemRepository.new(@ir_hash)
  end
end
