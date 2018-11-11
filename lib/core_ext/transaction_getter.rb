module TransactionGetter
  def self.perform(transaction_id)
    node = Nem::Node.new(host: 'bigalice2.nem.ninja')
    endpoint = Nem::Endpoint::Transaction.new(node)

    tx = endpoint.find(transaction_id)
    Decoder.perform(tx.message.value)
  end
end
