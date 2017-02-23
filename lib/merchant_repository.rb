require 'pry'

class MerchantRepository
  def initialize(raw_merchant_data, parent)
    @mr_array = raw_merchant_data.map do |line|
      Merchant.new(line, self)
    end
    binding.pry
    @parent = parent
  end

  def all
    @mr_hash.values
  end

  def find_by_id(id)
    @mr_hash[id]
  end

  def find_by_name(name)
    output = @mr_hash.find do |key, value|
      value.name.downcase == name.downcase
    end
    if output.nil?
      output
    else
      output[1]
    end
  end

  def find_all_by_name(name_snippet)
    output = @mr_hash.find_all do |key, value|
      value.name.downcase.include?(name_snippet.downcase)
    end
    if output.empty?
      output
    else
      output = output.map {|item| item[1]}
    end
  end

end
