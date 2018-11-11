module TransactionGenerator
  def self.perform(invoice, account)
    node = Nem::Node.new(host: '13.113.197.44')
    endpoint = Nem::Endpoint::Transaction.new(node)
    # kp = Nem::Keypair.new(account.private_key)
    kp = Nem::Keypair.new('94b5851eb05425315955e73e6cee5561ab4e0f8cc66994556e308c20332e73b4')

    encode_data = Digest::SHA2.new(256).hexdigest invoice.hash_data
    tx = Nem::Transaction::Transfer.new('TANXDSNMIMXHOD3IK7I556KPTDXFYBRNEQTTOY7K', 0, encode_data)

    req = Nem::Request::Announce.new(tx, kp)
    res = endpoint.announce(req)

    invoice.update(transaction_id: res.transaction_hash)
  end
end
