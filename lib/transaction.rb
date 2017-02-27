require 'time'

class Transaction

  attr_reader :id, :invoice_id, :credit_card_number,
  :credit_card_expiration_date, :result, :created_at, :updated_at

  def initialize(transact_data, parent)
    @id = transact_data["id"].to_i
    @invoice_id = transact_data["invoice_id"].to_i
    @credit_card_number = transact_data["credit_card_number"].to_i
    @credit_card_expiration_date = transact_data["credit_card_expiration_date"]
    @result = transact_data["result"]
    @created_at = Time.parse(transact_data["created_at"])
    @updated_at = Time.parse(transact_data["updated_at"])
    @parent = parent
  end
end
