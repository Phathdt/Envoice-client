class Admin::AccountService
  class << self
    def generate_account
      node = Nem::Node.new(host: '127.0.0.1')
      endpoint = Nem::Endpoint::Account.new(node)
      endpoint.generate
    end
  end
end
