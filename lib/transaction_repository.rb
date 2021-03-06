require 'time'

class TransactionRepository

  attr_reader :transaction_list, :parent

  def initialize(raw_transaction_data, parent)
    @transaction_list = raw_transaction_data.map do |line|
      Transaction.new(line, self)
    end
    @parent = parent
  end

  def inspect
   "#<#{self.class} #{all.size} rows>"
  end

  def all
    @transaction_list
  end

  def find_by_id(id)
    @transaction_list.find { |item| item.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    @transaction_list.find_all { |item| item.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transaction_list.find_all do |item|
      item.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    hey = @transaction_list.find_all do |item|
      item.result == result
    end
  end

end
