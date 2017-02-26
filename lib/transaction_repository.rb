class TransactionRepository

  attr_reader :transaction_list, :parent

  def initialize(raw_transaction_data, parent)
    @transaction_list = raw_transaction_data.map { |line| Transaction.new(line, self) }
    @parent = parent
  end

  def all
    @transaction_list
  end

end
