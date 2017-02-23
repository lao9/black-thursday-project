require 'pry'

class MerchantRepository
  def initialize(hash)
    @mr_hash = hash
  end

  def all
    @mr_hash.values
  end

  def find_by_id(id)
    @mr_hash[id.to_s]
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
