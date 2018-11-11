admin = User.create(email: 'owner@envoice.com', password: '123456', name: 'Owner', role: 1)

Company.new.save(validate: false)
