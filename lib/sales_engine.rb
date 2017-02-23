require 'pry'
require 'csv'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/item'
require './lib/item_repository'

class SalesEngine
  attr_reader :merchant_raw_data, :item_raw_data, :items, :merchants
  def initialize(paths)
    @merchant_raw_data = CSV.open(paths[:merchants], headers: true)
    @item_raw_data = CSV.open(paths[:items], headers: true)
  end

  def self.from_csv(paths)
    SalesEngine.new(paths)
  end

  def merchants
    @merchants ||= MerchantRepository.new(merchant_raw_data, self)
  end

  def items
    @items ||= ItemRepository.new(item_raw_data, self)
  end
end



    # @mr_hash = Hash.new
    # @ir_hash = Hash.new
    #
    # merchants = CSV.foreach(paths[:merchants], headers: true) do |line|
    #   m = Merchant.new({:id => line["id"],
    #     :name => line["name"],
    #     :created_at => line["created_at"],
    #     :updated_at => line["updated_at"]
    #     })
    #   @mr_hash[line["id"]] = m
    #
    # end
    #
    # items = CSV.foreach(paths[:items], headers: true) do |line|
    #   i = Item.new({:id => line["id"],
    #     :merchant_id => line["merchant_id"],
    #     :name => line["name"],
    #     :description => line["description"],
    #     :unit_price => line["unit_price"],
    #     :created_at => line["created_at"],
    #     :updated_at => line["updated_at"]
    #     })
    #   @ir_hash[line["id"]] = i
    # end
    # self
