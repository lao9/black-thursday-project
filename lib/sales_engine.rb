require 'pry'
require 'csv'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/item'
require './lib/item_repository'

class SalesEngine
  attr_reader :merchant_csv
  def initialize(path_hash)
    @merchant_csv = CSV.open(path_hash[:merchants], headers: true)
    @item_csv = CSV.open(path_hash[:items], headers: true)
  end

  def self.from_csv(path_hash)

    SalesEngine.new(path_hash)


    # @mr_hash = Hash.new
    # @ir_hash = Hash.new
    #
    # merchants = CSV.foreach(path_hash[:merchants], headers: true) do |line|
    #   m = Merchant.new({:id => line["id"],
    #     :name => line["name"],
    #     :created_at => line["created_at"],
    #     :updated_at => line["updated_at"]
    #     })
    #   @mr_hash[line["id"]] = m
    #
    # end
    #
    # items = CSV.foreach(path_hash[:items], headers: true) do |line|
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
  end

  def merchants
    MerchantRepository.new(merchant_csv, self)
  end

  def items
    ItemRepository.new(item_csv, self)
  end
end
