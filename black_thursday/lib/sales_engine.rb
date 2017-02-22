require 'pry'
require 'csv'
require './lib/merchant'
require './lib/merchant_repository'

class SalesEngine

  def initialize
    @mr_hash = Hash.new(0)
  end

  def from_csv(path_hash)

    merchants = CSV.foreach(path_hash[:merchants], headers: true) do |line|
      m = Merchant.new({:id => line["id"],
        :name => line["name"],
        :created_at => line["created_at"],
        :updated_at => line["updated_at"]
        })
      @mr_hash[line["id"]] = m
    end

  end


  def merchants
    MerchantRepository.new(@mr_hash)
  end

end

#
# episode = {}
# episodes = CSV.foreach(@filename, headers: true) do |line|
#   episode["EPISODE"] = line["EPISODE"]
# end
# episode["EPISODE"]
