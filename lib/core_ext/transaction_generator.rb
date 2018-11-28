module TransactionGenerator
  def self.perform(invoice)
    node = Nem::Node.new(host: '13.113.197.44')
    endpoint = Nem::Endpoint::Transaction.new(node)
    kp = Nem::Keypair.new(ENV['NEM_PRIVATE_KEY'])

    encode_data = Digest::SHA2.new(256).hexdigest invoice.hash_data
    tx = Nem::Transaction::Transfer.new('TANXDSNMIMXHOD3IK7I556KPTDXFYBRNEQTTOY7K', 0, encode_data)

    req = Nem::Request::Announce.new(tx, kp)
    res = endpoint.announce(req)

    invoice.update_column(:transaction_id, res.transaction_hash)
  end
end
