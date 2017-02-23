class Merchant
attr_reader :name, :id

  def initialize(merchant_data, parent)
    @name = merchant_data["name"]
    @id = merchant_data["id"].to_i
    @parent = parent
  end

end
